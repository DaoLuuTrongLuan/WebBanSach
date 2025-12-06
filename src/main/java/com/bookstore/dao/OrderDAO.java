package com.bookstore.dao;

import com.bookstore.model.Order;
import com.bookstore.model.OrderItem;
import com.bookstore.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Order DAO Class
 * Handles database operations for orders
 */
public class OrderDAO {
    
    /**
     * Create a new order
     */
    public static int createOrder(Order order) throws SQLException {
        String sql = "INSERT INTO orders (user_id, fullname, phone, email, address, city, district, notes, shipping_method, payment_method, total, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getFullname());
            ps.setString(3, order.getPhone());
            ps.setString(4, order.getEmail());
            ps.setString(5, order.getAddress());
            ps.setString(6, order.getCity());
            ps.setString(7, order.getDistrict());
            ps.setString(8, order.getNotes());
            ps.setString(9, order.getShippingMethod());
            ps.setString(10, order.getPaymentMethod());
            ps.setLong(11, order.getTotal());
            ps.setString(12, order.getStatus() != null ? order.getStatus() : "pending");
            
            ps.executeUpdate();
            
            // Get generated ID
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            
            return -1;
        } finally {
            closeResources(ps, conn);
        }
    }
    
    /**
     * Create order items
     */
    public static boolean createOrderItems(int orderId, List<OrderItem> items) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            
            for (OrderItem item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getBookId());
                ps.setInt(3, item.getQuantity());
                ps.setLong(4, item.getPrice());
                ps.addBatch();
            }
            
            int[] results = ps.executeBatch();
            return results.length > 0;
        } finally {
            closeResources(ps, conn);
        }
    }
    
    /**
     * Get order by ID
     */
    public static Order getOrderById(int id) throws SQLException {
        String sql = "SELECT * FROM orders WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
            return null;
        } finally {
            closeResources(rs, ps, conn);
        }
    }
    
    /**
     * Get orders by user ID
     */
    public static List<Order> getOrdersByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Order> orders = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        } finally {
            closeResources(rs, ps, conn);
        }
        
        return orders;
    }
    
    /**
     * Get order items
     */
    public static List<OrderItem> getOrderItems(int orderId) throws SQLException {
        String sql = "SELECT oi.*, b.title as book_title FROM order_items oi " +
                     "JOIN books b ON oi.book_id = b.id WHERE oi.order_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<OrderItem> items = new ArrayList<>();
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                items.add(mapResultSetToOrderItem(rs));
            }
        } finally {
            closeResources(rs, ps, conn);
        }
        
        return items;
    }
    
    /**
     * Update order status
     */
    public static boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            
            int result = ps.executeUpdate();
            return result > 0;
        } finally {
            closeResources(ps, conn);
        }
    }
    
    /**
     * Update payment status for VNPAY
     */
    public static boolean updatePaymentStatus(int orderId, String paymentStatus, String vnpTransactionNo) throws SQLException {
        String sql = "UPDATE orders SET payment_status = ?, vnp_transaction_no = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, paymentStatus);
            ps.setString(2, vnpTransactionNo);
            ps.setInt(3, orderId);
            
            int result = ps.executeUpdate();
            return result > 0;
        } finally {
            closeResources(ps, conn);
        }
    }
    
    /**
     * Get order by VNPAY transaction reference
     */
    public static Order getOrderByVnpTxnRef(String vnpTxnRef) throws SQLException {
        String sql = "SELECT * FROM orders WHERE vnp_txn_ref = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, vnpTxnRef);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
            return null;
        } finally {
            closeResources(rs, ps, conn);
        }
    }
    
    /**
     * Map ResultSet to Order object
     */
    private static Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setFullname(rs.getString("fullname"));
        order.setPhone(rs.getString("phone"));
        order.setEmail(rs.getString("email"));
        order.setAddress(rs.getString("address"));
        order.setCity(rs.getString("city"));
        order.setDistrict(rs.getString("district"));
        order.setNotes(rs.getString("notes"));
        order.setShippingMethod(rs.getString("shipping_method"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setTotal(rs.getLong("total"));
        order.setStatus(rs.getString("status"));
        
        // VNPAY Fields (if columns exist)
        try {
            order.setVnpTxnRef(rs.getString("vnp_txn_ref"));
            order.setVnpTransactionNo(rs.getString("vnp_transaction_no"));
            order.setPaymentStatus(rs.getString("payment_status"));
        } catch (SQLException e) {
            // Columns might not exist yet, ignore
        }
        
        return order;
    }
    
    /**
     * Map ResultSet to OrderItem object
     */
    private static OrderItem mapResultSetToOrderItem(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem();
        item.setId(rs.getInt("id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setBookId(rs.getInt("book_id"));
        item.setBookTitle(rs.getString("book_title"));
        item.setQuantity(rs.getInt("quantity"));
        item.setPrice(rs.getLong("price"));
        return item;
    }
    
    /**
     * Close database resources
     */
    private static void closeResources(ResultSet rs, PreparedStatement ps, Connection conn) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        closeResources(ps, conn);
    }
    
    private static void closeResources(PreparedStatement ps, Connection conn) {
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        DBConnection.closeConnection(conn);
    }
}

