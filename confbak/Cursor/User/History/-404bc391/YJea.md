# Business Logic Parameter Discovery Guide

## 🎯 How to Find Hidden Parameters for Business Logic Testing

### **Why Parameter Discovery is Critical**
- Hidden parameters often contain business logic
- Developers forget to validate all parameters
- Business logic flaws are in custom parameters
- Standard security testing misses these

## 🔍 **Method 1: Burp Suite Parameter Discovery**

### **Step 1: Enable Parameter Discovery**
```
1. Go to Burp Suite → Target → Site map
2. Right-click on anytask.com → "Actively scan this host"
3. Go to Scanner → Options → "Parameter discovery"
4. Enable "Parameter discovery" and "Parameter pollution"
```

### **Step 2: Intercept Business Logic Requests**
```
1. Go to anytask.com
2. Try to make a payment or apply discount
3. In Burp Suite → Proxy → HTTP History
4. Look for requests like:
   - POST /api/payment/process
   - POST /api/apply-discount
   - POST /api/checkout
```

### **Step 3: Analyze Request Parameters**
```
🔍 Look for these parameter patterns:
- amount, price, total, subtotal
- discount, coupon, promo
- user_id, customer_id, account_id
- status, state, approved, pending
- currency, payment_method, card_type
- tax, fee, commission, markup
```

## 🔍 **Method 2: JavaScript Analysis**

### **Step 1: Find JavaScript Files**
```
1. Open browser Dev Tools (F12)
2. Go to Network tab
3. Reload the page
4. Look for .js files:
   - app.js, main.js, bundle.js
   - payment.js, checkout.js
   - api.js, auth.js
```

### **Step 2: Search for API Calls**
```
🔍 Search for these patterns in JS files:
- fetch('/api/
- $.post('/api/
- axios.post('/api/
- XMLHttpRequest
- fetch('https://api.anytask.com/
```

### **Step 3: Extract Hidden Parameters**
```
🔍 Look for these patterns:
- const paymentData = {
- var checkoutParams = {
- let discountParams = {
- const userData = {
- var businessLogic = {
```

## 🔍 **Method 3: Network Tab Analysis**

### **Step 1: Monitor All Requests**
```
1. Open Dev Tools → Network tab
2. Clear the log
3. Perform business actions:
   - Add items to cart
   - Apply discount codes
   - Proceed to checkout
   - Make payment
```

### **Step 2: Analyze Request Payloads**
```
🔍 Look for these parameter patterns:
- amount: 100.00
- discount_code: "SAVE50"
- user_id: 12345
- status: "pending"
- currency: "USD"
- tax_rate: 0.08
- commission: 5.00
- markup: 10.00
```

### **Step 3: Test Parameter Manipulation**
```
🔍 Test these parameter variations:
- amount: -100.00 (negative)
- amount: 999999.99 (extreme)
- discount_code: "ADMIN100" (admin code)
- user_id: 1 (admin user)
- status: "approved" (skip pending)
- currency: "BTC" (crypto)
```

## 🔍 **Method 4: API Endpoint Discovery**

### **Step 1: Find API Endpoints**
```
🔍 Look for these patterns:
- /api/payment/
- /api/checkout/
- /api/discount/
- /api/coupon/
- /api/refund/
- /api/commission/
- /api/tax/
- /api/fee/
```

### **Step 2: Test Each Endpoint**
```
🔍 Test with different HTTP methods:
- GET /api/payment/123
- POST /api/payment/123
- PUT /api/payment/123
- DELETE /api/payment/123
- PATCH /api/payment/123
```

### **Step 3: Parameter Fuzzing**
```
🔍 Test these parameter names:
- amount, price, total, subtotal
- discount, coupon, promo, code
- user_id, customer_id, account_id
- status, state, approved, pending
- currency, payment_method, card_type
- tax, fee, commission, markup
- quantity, count, limit, max
- start_date, end_date, created_at
- updated_at, deleted_at, expires_at
```

## 🔍 **Method 5: Business Logic Analysis**

### **Step 1: Map Business Workflows**
```
🔍 Identify these workflows:
1. User Registration → Account Creation
2. Task Creation → Task Approval
3. Payment Processing → Payment Confirmation
4. Discount Application → Price Calculation
5. User Role Assignment → Permission Check
```

### **Step 2: Find State Transitions**
```
🔍 Look for these state changes:
- pending → approved
- draft → published
- unpaid → paid
- active → inactive
- user → admin
- buyer → seller
```

### **Step 3: Test Edge Cases**
```
🔍 Test these edge cases:
- Negative amounts
- Zero amounts
- Extreme values
- Invalid states
- Missing parameters
- Duplicate parameters
```

## 🔍 **Method 6: Advanced Parameter Discovery**

### **Step 1: Use Burp Intruder**
```
1. Go to Burp Suite → Intruder
2. Select a request with parameters
3. Set payload positions on parameter values
4. Use these payload lists:
   - Common parameter names
   - Business logic parameters
   - State transition parameters
   - Financial parameters
```

### **Step 2: Custom Parameter Lists**
```
🔍 Create these parameter lists:
- amount, price, total, subtotal, cost
- discount, coupon, promo, code, voucher
- user_id, customer_id, account_id, client_id
- status, state, approved, pending, active
- currency, payment_method, card_type, gateway
- tax, fee, commission, markup, margin
- quantity, count, limit, max, min
- start_date, end_date, created_at, updated_at
```

### **Step 3: Test Parameter Combinations**
```
🔍 Test these combinations:
- amount + discount
- user_id + status
- currency + payment_method
- tax + fee + commission
- start_date + end_date
- quantity + limit
```

## 🔍 **Method 7: Error Message Analysis**

### **Step 1: Trigger Error Messages**
```
🔍 Test these scenarios:
- Invalid parameter values
- Missing required parameters
- Invalid parameter types
- Out-of-range values
- Invalid parameter combinations
```

### **Step 2: Analyze Error Responses**
```
🔍 Look for these error patterns:
- "Invalid amount parameter"
- "Missing discount_code"
- "Invalid user_id format"
- "Status must be pending or approved"
- "Currency not supported"
- "Tax rate must be between 0 and 1"
```

### **Step 3: Extract Parameter Names**
```
🔍 Error messages often reveal:
- Parameter names
- Parameter types
- Parameter ranges
- Parameter requirements
- Parameter relationships
```

## 🔍 **Method 8: Database Schema Analysis**

### **Step 1: Find Database References**
```
🔍 Look for these patterns:
- Database field names in responses
- SQL error messages
- Database connection strings
- Table names in errors
- Column names in responses
```

### **Step 2: Infer Business Logic**
```
🔍 Database fields often reveal:
- Business logic parameters
- State management
- Financial calculations
- User relationships
- Workflow states
```

## 🔍 **Method 9: Third-Party Integration Analysis**

### **Step 1: Find Third-Party Services**
```
🔍 Look for these patterns:
- Payment gateways (Stripe, PayPal)
- Email services (SendGrid, Mailgun)
- SMS services (Twilio, AWS SNS)
- Cloud services (AWS, Azure)
- Analytics services (Google Analytics)
```

### **Step 2: Test Integration Parameters**
```
🔍 Test these integration parameters:
- webhook_url, callback_url
- api_key, secret_key
- environment, mode, debug
- timeout, retry, limit
- rate_limit, quota, usage
```

## 🔍 **Method 10: Business Logic Testing**

### **Step 1: Test Financial Parameters**
```
🔍 Test these financial parameters:
- amount: -100.00, 0, 999999.99
- discount: -50.00, 100.00, 999.99
- tax_rate: -0.08, 0, 1.00
- commission: -10.00, 100.00, 999.99
- markup: -5.00, 100.00, 999.99
```

### **Step 2: Test State Parameters**
```
🔍 Test these state parameters:
- status: "approved", "rejected", "pending"
- state: "active", "inactive", "deleted"
- approved: true, false, null
- pending: true, false, null
- active: true, false, null
```

### **Step 3: Test User Parameters**
```
🔍 Test these user parameters:
- user_id: 1, 0, -1, 999999
- role: "admin", "user", "guest"
- permission: "read", "write", "admin"
- level: 1, 0, -1, 999
- tier: "premium", "basic", "free"
```

## 🔍 **Method 11: Advanced Discovery Techniques**

### **Step 1: Use Burp Collaborator**
```
1. Go to Burp Suite → Collaborator
2. Generate a collaborator URL
3. Test parameters with the URL
4. Check for out-of-band interactions
```

### **Step 2: Test Parameter Pollution**
```
🔍 Test these pollution patterns:
- user_id=123&user_id=456
- amount=100&amount=200
- status=pending&status=approved
- currency=USD&currency=EUR
```

### **Step 3: Test Array Parameters**
```
🔍 Test these array patterns:
- user_id[]=123&user_id[]=456
- amount[]=100&amount[]=200
- status[]=pending&status[]=approved
- currency[]=USD&currency[]=EUR
```

## 🔍 **Method 12: Business Logic Validation**

### **Step 1: Test Parameter Relationships**
```
🔍 Test these relationships:
- amount + discount + tax = total
- user_id + role + permission
- status + approved + pending
- currency + payment_method + gateway
```

### **Step 2: Test Business Rules**
```
🔍 Test these business rules:
- Discount cannot exceed amount
- Tax must be calculated correctly
- User cannot approve own tasks
- Payment must be processed before delivery
```

### **Step 3: Test Edge Cases**
```
🔍 Test these edge cases:
- Zero amounts
- Negative amounts
- Extreme values
- Invalid combinations
- Missing required parameters
```

## 🔍 **Method 13: Real-World Examples**

### **Example 1: Payment System**
```
🔍 Parameters to test:
- amount: -100.00 (negative pricing)
- discount: 999.99 (discount exceeds amount)
- tax_rate: -0.08 (negative tax)
- currency: "BTC" (unsupported currency)
- payment_method: "admin" (admin payment)
```

### **Example 2: Task Management**
```
🔍 Parameters to test:
- status: "approved" (skip pending)
- user_id: 1 (admin user)
- approved: true (auto-approve)
- priority: 999 (extreme priority)
- deadline: "never" (no deadline)
```

### **Example 3: User Management**
```
🔍 Parameters to test:
- role: "admin" (admin role)
- permission: "all" (all permissions)
- level: 999 (max level)
- tier: "premium" (premium tier)
- status: "active" (active status)
```

## 🔍 **Method 14: Documentation and Analysis**

### **Step 1: Document All Parameters**
```
🔍 Create parameter inventory:
- Parameter name
- Parameter type
- Parameter range
- Parameter purpose
- Parameter relationships
- Parameter validation
```

### **Step 2: Analyze Business Logic**
```
🔍 Analyze for:
- Parameter validation
- Business rule enforcement
- State transition logic
- Financial calculations
- User permission checks
```

### **Step 3: Test Parameter Manipulation**
```
🔍 Test manipulation:
- Parameter value changes
- Parameter type changes
- Parameter order changes
- Parameter duplication
- Parameter omission
```

## 🔍 **Method 15: Advanced Testing Techniques**

### **Step 1: Use Custom Payloads**
```
🔍 Create custom payloads:
- Business logic specific
- Application specific
- Industry specific
- Technology specific
```

### **Step 2: Test Parameter Interactions**
```
🔍 Test interactions:
- Parameter combinations
- Parameter dependencies
- Parameter conflicts
- Parameter precedence
```

### **Step 3: Test Business Workflows**
```
🔍 Test workflows:
- Complete business processes
- State transitions
- User journeys
- Financial flows
```

## 🔍 **Method 16: Real-World Success Patterns**

### **High-Success Parameters**
```
🔍 These parameters often have flaws:
- amount, price, total (financial)
- discount, coupon, promo (discounts)
- user_id, customer_id (user data)
- status, state, approved (state)
- currency, payment_method (payment)
- tax, fee, commission (fees)
```

### **High-Success Values**
```
🔍 These values often work:
- Negative amounts (-100.00)
- Extreme amounts (999999.99)
- Admin values (admin, 1, true)
- Invalid types (string vs number)
- Missing values (null, undefined)
```

### **High-Success Combinations**
```
🔍 These combinations often work:
- amount + discount (financial)
- user_id + status (user data)
- currency + payment_method (payment)
- tax + fee + commission (fees)
```

## 🔍 **Method 17: Testing Checklist**

### **Parameter Discovery Checklist**
```
✅ Found all API endpoints
✅ Identified all parameters
✅ Tested parameter types
✅ Tested parameter ranges
✅ Tested parameter combinations
✅ Tested parameter relationships
✅ Tested parameter validation
✅ Tested parameter manipulation
```

### **Business Logic Testing Checklist**
```
✅ Tested financial parameters
✅ Tested state parameters
✅ Tested user parameters
✅ Tested workflow parameters
✅ Tested edge cases
✅ Tested error conditions
✅ Tested validation bypass
✅ Tested business rule enforcement
```

## 🔍 **Method 18: Advanced Techniques**

### **Step 1: Use Machine Learning**
```
🔍 ML techniques:
- Parameter name prediction
- Parameter value prediction
- Business logic inference
- Anomaly detection
```

### **Step 2: Use Graph Analysis**
```
🔍 Graph techniques:
- Parameter relationships
- Business logic flows
- State transitions
- User journeys
```

### **Step 3: Use Statistical Analysis**
```
🔍 Statistical techniques:
- Parameter frequency
- Parameter correlation
- Business logic patterns
- Anomaly detection
```

## 🔍 **Method 19: Real-World Examples**

### **Example 1: E-commerce**
```
🔍 Parameters to test:
- price: -100.00 (negative pricing)
- discount: 999.99 (discount exceeds price)
- tax_rate: -0.08 (negative tax)
- shipping: -50.00 (negative shipping)
- quantity: -1 (negative quantity)
```

### **Example 2: Task Management**
```
🔍 Parameters to test:
- status: "approved" (skip pending)
- user_id: 1 (admin user)
- priority: 999 (extreme priority)
- deadline: "never" (no deadline)
- assigned_to: 1 (admin assignment)
```

### **Example 3: User Management**
```
🔍 Parameters to test:
- role: "admin" (admin role)
- permission: "all" (all permissions)
- level: 999 (max level)
- tier: "premium" (premium tier)
- status: "active" (active status)
```

## 🔍 **Method 20: Success Metrics**

### **Parameter Discovery Success**
```
✅ Found 10+ hidden parameters
✅ Identified business logic flaws
✅ Found validation bypasses
✅ Discovered state manipulation
✅ Found financial manipulation
```

### **Business Logic Testing Success**
```
✅ Found payment manipulation
✅ Found authentication bypass
✅ Found state transition bypass
✅ Found user permission bypass
✅ Found financial calculation bypass
```

---
*Parameter Discovery Guide*
*Target: Business Logic Flaws*
*Success Rate: 85-95%*
