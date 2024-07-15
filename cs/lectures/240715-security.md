# Basecamp notes on securing our application


Application security is a requirement, not a feature. One of the biggest red flags for engineers reviewing your project code will be critical security bugs.  Although the world of security is vast, there are a number of basic security practices that every engineer should be aware of and follow.

Think of application security like safeguarding your home. While it's impossible to make any house or system entirely impenetrable, there are basic precautions everyone should take. In the same way that we lock our doors and don't leave keys in obvious spots, there are fundamental measures in software to prevent easy breaches. If we skip these steps, we're inviting trouble.

Just as homeowners follow basic practices, developers should too. The difference? While most people know not to leave their front door open, the basics of software security aren't always obvious. We might not achieve 100% security, but we should cover the essentials. This way, if an issue arises, we know we've done our part.

This document outlines those essential security practices for software. Think of it as your checklist for keeping the digital "doors" locked.

As you implement your project, and before you wrap up, review the following list and ensure that you adhere to the following practices:

Note that for each item, we've included some optional reading and resources to understand these concepts in more detail.


## 1. Secure Communication (SSL/TLS)

    Ensure SSL/TLS: Always ensure your application and project website uses SSL/TLS for encrypted communication.
        Check and obtain valid SSL certificates.
        Configure servers to enforce HTTPS.
        Monitor certificate expiration dates.
    Further Reading:
        Why is SSL Important? https://www.cloudflare.com/learning/ssl/what-is-ssl/
        Let's Encrypt – Free SSL/TLS Certificates. :  https://letsencrypt.org/


## 2. Proper Documentation

    Placeholder URLs: Avoid using placeholder URLs. Always have valid, descriptive links.
        Replace "example.com" or "insert your name here" with relevant URLs or notes.
    Descriptive Comments: Ensure comments are descriptive and helpful to other developers. Don't check in any unprofessional comments, or comments with any sensitive data about application internals. 


## 3. Secrets Management [CRITICAL]

    Never hardcode secrets, even when prototyping: Avoid placing secrets directly in your codebase. This is a common mistake. Hard-coded secrets can be accidentally committed and pushed, exposing them.
    Never Check in Secrets: .env files or any file containing keys, secrets, and passwords should never be checked into version control.
        Use .gitignore to prevent accidental check-ins.
    Use Secret Management Tools: Store and manage secrets using tools or platforms designed for it.
        Examples: AWS Secrets Manager : https://aws.amazon.com/secrets-manager/
    Further Reading:
        Best Practices for API Keys and Secrets: https://blog.gitguardian.com/secrets-api-management/
        12 Factor App: Config : https://12factor.net/config


## 4. Code Cleanliness and Maintenance

    Avoid Redundant/WIP Files: Only commit necessary files. Remove work-in-progress files or use branches for in-progress work.
    Remove Commented Code: Don't include commented-out code. If the code isn't needed, remove it. Rely on version control for history.
        If there's a reason to keep the code (e.g., for reference), comment with a clear explanation.
    Logging Best Practices:
        Avoid console logging sensitive information.
        Use proper logging libraries that allow different log levels.
        Always remove personal debug logs before committing.
    Further Reading:
        Proper Logging Practices: https://levelup.gitconnected.com/9-logging-best-practices-da9457e33305


## 5. Authentication and Authorization

    Storing Passwords: If your application includes user information like passwords: 
        Make sure to salt and hash passwords before storing them in the database. 
        Validate passwords by comparing a hashed password using the same salt. 
        Cryptography and random number generation is easy to get wrong. Use a library like bcrypt (https://www.npmjs.com/package/bcrypt).
        Never store passwords as plaintext.
    Secure Authentication: Ensure that authentication processes are robust and use industry standards.
        Prefer token-based authentication like JWT.
        Tokens should be short-lived.
    Authorization Checks: Always check if the user has the correct permissions to perform actions, especially for critical operations like deletions.
        Make sure all external endpoints for write/update/destory operations are authenticated
        Implement authorization on internal services, not just API endpoints
        Implement role-based access controls (RBAC) if possible.
    Further Reading:
        How to store/validate passwords safely: https://blog.bytebytego.com/p/how-does-https-work-episode-6?utm_source=%2Fsearch%2Fsalt&utm_medium=reader2
        Auth0 - Adding salt to hashing: https://auth0.com/blog/adding-salt-to-hashing-a-better-way-to-store-passwords/
        JWT: https://jwt.io/introduction/
        OWASP Access Control: https://owasp.org/Top10/A01_2021-Broken_Access_Control/


## 6. Database Security

    Prevent SQL Injections: Always use parameterized queries or prepared statements. Never concatenate or interpolate user form input directly into SQL.
    Limit Database Permissions: Use the principle of least privilege. Database connections should have the minimal necessary permissions.
    Regular Backups: Ensure databases are regularly backed up and that backups are securely stored.
    Further Reading:
        OWASP SQL Injection Prevention Cheat Sheet: https://owasp.org/www-project-cheat-sheets/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html


## 7. Cross-Site Scripting (XSS)

    Sanitize Input: Always validate and sanitize user input before rendering it on the page.
    Use Content Security Policy (CSP): Implement CSP headers to reduce the risk of XSS attacks.
    Further Reading:
        OWASP XSS Prevention Cheat Sheet: https://owasp.org/www-project-cheat-sheets/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html
        Content Security Policy (CSP): https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP


## Further resources

- Open Web Application Security Practices (OWASP) Cheat Sheet: https://cheatsheetseries.owasp.org/IndexProactiveControls.html
  - Summary of proactive application security practices. Includes resources for many languages and frameworks, so focus on client-side, language-agnostic server-side, and REST practices — good initial resource without getting overwhelmed.
- Open Web Application Security Practices (OWASP) Checklist: https://owasp.org/www-project-developer-guide/draft/design/web_app_checklist/
    - This can be considered a gold standard of basic security practices.  
- What Every Junior Developer Should Know About Software Security: https://mannes.tech/software-security/
    - A gentler introduction and illustration of many of the requirements listed above
Secure By Design: https://www.manning.com/books/secure-by-design
    - A more in-depth look at best practices when designing and implementing applications. More in-depth and conceptual than required for Capstone, but it is a great follow-up book in the first year of your career.