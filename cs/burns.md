# Burns

## Python
- create nested arrays (for caches) using list comprehensions:
  - i.e., `cache = [ [-1 for _ in range(len(text2))] for _ in range(len(text1))]`
  - NOT `[ [-1]*len(text2) ]*len(text)` : the nested subarray will be copied and changing any element will be reflected in every sub-array

- ALWAYS double-check debug statements (e.g., like `print`):
  - I was trying to print the output of a method call, but I FORGOT the `print` statement and was just invoking the method, with no way of logging or viewing the output: *stupid*



## SQL
- SQL strings need to have single quotes:  i.e, 'value', NOT "value"



## VPS
- check container size before deploying to a VPS w/ containers
  - I tried to deploy 1.2 gb of db images to a VPS with only 512 mb of RAM - not ideal

- coordinate multiple docker containers using `docker compose`
  - this is much easier than running multiple `docker run` statements and trying to coordinate settings


- using a 301 to redirect http requests can change all received http methods to 'get'
  - using a 308 redirect can be safer:  https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/308


- `git add .` only adds files within the CURRENT folder directory tree
  - since I'm using front / back in separate directories, changes in back won't be reflected in git if I'm in front


- it's probably better to serve static files from NGINX, rather than express
  - when express served `.js` files, it left the content type as text/html - which caused errors with firefox
  - nginx does a better job of serving static files (hence addition of pattern match to nginx config to serve static files from usual root folder in vps)



## React
- when using `React.createElement`: listing children within an array creates a mutable list which is why each child requires a KEY
  - if you just list the children as comma-separated parameters, then no key is necessary since the order of those children will be fixed

- routing (this bug cropped up when I was using "wouter", but is relevant to react router, as well):
  - generally, don't use "navigate" - i.e., don't use a method to push the user to another page
  - where any processing needs to be done before displaying that page, rather than doing it in a click handler in the PREVIOUS page, do it in a useEffect in the SUBSEQUENT page
  - generally, anywhere a click results in a new page (i.e., anywhere you would use an <a> tag, you should put a <Link> tag)
  - must use `navigate` to click outside of something (e.g., like closing a modal, on "blur")

- when passing setters (and using Typescript) the proper type should be:
  - `React.Dispatch<React.SetStateAction<T>>` where T is the type of the state variable
    - this assumes `import React from 'react'`
  - using the above allows you to set a "dummy" function for the setter if you're just defining initial types
    - e.g., `() => {}` will be a valid React.Dispatch function





## Testing (React)
- when using `.getByRole` for inputs, the `name` property is actually the value of the `label` property on the input, not the actual value of the `<label>` tag (i.e., the text value between the tags)






## JS
- using *fetch*:
  - when sending json data in body you *must* always set headers:
    - i.e., `"Content-Type": "application/json"`
  - otherwise, a receiving express server will not parse the data as JSON (it will receive nothing if JSON parser is enabled)







## Express
- if I create a middleware, that middleware is re-loaded on each request






## Research
- from numDialer project research (how to send real-time updates to client)
  - need to really dig, it can be helpful to use AI to assess ALL options
  - from initial digging I found websockets and HTTP streaming, but didn't find SSE (server sent events)
  - as a result, I almost went down the road of implementing websockets (which would likely have been more difficult and less ideal)
  - make sure you try and do exhaustive research:
    - need to write your query in different ways to see what is returned

