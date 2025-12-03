# JSP/Servlet Implementation Guide

## Project Overview
This guide outlines the JSP/Servlet conversion of the BookStore website with MySQL database integration.

## Completed Components

### Phase 1: Database & Models ✅
- [x] MySQL database schema (setup.sql)
- [x] All model classes (User, Category, Author, Publisher, Book, CartItem, Order, OrderItem)
- [x] DAO classes (UserDAO, CategoryDAO, BookDAO, AuthorDAO, OrderDAO)
- [x] Database connection utility (DBConnection.java)
- [x] Common JSP components (header.jsp, footer.jsp, head.jsp)
- [x] Home page (HomeServlet + home.jsp)

## Remaining Components to Implement

### Phase 2: Core Page Servlets & JSP Pages

#### 1. **ProductServlet** + **products.jsp**
Location: `src/main/java/com/bookstore/servlet/ProductServlet.java`

```java
@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    - Handle GET requests with filters, search, sort, pagination
    - Query parameters: category, search, sort, page
    - Set attributes: products list, pagination info, filters state
    - Forward to /WEB-INF/jsp/products.jsp
}
```

JSP Path: `src/main/webapp/WEB-INF/jsp/products.jsp`
- Display product grid with filters sidebar
- Sidebar: category filter, price filter, author filter
- Toolbar: search input, sort dropdown
- Pagination controls

#### 2. **ProductDetailServlet** + **product-detail.jsp**
Location: `src/main/java/com/bookstore/servlet/ProductDetailServlet.java`

```java
@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {
    - Get product ID from query parameter
    - Fetch book details and related products
    - Forward to product-detail.jsp
}
```

#### 3. **CartServlet** + **cart.jsp**
Location: `src/main/java/com/bookstore/servlet/CartServlet.java`

```java
@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    - Display cart items from session
    - Handle GET to show cart page
    - Forward to cart.jsp
}
```

JSP: `src/main/webapp/WEB-INF/jsp/cart.jsp`
- Display cart items in table
- Quantity controls
- Calculate totals
- Checkout button

#### 4. **CheckoutServlet** + **checkout.jsp**
Location: `src/main/java/com/bookstore/servlet/CheckoutServlet.java`

```java
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    - Validate user authentication (optional)
    - Display checkout 4-step form
    - Handle form submission to create order
    - Redirect to order-success.jsp
}
```

#### 5. **LoginServlet** + **login.jsp**
Location: `src/main/java/com/bookstore/servlet/LoginServlet.java`

```java
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    - GET: Display login form
    - POST: Verify credentials using UserDAO
    - Set user in session on success
    - Redirect to previous page or home
}
```

#### 6. **RegisterServlet** + **register.jsp**
Location: `src/main/java/com/bookstore/servlet/RegisterServlet.java`

```java
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    - GET: Display registration form
    - POST: Create new user using UserDAO
    - Validate email uniqueness
    - Auto-login after registration
}
```

#### 7. **LogoutServlet**
Location: `src/main/java/com/bookstore/servlet/LogoutServlet.java`

```java
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    - Invalidate session
    - Clear user from session
    - Redirect to home
}
```

#### 8. **AboutServlet** + **about.jsp**
Location: `src/main/java/com/bookstore/servlet/AboutServlet.java`

```java
@WebServlet("/about")
public class AboutServlet extends HttpServlet {
    - Forward to about.jsp
}
```

#### 9. **ContactServlet** + **contact.jsp**
Location: `src/main/java/com/bookstore/servlet/ContactServlet.java`

```java
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    - Display contact form
    - Handle form submission (store in database or email)
}
```

### Phase 3: API Servlets (AJAX Endpoints)

#### 1. **CartAPIServlet**
Location: `src/main/java/com/bookstore/servlet/CartAPIServlet.java`

```java
@WebServlet("/api/cart/*")
public class CartAPIServlet extends HttpServlet {
    - POST /api/cart/add - Add item to cart session
    - POST /api/cart/update - Update quantity
    - POST /api/cart/remove - Remove item
    - GET /api/cart/count - Get cart count
    - Return JSON responses
}
```

#### 2. **SearchAPIServlet**
Location: `src/main/java/com/bookstore/servlet/SearchAPIServlet.java`

```java
@WebServlet("/api/search")
public class SearchAPIServlet extends HttpServlet {
    - GET with 'q' parameter
    - Return JSON array of matching books
}
```

### Phase 4: JavaScript Updates

#### Files to Update:
1. `src/main/webapp/js/config.js`
   - Update API_BASE_URL to empty string (relative paths)

2. `src/main/webapp/js/cart.js`
   - Replace mock cart with session-based via AJAX
   - Update cart add/remove/update endpoints

3. `src/main/webapp/js/main.js`
   - Update product page handlers
   - Remove mock data dependency

### Phase 5: Additional Servlet Filters

#### **AuthFilter.java**
Location: `src/main/java/com/bookstore/filter/AuthFilter.java`

```java
@WebFilter("/checkout")
public class AuthFilter implements Filter {
    - Check if user is logged in
    - If not, redirect to login page
}
```

## Database Setup Instructions

1. Open MySQL command line or MySQL Workbench
2. Run the database setup script:
   ```bash
   mysql -u root -p < database/setup.sql
   ```

3. Update DBConnection.java with your MySQL credentials if different:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/bookstore";
   private static final String USER = "root";
   private static final String PASSWORD = "";
   ```

## Required JAR Files

Place in `src/main/webapp/WEB-INF/lib/`:

- `mysql-connector-java-8.0.33.jar` (MySQL JDBC Driver)
- `jstl-1.2.jar` (JSTL)
- `jakarta.servlet-api-5.0.0.jar` (already included in Tomcat)

## Web.xml Configuration

Add servlet mappings for all servlets in `src/main/webapp/WEB-INF/web.xml`:

```xml
<servlet>
    <servlet-name>ProductServlet</servlet-name>
    <servlet-class>com.bookstore.servlet.ProductServlet</servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>ProductServlet</servlet-name>
    <url-pattern>/products</url-pattern>
</servlet-mapping>
<!-- Repeat for all servlets -->
```

## Deployment & Testing

1. **Build Project:**
   - Maven: `mvn clean install`
   - Or deploy to Tomcat directly

2. **Configure Tomcat:**
   - Set CATALINA_HOME environment variable
   - Deploy WAR to webapps folder

3. **Test URLs:**
   - Home: `http://localhost:8080/WebBanSach/`
   - Products: `http://localhost:8080/WebBanSach/products`
   - About: `http://localhost:8080/WebBanSach/about`
   - Contact: `http://localhost:8080/WebBanSach/contact`
   - Login: `http://localhost:8080/WebBanSach/login`

## Key Implementation Notes

1. **Session Management:**
   - User info stored in `session.getAttribute("user")`
   - Cart stored in `session.getAttribute("cart")` as List<CartItem>

2. **Error Handling:**
   - Use try-catch for SQLException
   - Set error messages in request attributes
   - Display in JSP with JSTL

3. **Security:**
   - Validate all user inputs
   - Use prepared statements (already done in DAOs)
   - Implement AuthFilter for protected pages

4. **CSS/JS Paths:**
   - Use `${pageContext.request.contextPath}` for all resource paths
   - Ensures proper URLs regardless of context path

## CSS and JS Files Structure

- CSS: `src/main/webapp/css/*.css`
- JS: `src/main/webapp/js/*.js`
- All resources should be copied from templatehtmlcssjs folder

## Testing Checklist

- [ ] Home page loads with products and categories
- [ ] Product listing page with filters works
- [ ] Product detail page displays correctly
- [ ] Add to cart functionality works
- [ ] Cart page displays items correctly
- [ ] User registration works
- [ ] User login works
- [ ] Checkout process works
- [ ] Orders are saved to database
- [ ] Search functionality works
- [ ] Responsive design works on mobile

## Common Issues & Solutions

1. **404 Errors:**
   - Check servlet mapping in web.xml
   - Verify @WebServlet annotation path

2. **Database Connection Errors:**
   - Ensure MySQL is running
   - Check database credentials in DBConnection.java
   - Verify JDBC driver is in classpath

3. **JSP Not Found:**
   - Check path in request.getRequestDispatcher()
   - Ensure JSP files are in WEB-INF/jsp/

4. **CSS/JS Not Loading:**
   - Use ${pageContext.request.contextPath} in paths
   - Check browser developer tools network tab

## Next Steps

1. Create all remaining servlets and JSP pages
2. Integrate JavaScript with servlet endpoints
3. Test all functionality
4. Add error pages and validation
5. Optimize database queries
6. Deploy to production server

