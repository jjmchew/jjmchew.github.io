# Burns

## Python
- create nested arrays (for caches) using list comprehensions:
  - i.e., `cache = [ [-1 for _ in range(len(text2))] for _ in range(len(text1))]`
  - NOT `[ [-1]*len(text2) ]*len(text)` : the nested subarray will be copied and changing any element will be reflected in every sub-array


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
