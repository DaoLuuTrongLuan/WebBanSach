package com.bookstore.servlet;

import com.bookstore.util.VNPayConfig;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Servlet for Creating VNPAY Payment URL
 * Receives order information and creates payment URL to redirect to VNPAY gateway
 */
@WebServlet("/vnpay/create")
public class VNPayCreateServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("application/json");
            
            // Get order information from request
            String fullname = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String district = request.getParameter("district");
            String shippingMethod = request.getParameter("shipping");
            String orderTotal = request.getParameter("total");
            
            // Validate required fields
            if (fullname == null || fullname.isEmpty() ||
                phone == null || phone.isEmpty() ||
                email == null || email.isEmpty() ||
                address == null || address.isEmpty() ||
                orderTotal == null || orderTotal.isEmpty()) {
                
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Missing required fields\"}");
                return;
            }
            
            // Parse order amount
            long orderAmount;
            try {
                orderAmount = Long.parseLong(orderTotal);
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Invalid amount\"}");
                return;
            }
            
            // VNPAY Parameters
            String vnp_Version = VNPayConfig.vnp_Version;
            String vnp_Command = "pay";
            String vnp_TmnCode = VNPayConfig.vnp_TmnCode;
            String vnp_IpAddr = VNPayConfig.getIpAddress(request);
            String vnp_TxnRef = VNPayConfig.getRandomNumber(8);
            String vnp_OrderInfo = "Thanh toan don hang: " + fullname + " - " + phone;
            String vnp_OrderType = "other";
            String vnp_Locale = "vn";
            
            // Format amount (multiply by 100 as VNPAY requires)
            String vnp_Amount = String.valueOf(VNPayConfig.formatAmount(orderAmount));
            
            // Create current datetime for vnp_CreateDate (GMT+7)
            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            
            // Set expire date (15 minutes from now)
            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            
            // Build parameters map
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", vnp_Amount);
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
            vnp_Params.put("vnp_OrderType", vnp_OrderType);
            vnp_Params.put("vnp_Locale", vnp_Locale);
            vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
            
            // Note: Optional billing fields removed for simplicity
            // VNPAY basic payment only requires mandatory fields
            
            // Build query string and secure hash using VNPAY standard method
            String queryUrl = VNPayConfig.buildQueryString(vnp_Params);
            String vnp_SecureHash = VNPayConfig.hashAllFields(vnp_Params);
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            
            String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + queryUrl;
            
            // Store transaction reference in session for later verification
            HttpSession session = request.getSession();
            session.setAttribute("vnp_TxnRef", vnp_TxnRef);
            session.setAttribute("orderAmount", orderAmount);
            session.setAttribute("customerInfo", new String[]{fullname, phone, email, address, city, district});
            
            // Return success response with payment URL
            response.getWriter().write("{\"success\": true, \"paymentUrl\": \"" + paymentUrl + "\"}");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}

