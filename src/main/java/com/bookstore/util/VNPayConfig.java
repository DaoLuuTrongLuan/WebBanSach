package com.bookstore.util;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.*;

/**
 * VNPAY Payment Gateway Configuration
 * Provides configuration and utility methods for VNPAY integration
 */
public class VNPayConfig {
    
    // VNPAY Configuration
    // Credentials from VNPAY Sandbox registration (laga2134@gmail.com)
    // Received from VNPAY email on 06/12/2025 16:08
    public static final String vnp_TmnCode = "5ICQMMPN";
    public static final String vnp_HashSecret = "M1477CK4H75JBCWKSFY0GSF1W2FDZBXE";
    public static final String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static final String vnp_ApiUrl = "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction";
    public static final String vnp_Version = "2.1.0";
    
    // Return URL (Fix context path to match deployment)
    public static final String vnp_ReturnUrl = "http://localhost:8080/webbansach_war/vnpay/return";
    public static final String vnp_IpnUrl = "http://localhost:8080/webbansach_war/vnpay/ipn";
    
    /**
     * Generate HMACSHA512 checksum
     * @param key Secret key (VNPAY HashSecret)
     * @param data Data to hash
     * @return SHA512 hash
     */
    public static String hmacSHA512(String key, String data) {
        try {
            if (key == null) {
                key = "";
            }
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            Mac mac = Mac.getInstance("HmacSHA512");
            mac.init(secretKeySpec);
            byte[] rawHmac = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : rawHmac) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
    
    /**
     * Generate random number for vnp_TxnRef
     * @param length Length of random number
     * @return Random number as string
     */
    public static String getRandomNumber(int length) {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }
    
    /**
     * Get client IP address from request
     * @param request HTTP request
     * @return Client IP address
     */
    public static String getIpAddress(HttpServletRequest request) {
        String ipAdress;
        try {
            ipAdress = request.getHeader("X-FORWARDED-FOR");
            if (ipAdress == null) {
                ipAdress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            ipAdress = "0.0.0.0";
        }
        return ipAdress;
    }
    
    /**
     * Hash all fields - VNPAY standard method
     * @param params Parameter map
     * @return Hash string for checksum calculation
     */
    public static String hashAllFields(Map<String, String> params) {
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder sb = new StringBuilder();
        
        for (String fieldName : fieldNames) {
            String fieldValue = params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                if (sb.length() > 0) {
                    sb.append("&");
                }
                sb.append(fieldName);
                sb.append("=");
                sb.append(fieldValue);
            }
        }
        return hmacSHA512(vnp_HashSecret, sb.toString());
    }
    
    /**
     * Build query string from parameters (sorted alphabetically)
     * @param params Parameter map
     * @return Encoded query string
     */
    public static String buildQueryString(Map<String, String> params) {
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder query = new StringBuilder();
        
        for (String fieldName : fieldNames) {
            String fieldValue = params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                try {
                    if (query.length() > 0) {
                        query.append("&");
                    }
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append("=");
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
        }
        return query.toString();
    }
    
    /**
     * Build hash data for checksum (sorted alphabetically)
     * @param params Parameter map
     * @return Hash data string
     */
    public static String buildHashData(Map<String, String> params) {
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        
        for (String fieldName : fieldNames) {
            String fieldValue = params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                if (hashData.length() > 0) {
                    hashData.append("&");
                }
                hashData.append(fieldName);
                hashData.append("=");
                hashData.append(fieldValue);
            }
        }
        return hashData.toString();
    }
    
    /**
     * Verify checksum from request parameters
     * @param vnp_SecureHash Received hash
     * @param params Request parameters
     * @return True if valid
     */
    public static boolean verifyChecksum(String vnp_SecureHash, Map<String, String> params) {
        // Remove hash and hash type from params
        params.remove("vnp_SecureHash");
        params.remove("vnp_SecureHashType");
        
        String calculatedHash = hashAllFields(params);
        
        return calculatedHash.equalsIgnoreCase(vnp_SecureHash);
    }
    
    /**
     * Format amount for VNPAY (multiply by 100)
     * @param amount Amount in VND
     * @return Amount * 100
     */
    public static long formatAmount(long amount) {
        return amount * 100;
    }
    
    /**
     * Parse amount from VNPAY (divide by 100)
     * @param amount Amount from VNPAY
     * @return Amount in VND
     */
    public static long parseAmount(long amount) {
        return amount / 100;
    }
}

