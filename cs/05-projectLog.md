# Capstone project log (RAG)

## Tuesday June 25, 2024 - W8D2
- played with milvus via docker container again
  - followed tutorial here: https://milvus.io/docs/install_standalone-docker.md


  - had to create a new python virtual environment:
    - `pipenv --python 3.12.2` inside the desired project folder (new virtual environment gets created)
    - `pipenv shell` : activates the virtual environment
    - `pipenv install pymilvus` : install milvus client library
    - `pipenv install torch` : install pyTorch and other models (apparently used by milvus)
    - had to downgrade numpy: `pipenv run pip install numpy==1.25`
    - `pipenv install pymupdf`
    - `pipenv install spacy`
    - `pipenv run python -m spacy download en_core_web_sm`
    - `pipenv install fastapi`
    - `pipenv install openai`

- worked on trying to get rag repo to run locally
  - no luck - same error with vector.db being opened by another program already
  - eventually this worked, but must run fastapi in production mode (i.e., `fastapi run main.py`)
  - 
- Other topics
  - default embedding function:
    - https://milvus.io/docs/embeddings.md#Example-1-Use-default-embedding-function-to-generate-dense-vectors
  
  - looked at re-rankers
    - may be useful if vector search results are not accurate
    - https://milvus.io/docs/rerankers-overview.md
    - https://www.pinecone.io/learn/series/rag/rerankers/




- looked at python modules:  https://docs.python.org/3/tutorial/modules.html
  - need to put an `__init__.py` file in each directory which is part of the package (i.e., the root and subdirectories)
  - this file can be empty OR contain initialization code


- read conventional commits link



## Group meeting
- discussed our-infra vs user-infra solutions
  - questions:  how does our-infra vs user-infra really differ?  Does a choice of either affect scaling? (i.e., does one choice involve more scaling than another?)
  - agreed to wait until first meeting with Chris



## Wed June 26, 2024 - W8D3

### REST API security
- https://stackoverflow.blog/2021/10/06/best-practices-for-authentication-and-authorization-for-rest-apis/
  - use https
  - use OAuth2 (w/ OpenID Connect, if possible)
    - store credentials (tokens) as secure cookies
    - use SameSite=Strict
  - issue API keys
    - `const token = crypto.randomBytes(32).toString('hex')`
    - keys should be stored and associated with user
    - have users provide API keys as header
    - compare submitted API key to db to confirm
  - use request middleware for request-level authorization
    - i.e., middleware retrieves stored keys and checks token permissions against submitted key
  - consider if different API keys can be used for different permission levels

- library for authentication (JS):  https://www.passportjs.org/docs/

- express code example:
  https://caffeinecoding.com/leveraging-express-middleware-to-authorize-your-api/#more-and-more-middleware

- https://www.permit.io/blog/best-practices-for-api-authentication-and-authorization
  - JWT (Json Web Tokens) are standard
  - e.g., use OAuth 2.0 to authenticate, issue a token and use this token for subsequent API calls
  - service-to-service calls may exchange signed JWT tokens to authenticate (using keys)
  - implement rate limiting and throttling
  - monitor and log authentication attempts

  - open-source library for auth (centralized library) https://github.com/permitio/opal

- https://curity.io/resources/learn/api-security-best-practices/
  - use an API gateway (helps to enforce rate limiting, logging, etc.) to centralize security, rather than implement for each API
  - use an OAuth server to issue / refresh tokens


### General RAG / AI related research
- see RAG google sheets

### Skateboard
- confirmed updated repo works locally (no errors in dev mode)