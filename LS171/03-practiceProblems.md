# Practice Problems:  The Request Response Cycle
https://launchschool.com/lessons/cc97deb5/assignments/83ae67aa

---

## 1
What are the required components of an HTTP request? What are the additional optional components?

- required: method, path  (together form the "start-line" or "request-line");  `Host` header is also required
- optional: parameters, all other headers, body

- domain name is used to determine where to send the request TO, but not the part of the actual HTTP request

---

## 2
What are the required components of an HTTP response? What are the additional optional components?

- required: status (numeric code and short text, "200 OK")
- optional:  headers (Content-Type: text/html), body (actual data sent)

- status e.g., 200 OK

---

## 3
What determines whether a request should use GET or POST as its HTTP method?

- `GET` : used to retrieve information from a server (main information on the server doesn't change) (e.g., display search results, display a webpage that tracks how many times it is viewed [main info doesn't change])
- `POST` : used to change values stored on the server (e.g., submit forms)

