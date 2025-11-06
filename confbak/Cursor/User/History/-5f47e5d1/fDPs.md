# Anytask.com Bug Bounty Testing Checklist

## Pre-Testing Setup ✅

### Account Setup
- [ ] Production account: `kamalesh2428k@bugcrowdninja.com`
- [ ] Staging account access confirmed
- [ ] Admin credentials: `hacker-anytasks-admin@thesecurityteam.rocks`
- [ ] Test payment card: `4111 1111 1111 1111`

### Tool Configuration
- [ ] Burp Suite configured
- [ ] Browser dev tools ready
- [ ] Postman/API testing tool setup
- [ ] Screenshot/video recording ready

### Environment Access
- [ ] Production: `https://www.anytask.com/`
- [ ] API: `https://api.anytask.com/`
- [ ] Staging: `https://anytask.thesecurityteam.rocks/`
- [ ] Admin panel: `https://anytask.thesecurityteam.rocks/admin/`

## Phase 1: Reconnaissance (Day 1)

### Application Mapping
- [ ] Homepage functionality analysis
- [ ] User registration/login flow
- [ ] Task creation process
- [ ] Payment/checkout flow
- [ ] User dashboard features

### API Endpoint Discovery
- [ ] Network tab analysis for API calls
- [ ] JWT token structure analysis
- [ ] Authentication mechanism identification
- [ ] Key endpoints documentation

### Technology Stack
- [ ] Frontend framework identification
- [ ] Backend technology analysis
- [ ] Database type identification
- [ ] Third-party integrations

## Phase 2: Low-Risk Testing (Day 2-3)

### Input Validation Testing
- [ ] Text input fields (XSS testing)
- [ ] Numeric input fields (SQL injection)
- [ ] File upload fields (malicious files)
- [ ] URL parameters (injection testing)

### Authentication Testing
- [ ] Login form testing
- [ ] Registration form testing
- [ ] Password reset functionality
- [ ] Session management analysis

### Basic Vulnerability Scanning
- [ ] Automated vulnerability scan
- [ ] Manual parameter testing
- [ ] Header manipulation
- [ ] Cookie analysis

## Phase 3: High-Impact Testing (Day 4-5)

### Payment Logic Testing (Staging First)
- [ ] Discount code manipulation
- [ ] Payment amount tampering
- [ ] Billing address validation bypass
- [ ] Checkout flow manipulation
- [ ] Test with staging card: `4111 1111 1111 1111`

### Authentication Bypass Testing
- [ ] JWT token manipulation
- [ ] Session fixation attacks
- [ ] Authentication bypass attempts
- [ ] Privilege escalation testing

### IDOR Testing
- [ ] User data access testing
- [ ] Task data access testing
- [ ] Profile modification testing
- [ ] Cross-user data access

### Business Logic Testing
- [ ] Task creation manipulation
- [ ] User role testing
- [ ] Admin functionality testing
- [ ] Workflow bypass testing

## Phase 4: Production Verification (Day 6-7)

### Finding Confirmation
- [ ] Verify findings on production
- [ ] Test exploitability
- [ ] Document impact assessment
- [ ] Create proof of concepts

### Report Preparation
- [ ] Document all findings
- [ ] Create detailed reports
- [ ] Include screenshots/videos
- [ ] Prepare reproduction steps

## Daily Testing Routine

### Morning Setup (30 minutes)
- [ ] Check staging environment access
- [ ] Review previous day's findings
- [ ] Plan day's testing focus
- [ ] Set up testing tools

### Testing Session (4-6 hours)
- [ ] Focus on one vulnerability type
- [ ] Document all attempts
- [ ] Take screenshots of interesting responses
- [ ] Note any unusual behavior

### Evening Review (30 minutes)
- [ ] Document findings
- [ ] Update testing notes
- [ ] Plan next day's focus
- [ ] Backup testing data

## High-Priority Test Cases

### Payment Testing (Highest Priority)
- [ ] **Discount Code Manipulation**
  - [ ] Test negative discount values
  - [ ] Test extremely large discounts
  - [ ] Test discount code reuse
  - [ ] Test discount stacking

- [ ] **Payment Amount Tampering**
  - [ ] Modify payment amounts in requests
  - [ ] Test currency manipulation
  - [ ] Test negative amounts
  - [ ] Test decimal precision

- [ ] **Billing Address Bypass**
  - [ ] Test empty billing address
  - [ ] Test API bypass (as per rules)
  - [ ] Test invalid address formats
  - [ ] Test address validation

### Authentication Testing
- [ ] **JWT Token Manipulation**
  - [ ] Modify user ID in token
  - [ ] Change token expiration
  - [ ] Test with invalid signatures
  - [ ] Test token replay attacks

- [ ] **Session Management**
  - [ ] Test session fixation
  - [ ] Test concurrent sessions
  - [ ] Test session timeout
  - [ ] Test session hijacking

### API Security Testing
- [ ] **IDOR Testing**
  - [ ] Access other user's data
  - [ ] Modify other user's information
  - [ ] Test with different user IDs
  - [ ] Test parameter manipulation

- [ ] **SSRF Testing**
  - [ ] Test with internal IPs
  - [ ] Test with AWS metadata endpoint
  - [ ] Test with localhost
  - [ ] Test with internal network ranges

## Testing Tools Usage

### Burp Suite
- [ ] Configure proxy settings
- [ ] Set up target scope
- [ ] Configure repeater for testing
- [ ] Use intruder for parameter fuzzing

### Browser Dev Tools
- [ ] Network tab for API analysis
- [ ] Console for JavaScript errors
- [ ] Application tab for storage analysis
- [ ] Security tab for certificate analysis

### Manual Testing
- [ ] Parameter manipulation
- [ ] Header modification
- [ ] Cookie manipulation
- [ ] URL manipulation

## Documentation Requirements

### For Each Finding
- [ ] Clear title and description
- [ ] Step-by-step reproduction
- [ ] Screenshots/videos
- [ ] Request/response examples
- [ ] Impact assessment
- [ ] Fix recommendations

### Testing Notes
- [ ] Daily testing log
- [ ] Finding documentation
- [ ] Tool configuration notes
- [ ] Environment access notes

## Safety Reminders

### Program Compliance
- [ ] Use only in-scope targets
- [ ] Use own test accounts only
- [ ] Test high-impact on staging first
- [ ] Avoid production disruption
- [ ] No DoS attacks
- [ ] No user data access

### Testing Ethics
- [ ] Document all actions
- [ ] Report findings responsibly
- [ ] Follow program rules
- [ ] Maintain professional conduct

## Success Metrics

### High-Value Targets
- [ ] Payment manipulation vulnerabilities
- [ ] Authentication bypass
- [ ] IDOR vulnerabilities
- [ ] Business logic flaws
- [ ] File upload vulnerabilities

### Testing Progress
- [ ] Daily testing goals met
- [ ] Findings documented
- [ ] Reports prepared
- [ ] Program rules followed

---
*Checklist Created: August 17, 2025*
*Target: anytask.com Bug Bounty Program*
*Status: Ready for Testing*
