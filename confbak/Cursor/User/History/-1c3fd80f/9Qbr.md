# Guide: Phase 1 Reconnaissance with Burp Suite


[[Ad]]
## 🎯 What You'll Learn

- How to use Burp Suite for basic reconnaissance
- What to look for during homepage analysis
- How to document your findings
- What clues indicate potential vulnerabilities

## 📋 Step-by-Step Process

### Step 1: Burp Suite Setup (5 minutes)

#### 1.1 Configure Burp Suite
```
1. Open Burp Suite Community/Professional
2. Go to Proxy → Options
3. Set Intercept to "Intercept is OFF" (for now)
4. Go to Target → Add to scope: https://www.anytask.com
5. Go to Target → Add to scope: https://api.anytask.com
```

#### 1.2 Configure Browser
```
1. Set browser proxy to 127.0.0.1:8080
2. Install Burp's CA certificate (if needed)
3. Test connection by visiting anytask.com
```

### Step 2: Homepage Functionality Analysis (30 minutes)

#### 2.1 Basic Navigation
**What to do:**
1. Visit `https://www.anytask.com`
2. Click through all visible links
3. Try to register a new account
4. Try to login (use your test account)

**What to observe in Burp Suite:**
- Go to **Proxy → HTTP History**
- Look for requests to anytask.com
- Check the **Target** tab for discovered endpoints

**🔍 What to look for:**
```
✅ Good signs (potential attack surface):
- Multiple API calls (lots of requests)
- Authentication endpoints (/login, /register)
- File upload functionality
- Payment-related endpoints (/checkout, /payment)

❌ Red flags to investigate:
- Error messages in responses
- Debug information exposed
- Sensitive data in responses
- Unusual redirects
```

#### 2.2 Registration Process Analysis
**What to do:**
1. Click "Register" or "Sign Up"
2. Fill out the registration form
3. Submit the form
4. Check your email (use staging email: http://stagemail.thesecurityteam.rocks/stagemailanytasks.php)

**What to observe:**
```
In Burp Suite → HTTP History, look for:

🔍 Registration Request:
POST /api/register (or similar)
- Check for parameters: email, password, name
- Look for validation errors
- Check response for user ID or tokens

🔍 Clues to investigate:
- Weak password requirements
- Email validation bypass
- User ID exposure in response
- JWT token in response
```

#### 2.3 Login Process Analysis
**What to do:**
1. Use your test account: `kamalesh2428k@bugcrowdninja.com`
2. Try different passwords
3. Check "Remember me" functionality
4. Try password reset

**What to observe:**
```
🔍 Login Request Analysis:
POST /api/login (or similar)

Look for:
- JWT tokens in response
- Session cookies
- User ID or profile data
- Error messages for wrong passwords

🔍 Security Clues:
- Rate limiting (too many failed attempts)
- Account lockout mechanisms
- Password complexity requirements
- 2FA implementation
```

### Step 3: API Endpoint Discovery (20 minutes)

#### 3.1 Network Tab Analysis
**What to do:**
1. Open browser Dev Tools (F12)
2. Go to Network tab
3. Clear the log
4. Navigate through the website
5. Look for API calls

**🔍 What to look for:**
```
API Endpoints to document:
- /api/auth/login
- /api/auth/register
- /api/user/profile
- /api/tasks/create
- /api/payment/process
- /api/upload/file
- /api/admin/* (if accessible)
```

#### 3.2 Burp Suite Target Tab Analysis
**What to do:**
1. Go to **Target → Site map**
2. Expand anytask.com
3. Look for interesting endpoints

**🔍 What to look for:**
```
Interesting endpoints:
- /admin/ (admin panel)
- /api/ (API endpoints)
- /upload/ (file upload)
- /payment/ (payment processing)
- /user/ (user management)
- /tasks/ (task management)
```

### Step 4: Authentication Mechanism Analysis (15 minutes)

#### 4.1 JWT Token Analysis
**What to do:**
1. Login to the application
2. In Burp Suite, find the login request
3. Look for JWT tokens in responses
4. Copy the token and decode it

**🔍 How to decode JWT:**
```
1. Copy the JWT token from response
2. Go to https://jwt.io
3. Paste the token
4. Look for:
   - User ID
   - Role/permissions
   - Expiration time
   - Signature algorithm
```

**🔍 What to look for:**
```
JWT Analysis Clues:
- User ID in token (for IDOR testing)
- Role information (for privilege escalation)
- Weak signature (for token manipulation)
- Long expiration (for session hijacking)
- Sensitive data in token
```

#### 4.2 Session Management Analysis
**What to do:**
1. Login and capture session cookies
2. Test session timeout
3. Test concurrent sessions

**🔍 What to look for:**
```
Session Security Clues:
- HttpOnly cookies (good security)
- Secure flag on cookies
- Session timeout duration
- Concurrent session handling
- Session fixation vulnerabilities
```

### Step 5: Technology Stack Identification (10 minutes)

#### 5.1 Response Headers Analysis
**What to do:**
1. Look at response headers in Burp Suite
2. Check for technology indicators

**🔍 What to look for:**
```
Technology Indicators:
- Server: nginx/apache (web server)
- X-Powered-By: PHP/Node.js (backend)
- X-Framework: Laravel/Django (framework)
- X-Version: version numbers
- Set-Cookie: session management
```

#### 5.2 JavaScript Analysis
**What to do:**
1. Look at JavaScript files loaded
2. Check for API endpoints in JS
3. Look for sensitive information

**🔍 What to look for:**
```
JavaScript Clues:
- API endpoints hardcoded
- API keys or tokens
- Debug information
- Error handling
- Third-party libraries
```

## 📝 How to Document Your Findings

### Create a Findings Log
```
Date: [Today's Date]
Target: anytask.com
Phase: 1 - Reconnaissance

FINDINGS LOG:
================

1. AUTHENTICATION MECHANISM
   - Method: JWT tokens
   - Endpoint: /api/auth/login
   - Token format: Bearer <token>
   - User ID in token: Yes/No
   - Role in token: Yes/No

2. API ENDPOINTS DISCOVERED
   - /api/auth/login
   - /api/auth/register
   - /api/user/profile
   - /api/tasks/create
   - /api/payment/process

3. TECHNOLOGY STACK
   - Backend: [PHP/Node.js/etc]
   - Framework: [Laravel/Django/etc]
   - Database: [MySQL/PostgreSQL/etc]
   - Frontend: [React/Vue/etc]

4. SECURITY OBSERVATIONS
   - Rate limiting: Yes/No
   - CSRF protection: Yes/No
   - Input validation: Weak/Strong
   - Error handling: Verbose/Minimal

5. POTENTIAL ATTACK VECTORS
   - JWT manipulation
   - IDOR in user endpoints
   - File upload vulnerabilities
   - Payment manipulation
```

### Screenshot Important Findings
```
Take screenshots of:
1. JWT token structure
2. API response with user data
3. Error messages
4. Interesting endpoints
5. Technology indicators
```

## 🚨 Red Flags to Investigate Further

### High-Priority Clues
```
🔴 CRITICAL (Investigate immediately):
- User ID in JWT token
- Admin endpoints accessible
- Payment endpoints without proper validation
- File upload without restrictions
- Sensitive data in responses

🟡 MEDIUM (Test in staging):
- Weak input validation
- Verbose error messages
- Missing security headers
- Rate limiting bypass
- Session management issues

🟢 LOW (Document for later):
- Technology stack information
- API endpoint structure
- Authentication flow
- User interface elements
```

## 🎯 Next Steps After Phase 1

### What to Do Next
1. **Document all findings** in your log
2. **Take screenshots** of interesting responses
3. **List all API endpoints** discovered
4. **Identify authentication mechanism**
5. **Note potential attack vectors**

### Prepare for Phase 2
1. **Set up staging environment** access
2. **Create test accounts** for different scenarios
3. **Plan specific test cases** based on findings
4. **Prepare testing tools** for Phase 2

## 💡 Pro Tips for Beginners

### Burp Suite Tips
```
1. Always check the Target tab after browsing
2. Use the Repeater to test individual requests
3. Use the Intruder for parameter fuzzing
4. Use the Scanner for automated testing
5. Always save your project
```

### Documentation Tips
```
1. Take screenshots of everything interesting
2. Copy request/response examples
3. Note exact URLs and parameters
4. Record error messages
5. Keep a testing log
```

### Safety Tips
```
1. Test on staging environment first
2. Use your own test accounts only
3. Don't modify other users' data
4. Follow program rules strictly
5. Document everything you do
```

---
*Beginner's Guide Created: August 17, 2025*
*Target: anytask.com Bug Bounty Program*
*Level: Beginner-Friendly*
