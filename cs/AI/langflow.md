# Langflow notes

- https://docs.langflow.org/getting-started/install-langflow

- ~21k stars on github
- still appears to be open-source
- previously may have been a private company, but was acquired by DataStax on Apr 4, 2024 (most recent acquisition)
  - DataStax is much bigger

- uses LangChain under-the-hood
  - e.g., vector db stores are all LangChain wrappers
  - methods deprecate quickly (e.g., weaviate, pydantic)



- installed using `pipenv install langflow`
  - it hung up a bit on installing dependencies, but ultimately worked
  - I actually started the localhost server in a different terminal window before the dependencies had appeared to be complete

- `python -m langflow run`

- flows are exported as json - appears quite complete
  - added node for URL shows the selected URL in the JSON template (hard-coded)

- really need to look at the code to understand what's happening, what the options are
  - e.g., API, tweaks
  - e.g., replace astra with weaviate


## Comments
- easy to start - starter flows worked well (Doc QA)

- wasn't quite sure how to create an actual web UI
  - i.e., defining files to upload via API wasn't straightforward

- RAG Vector Store
  - played with trying to implement Weaviate
  - built-in component did NOT appear to work well with UI
  - i.e., queries to Weaviate store never worked out


- didn't play with deployment


