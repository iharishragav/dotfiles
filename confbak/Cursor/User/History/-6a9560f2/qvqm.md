# Anytask.com Bug Bounty Test Cases

## Test Account Setup

### Production Testing Account
```
Email: kamalesh2428k@bugcrowdninja.com
Password: K@malesH
```

### Staging Environment
```
URL: https://anytask.thesecurityteam.rocks/
Admin: https://anytask.thesecurityteam.rocks/admin/
Username: hacker-anytasks-admin@thesecurityteam.rocks
Password: hacker-anytasks-admin@thesecurityteam.rocks
Test Card: 4111 1111 1111 1111
Email Access: http://stagemail.thesecurityteam.rocks/stagemailanytasks.php
```

## High-Priority Test Cases

### 1. Payment Logic Testing (Highest Priority)

#### Test Case 1.1: Discount Code Manipulation
**Target**: `/shopping/basket/apply-discount-code`
**Method**: POST
**Test Steps**:
1. Login to staging environment
2. Add items to cart
3. Intercept discount code application request
4. Test parameter manipulation:
   - Negative discount values
   - Extremely large discount values
   - SQL injection in discount code field
   - XSS in discount code field
   - Bypass discount code validation

**Expected Results**:
- Check for negative pricing
- Verify discount limits
- Test for code reuse vulnerabilities
- Check for discount stacking

#### Test Case 1.2: Billing Address Bypass
**Target**: Checkout process
**Test Steps**:
1. Navigate to checkout
2. Test billing address validation:
   - Empty billing address
   - Invalid address formats
   - SQL injection in address fields
   - XSS in address fields
3. Test API bypass (as mentioned in rules)

**Expected Results**:
- Verify if billing address can be bypassed via API
- Check for validation inconsistencies

#### Test Case 1.3: Payment Amount Manipulation
**Target**: Payment processing
**Test Steps**:
1. Intercept payment requests
2. Test parameter tampering:
   - Modify payment amounts
   - Test currency manipulation
   - Check for price calculation bypass
3. Test with staging test card: `4111 1111 1111 1111`

**Expected Results**:
- Verify payment amount validation
- Check for calculation bypasses
- Test for negative amounts

### 2. Authentication Testing

#### Test Case 2.1: JWT Token Manipulation
**Target**: Authentication system
**Test Steps**:
1. Login and capture JWT token
2. Test token manipulation:
   - Modify user ID in token
   - Change token expiration
   - Test with invalid signatures
   - Test token replay attacks
3. Test token in different endpoints

**Expected Results**:
- Check for IDOR vulnerabilities
- Verify token validation
- Test for privilege escalation

#### Test Case 2.2: Session Management
**Target**: Session handling
**Test Steps**:
1. Login and capture session cookies
2. Test session manipulation:
   - Session fixation attacks
   - Session hijacking attempts
   - Concurrent session testing
   - Session timeout testing

**Expected Results**:
- Verify session security
- Check for session fixation
- Test concurrent session handling

#### Test Case 2.3: Authentication Bypass
**Target**: Protected endpoints
**Test Steps**:
1. Test direct access to protected pages
2. Test with missing/invalid tokens
3. Test with expired tokens
4. Test with malformed tokens

**Expected Results**:
- Check for authentication bypass
- Verify token validation
- Test for privilege escalation

### 3. API Security Testing

#### Test Case 3.1: IDOR Testing
**Target**: User data endpoints
**Test Steps**:
1. Create two test accounts
2. Test data access:
   - Access other user's data
   - Modify other user's information
   - Test with different user IDs
3. Test parameter manipulation

**Expected Results**:
- Check for IDOR vulnerabilities
- Verify user data isolation
- Test for data modification

#### Test Case 3.2: SSRF Testing
**Target**: API endpoints
**Test Steps**:
1. Test for SSRF in:
   - File upload endpoints
   - Image processing endpoints
   - Webhook endpoints
2. Test with internal IPs:
   - 127.0.0.1
   - 169.254.169.254 (AWS metadata)
   - Internal network ranges

**Expected Results**:
- Check for SSRF vulnerabilities
- Test for internal network access
- Verify request filtering

#### Test Case 3.3: Sensitive Data Exposure
**Target**: API responses
**Test Steps**:
1. Test API endpoints for:
   - User data exposure
   - Internal system information
   - Error message information disclosure
2. Test with different user roles

**Expected Results**:
- Check for data exposure
- Verify error handling
- Test for information disclosure

### 4. File Upload Testing

#### Test Case 4.1: File Upload Security
**Target**: File upload functionality
**Test Steps**:
1. Test file upload with:
   - Malicious file types
   - Large file sizes
   - Path traversal attempts
   - XSS in file names
2. Test file processing

**Expected Results**:
- Check for file type validation
- Verify size limits
- Test for path traversal
- Check for XSS vulnerabilities

#### Test Case 4.2: File Processing
**Target**: File processing endpoints
**Test Steps**:
1. Upload various file types
2. Test file processing:
   - Image processing
   - Document processing
   - Archive processing
3. Test for code execution

**Expected Results**:
- Check for code execution
- Verify file processing security
- Test for path traversal

### 5. Business Logic Testing

#### Test Case 5.1: Task Management
**Target**: Task creation/management
**Test Steps**:
1. Create tasks with:
   - Invalid data
   - XSS payloads
   - SQL injection attempts
2. Test task approval process (staging)

**Expected Results**:
- Check for input validation
- Verify XSS protection
- Test for SQL injection

#### Test Case 5.2: User Role Testing
**Target**: Role-based access
**Test Steps**:
1. Test with different user roles
2. Test privilege escalation
3. Test role modification

**Expected Results**:
- Check for privilege escalation
- Verify role-based access
- Test for role manipulation

## Testing Tools & Commands

### Burp Suite Configuration
```
Proxy Settings:
- Intercept requests
- Modify parameters
- Test for vulnerabilities

Repeater:
- Test parameter manipulation
- Verify responses
- Test for vulnerabilities
```

### Manual Testing Commands
```bash
# Test for SSRF
curl -X POST "https://api.anytask.com/endpoint" \
  -H "Authorization: Bearer <token>" \
  -d "url=http://169.254.169.254/"

# Test for IDOR
curl -X GET "https://api.anytask.com/user/12345" \
  -H "Authorization: Bearer <token>"

# Test for XSS
curl -X POST "https://api.anytask.com/endpoint" \
  -H "Authorization: Bearer <token>" \
  -d "name=<script>alert('XSS')</script>"
```

## Testing Workflow

### Phase 1: Setup (Day 1)
1. Set up test accounts
2. Configure testing tools
3. Map application functionality
4. Identify key endpoints

### Phase 2: Low-Risk Testing (Day 2-3)
1. Input validation testing
2. Basic vulnerability scanning
3. Authentication flow analysis
4. API endpoint discovery

### Phase 3: High-Impact Testing (Day 4-5)
1. Payment logic testing (staging)
2. Business logic manipulation
3. IDOR testing
4. Authentication bypass attempts

### Phase 4: Production Verification (Day 6-7)
1. Confirm findings on production
2. Document all vulnerabilities
3. Create proof of concepts
4. Prepare reports

## Reporting Template

### Vulnerability Report Structure
```
Title: [Vulnerability Type] in [Component]

Summary:
- Brief description of the vulnerability
- Impact assessment
- Affected components

Steps to Reproduce:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Proof of Concept:
- Screenshots/videos
- Request/response examples
- Exploitation steps

Impact:
- Business impact
- Security implications
- Affected users

Recommendations:
- Fix suggestions
- Security improvements
- Best practices
```

## Success Metrics

### High-Value Findings
1. **Payment manipulation** - Financial impact
2. **Authentication bypass** - Account takeover
3. **IDOR vulnerabilities** - Data exposure
4. **Business logic flaws** - Platform manipulation

### Testing Priorities
1. **Payment & checkout flows** (highest priority)
2. **Authentication mechanisms**
3. **API endpoint security**
4. **File upload functionality**
5. **User data access controls**

---
*Test Cases Created: August 17, 2025*
*Target: anytask.com Bug Bounty Program*
*Status: Ready for Testing*
