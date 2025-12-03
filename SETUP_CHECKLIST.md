# Setup Checklist for BookStore JSP/Servlet Project

## Step 1: Database Setup ✅

- [ ] Open MySQL Command Line or MySQL Workbench
- [ ] Navigate to project folder: `E:\project kiro\WebBanSach2\WebBanSach\`
- [ ] Import database:
  ```bash
  mysql -u root -p < database/setup.sql
  ```
- [ ] Verify database created:
  ```sql
  USE bookstore;
  SELECT COUNT(*) FROM books;  -- Should show 40
  ```

## Step 2: Configuration

- [ ] Check/Update database credentials in:
  `src/main/java/com/bookstore/util/DBConnection.java`
  - Default: root / empty password
  - Update if your MySQL setup is different

## Step 3: Build Project

### Option A: Using Maven
- [ ] Open command prompt in project root
- [ ] Run: `mvn clean install`
- [ ] Verify: Build SUCCESS message

### Option B: Using IDE (Eclipse/IntelliJ)
- [ ] Import project as Maven project
- [ ] Let IDE resolve dependencies
- [ ] Right-click → Maven → Update Project

## Step 4: Deploy to Tomcat

- [ ] Ensure Tomcat is installed and configured
- [ ] Set CATALINA_HOME environment variable
- [ ] Copy WAR file or exploded folder to:
  `TOMCAT_HOME/webapps/`
- [ ] Or use IDE's deploy option

## Step 5: Start Application

- [ ] Start Tomcat (run catalina.bat or use IDE)
- [ ] Wait for "Server startup in X ms" message
- [ ] Check Tomcat logs for errors

## Step 6: Initial Testing

- [ ] Open browser and visit:
  ```
  http://localhost:8080/WebBanSach/
  ```

### Expected Results:
- [ ] Homepage loads successfully
- [ ] "Khám Phá Thế Giới Sách" title visible
- [ ] 6 categories displayed in carousel
- [ ] Featured products carousel works
- [ ] Category carousel buttons (❮ ❯) functional
- [ ] No errors in browser console (F12)

## Step 7: Verify Database Connection

- [ ] Check Tomcat logs for any SQLException
- [ ] Look for message in Tomcat console:
  ```
  Attempting to connect to MySQL...
  Database connection successful!
  ```

## Step 8: Next Steps

After successful homepage:

1. **Implement ProductServlet** (Priority 1)
   - File: `src/main/java/com/bookstore/servlet/ProductServlet.java`
   - See: `IMPLEMENTATION_GUIDE.md` for template

2. **Create products.jsp** (Priority 1)
   - File: `src/main/webapp/WEB-INF/jsp/products.jsp`
   - Reference: `src/main/webapp/templatehtmlcssjs/products.html`

3. **Implement LoginServlet** (Priority 2)
   - For user authentication

4. **Implement CartServlet** (Priority 2)
   - For shopping cart functionality

## Troubleshooting

### Homepage shows 404 error
- [ ] Verify Tomcat started without errors
- [ ] Check context path is correct
- [ ] Try: http://localhost:8080/WebBanSach/ (with trailing slash)

### No products display
- [ ] Check database connection in DBConnection.java
- [ ] Verify MySQL is running
- [ ] Check Tomcat logs for SQLException
- [ ] Try: `mysql -u root bookstore` to test connection

### CSS/JS files not loading
- [ ] Check browser console for 404 errors
- [ ] Verify file paths use ${pageContext.request.contextPath}
- [ ] Ensure CSS/JS files are in `src/main/webapp/css/` and `src/main/webapp/js/`

### Categories not showing
- [ ] Verify CategoryDAO.java is correct
- [ ] Check MySQL database has categories table
- [ ] Try: `SELECT * FROM categories;` in MySQL

### Carousel buttons not working
- [ ] Check carousel.js is included in footer.jsp
- [ ] Look for errors in browser console
- [ ] Verify JavaScript files loaded (Network tab in F12)

### Database connection refused
- [ ] Ensure MySQL service is running
- [ ] Verify connection credentials in DBConnection.java
- [ ] Check firewall isn't blocking port 3306
- [ ] Try: `mysql -u root -p` to verify MySQL works

## Performance Optimization (Optional)

- [ ] Enable connection pooling in DBConnection.java
- [ ] Add database indexes (already done in setup.sql)
- [ ] Compress CSS/JS for production
- [ ] Enable browser caching

## Security Checklist

Before production:
- [ ] Update MySQL password (not leaving empty)
- [ ] Validate all user inputs
- [ ] Enable HTTPS
- [ ] Use prepared statements (already done in DAOs)
- [ ] Add CSRF tokens to forms
- [ ] Implement rate limiting
- [ ] Add SQL injection prevention (already done)
- [ ] Sanitize output in JSP

## Production Deployment

- [ ] Test on staging environment first
- [ ] Update database credentials for production
- [ ] Set up database backups
- [ ] Configure logging
- [ ] Set appropriate Tomcat memory limits
- [ ] Enable gzip compression
- [ ] Setup monitoring and alerts
- [ ] Create backup strategy
- [ ] Document deployment procedures

---

## Documentation Reference

- **IMPLEMENTATION_GUIDE.md** - Detailed servlet/JSP specifications
- **PROGRESS_REPORT.md** - Project status and next steps
- **IMPLEMENTATION_SUMMARY.txt** - Quick overview
- **jsp.plan.md** - Original project plan
- **setup.sql** - Database schema and sample data

---

## Support Contacts

For issues or questions:
1. Check the IMPLEMENTATION_GUIDE.md for specifications
2. Review the PROGRESS_REPORT.md for troubleshooting
3. Examine existing DAO classes for database patterns
4. Check Tomcat logs for detailed error messages

---

## Timeline Estimate

- Database Setup: 5 minutes
- Build & Deploy: 5 minutes
- Initial Testing: 5 minutes
- **Total Setup Time: ~15 minutes**

---

## Success Criteria

✅ Project is successfully set up when:
1. Tomcat starts without errors
2. Homepage loads at http://localhost:8080/WebBanSach/
3. Database connection works (products display)
4. CSS/JS files load (page looks good)
5. Carousel buttons are functional
6. Browser console has no errors

🎉 **Setup Complete!** Ready for development.

