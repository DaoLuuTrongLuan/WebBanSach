package com.bookstore.servlet;

import com.bookstore.dao.OrderDAO;
import com.bookstore.model.Order;
import com.bookstore.util.VNPayConfig;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

/**
 * Servlet for VNPAY Return URL
 * Handles payment result returned from VNPAY gateway
 * Displays payment result to user (NOT used for database updates - use IPN for that)
 */
@WebServlet("/vnpay/return")
public class VNPayReturnServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get all parameters from VNPAY
            Map<String, String> vnp_Params = new HashMap<>();
            for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = params.nextElement();
                String fieldValue = request.getParameter(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    vnp_Params.put(fieldName, fieldValue);
                }
            }
            
            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            
            // Verify checksum
            boolean checksum_valid = VNPayConfig.verifyChecksum(vnp_SecureHash, vnp_Params);
            
            String vnp_TxnRef = request.getParameter("vnp_TxnRef");
            String vnp_Amount = request.getParameter("vnp_Amount");
            String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
            String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
            String vnp_PayDate = request.getParameter("vnp_PayDate");
            String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
            
            // Parse amount
            long amount = 0;
            if (vnp_Amount != null && !vnp_Amount.isEmpty()) {
                try {
                    amount = VNPayConfig.parseAmount(Long.parseLong(vnp_Amount));
                } catch (NumberFormatException e) {
                    amount = 0;
                }
            }
            
            // Set request attributes for JSP
            request.setAttribute("vnp_TxnRef", vnp_TxnRef);
            request.setAttribute("vnp_Amount", amount);
            request.setAttribute("vnp_ResponseCode", vnp_ResponseCode);
            request.setAttribute("vnp_TransactionNo", vnp_TransactionNo);
            request.setAttribute("vnp_PayDate", vnp_PayDate);
            request.setAttribute("vnp_OrderInfo", vnp_OrderInfo);
            request.setAttribute("checksum_valid", checksum_valid);
            request.setAttribute("payment_success", "00".equals(vnp_ResponseCode) && checksum_valid);
            
            // Get customer info from session (if available)
            HttpSession session = request.getSession();
            String[] customerInfo = (String[]) session.getAttribute("customerInfo");
            if (customerInfo != null) {
                request.setAttribute("fullname", customerInfo[0]);
                request.setAttribute("phone", customerInfo[1]);
                request.setAttribute("email", customerInfo[2]);
            }
            
            // Forward to result page
            request.getRequestDispatcher("/WEB-INF/jsp/vnpay-result.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý kết quả thanh toán");
            try {
                request.getRequestDispatcher("/WEB-INF/jsp/vnpay-result.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                ex.printStackTrace();
            }
        }
    }
}

