# Anytask.com Bug Bounty Testing Strategy

## Program Rules Compliance

### ✅ Authorized Testing Scope
- **Production**: `https://www.anytask.com/`, `https://api.anytask.com/`
- **Staging**: `https://anytask.thesecurityteam.rocks/`, `https://api.anytask.thesecurityteam.rocks/`
- **Mobile Apps**: Android & iOS applications

### ❌ Prohibited Actions
- **No direct seller contact** on production
- **No user data access** (use own test accounts only)
- **No DoS attacks** or platform disruption
- **No content modification** or deletion
- **No out-of-scope subdomain testing**

## Testing Environment Setup

### Production Testing Account
```
Email: kamalesh2428k@bugcrowdninja.com
Password: K@malesH
```

### Staging Environment Access
```
Main URL: https://anytask.thesecurityteam.rocks/
Admin URL: https://anytask.thesecurityteam.rocks/admin/
Admin Username: hacker-anytasks-admin@thesecurityteam.rocks
Admin Password: hacker-anytasks-admin@thesecurityteam.rocks
Test Payment Card: 4111 1111 1111 1111
Email Access: http://stagemail.thesecurityteam.rocks/stagemailanytasks.php
```

## High-Priority Testing Areas

### 1. Payment & Business Logic (High Impact)
**Target**: `/shopping/basket/apply-discount-code` endpoint
**Test Cases**:
- Discount code manipulation and bypass
- Payment amount tampering
- Billing address validation bypass
- Checkout flow manipulation

**Staging Testing**:
- Use test card: `4111 1111 1111 1111`
- Test admin approval workflow
- Verify 10-minute checkout completion

### 2. Authentication & Session Management
**Target**: JWT token system
**Test Cases**:
- JWT token manipulation and replay
- Session fixation attacks
- Authentication bypass techniques
- Token expiration handling

### 3. API Security Testing
**Target**: `https://api.anytask.com/`
**Test Cases**:
- IDOR in user data access
- Parameter tampering in API calls
- SSRF through API endpoints
- Sensitive data exposure

### 4. File Upload Security
**Test Cases**:
- XSS through file uploads
- Path traversal vulnerabilities
- File type validation bypass
- Malicious file execution

## Testing Methodology

### Phase 1: Reconnaissance (Safe)
1. **Subdomain enumeration** (in-scope only)
2. **Technology stack identification**
3. **API endpoint discovery**
4. **Authentication mechanism analysis**

### Phase 2: Low-Risk Testing
1. **Input validation testing**
2. **Parameter manipulation**
3. **Header injection**
4. **Basic XSS testing**

### Phase 3: High-Impact Testing (Staging First)
1. **Payment logic manipulation**
2. **Authentication bypass**
3. **Business logic flaws**
4. **Multi-user affecting vulnerabilities**

### Phase 4: Production Verification
1. **Confirm findings on production**
2. **Document impact and exploitability**
3. **Create proof of concept**

## Excluded Vulnerability Types

### ❌ Out of Scope
- P5 vulnerabilities
- UX issues without security impact
- Third-party library vulnerabilities
- MITM or physical access attacks
- DoS attacks
- Rate limiting issues
- Race conditions
- Password complexity issues
- Clickjacking on non-sensitive pages

### ✅ In Scope (After 14 Days)
- N-day vulnerabilities (14 days after public disclosure)
- Third-party 0-day (14 days after disclosure)

## Testing Tools & Techniques

### Recommended Tools
- **Burp Suite Professional** - API testing and manipulation
- **OWASP ZAP** - Automated vulnerability scanning
- **Postman** - API endpoint testing
- **Custom scripts** - Business logic testing
- **Browser dev tools** - Client-side analysis

### Testing Techniques
1. **Manual Testing**
   - Business logic analysis
   - Authentication flow testing
   - Payment process manipulation

2. **Automated Testing**
   - Parameter fuzzing
   - Input validation testing
   - Basic vulnerability scanning

3. **Hybrid Approach**
   - Automated discovery + manual verification
   - Systematic endpoint testing
   - Progressive complexity testing

## Reporting Guidelines

### Required Information
1. **Clear attack scenario**
2. **Demonstrable exploitability**
3. **Security impact assessment**
4. **Proof of concept**
5. **Reproduction steps**

### Report Quality Standards
- **Detailed impact analysis**
- **Step-by-step reproduction**
- **Screenshots/videos of exploitation**
- **Business impact assessment**

## Risk Management

### Safe Testing Practices
1. **Use staging environment** for high-impact testing
2. **Create separate test accounts** for each test case
3. **Avoid production disruption**
4. **Document all findings** immediately
5. **Test incrementally** to avoid detection

### Escalation Process
1. **Low-risk findings** - Direct reporting
2. **High-impact findings** - Staging verification first
3. **Critical findings** - Immediate reporting with staging confirmation

## Success Metrics

### High-Value Targets
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

## Timeline & Milestones

### Week 1: Setup & Reconnaissance
- [ ] Set up test accounts
- [ ] Complete infrastructure analysis
- [ ] Map all API endpoints
- [ ] Identify authentication mechanisms

### Week 2: Low-Risk Testing
- [ ] Input validation testing
- [ ] Parameter manipulation
- [ ] Basic vulnerability scanning
- [ ] Authentication flow analysis

### Week 3: High-Impact Testing
- [ ] Payment logic testing (staging)
- [ ] Business logic manipulation
- [ ] IDOR testing
- [ ] Authentication bypass attempts

### Week 4: Production Verification
- [ ] Confirm findings on production
- [ ] Document all vulnerabilities
- [ ] Create proof of concepts
- [ ] Prepare reports

## Compliance Checklist

### Before Testing
- [ ] Confirm in-scope targets only
- [ ] Set up test accounts
- [ ] Review program rules
- [ ] Plan testing approach

### During Testing
- [ ] Use own test accounts only
- [ ] Avoid production disruption
- [ ] Test high-impact on staging first
- [ ] Document all findings

### After Testing
- [ ] Verify findings on production
- [ ] Create detailed reports
- [ ] Include proof of concepts
- [ ] Assess business impact

---
*Strategy Created: August 17, 2025*
*Target: anytask.com Bug Bounty Program*
*Compliance: Program Rules & Guidelines*
