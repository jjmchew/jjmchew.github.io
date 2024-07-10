# Agenta notes

- only about 1000 stars on github
- product not on g2.com
- mentioned in a reddit post
- from Crunchbase:
  - based in Germany
  - raised a pre-seed round (100k EURO) in Jun 2023
  - raised a seed round (1mm EURO) in Jun 2024

- deploys apps to their AWS instances
- creates an API to "book-end" app inputs and outputs
- overall - probably immature and not worth using currently


# Experiments

Agenta API key:  WEkxOmZ8.f5d4ce5eff6b41c5ad23c8ecc77d26fbfe82a16ccfe09fb53ccb90fc5e43dc25

## Initial test with Haystack app
- Created mini RAG using Haystack
- installed agenta according to docs, wrapped the app

- app was deployed to AWS:  https://yrnmjuq2hgkzqdsfhzoqjwz43u0gooyl.lambda-url.eu-central-1.on.aws/
- API documentation available here:  https://yrnmjuq2hgkzqdsfhzoqjwz43u0gooyl.lambda-url.eu-central-1.on.aws/docs
- playground available here:  https://cloud.agenta.ai/apps/01909d2c-0495-7cf0-892b-31263aa1c7e7/playground

- this initial deployment to agenta cloud didn't work
  - possible issues:  didn't return a JSON?


## Subsequent test with agenta_AI simple_prompt app
API url: https://zh44ckp4s4r36afia26l346xca0nwtth.lambda-url.eu-central-1.on.aws/
  - this app returns {"detail":"Not Found"} in a browser

API docs: https://zh44ckp4s4r36afia26l346xca0nwtth.lambda-url.eu-central-1.on.aws/docs
  - this one returns FastAPI standard default docs (/openapi.json)

Playground link: https://cloud.agenta.ai/apps/01909d2c-0495-7cf0-892b-31263aa1c7e7/playground
  - loads agenta cloud
  - gives the same error in agenta (Network Error) : appears to be related to haystack packages
  - will try serving again with different requirements.txt
  - this seemed to work - basic app loads


## Comments
- basic built-in app functionality is limited - no RAG, just simple chat
- never managed to get a more complicated RAG setup (using Haystack) to work
- UI seems a bit clunky - a few things that felt "janky" - clicking on specific areas, tabular displays, a bit hard to navigate

- evaluators never seemed to work well for me - couldn't use an existing dataset column as input for a regex to test the output in another language

- overall: interesting to see the options, but it didn't work very well
