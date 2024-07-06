# RAG notes

## https://cameronrwolfe.substack.com/p/a-practitioners-guide-to-retrieval
- ways ML models learn:
  - SGD:  Stochastic Gradient Descent (e.g., calculating gradient and minimizing result of loss function)
  - this phase is called unsupervised pre-training

- "in context learning":  
- https://x.com/cwolferesearch/status/1753458022251180439?s=20

- chunking data:  
  - need to clean and extract text data first
  - typically chunking is done to around 100-500 tokens per chunk

- see vector search:  https://cameronrwolfe.substack.com/p/the-basics-of-ai-powered-vector-search
  - talks in great detail about BERTs and various sentence transformers relative to lexical search (BM25)




## https://www.youtube.com/watch?v=nc0BupOkrhI
- you can retrieve example prompts, etc.  not just info content
- "grounded" response - not hallucination
- Retrieval and search has been around for a long time
  - it's much more than just encoding text as vectors
- evaluating retreival systems is key
  - could use a human evaluator
  - could have binary or graded judgements
  - see *~8:38* for common IR (info retrieval) datasets and ranking metrics
  - you need to build your own relevance dataset
    - can use a csv file
    - can use an LLM to help create that dataset
    - best to have a static collection (i.e., documents)
      - changing data will throw off the results / ranking, etc.
  - see paper "Large Language Models can Accurately Predict Searcher Preferences"

- ~27:44 - need to chunk
  - representations > 256 tokens are bad for high precision search
  - longer sequences haven't typically been used in training, thus models are less likely to respond well - "drift in topics"
  - vespa.ai can chunk text in multiple rows in db, but not replicate metadata
  - see GBDT (google search)
    - consider broader considerations than just text similarity (e.g., pagerank, company, etc.)

- metadata:
  - authority sources
  - title
  - date, etc.

- calibration / combination of indices
  - all have different distributions, etc. - hence hard to combine
  - need to have training data
  - could do hyperparameter sweep if you don't have data (check for improving loss)
  - hard to just give hard cutoffs, etc. for hyperparameters

- re-rankers?
  - offer a token-level interaction (not just vector similarity)
  - can add costs and latency as a result

- if you have interaction data
  - first need to convert interaction to a labeled dataset

- Jason Liu (sp?) the value of generating structured summaries and reports for decision-makers

- classical results and re-ranking can still get you very far
- query expansions can be quite effective

- it's hard to know when to discard embedding results
  - vector similarity search will always return the "top" results, even if they're not very good

- colBERT - another neural method
  - learn token level embeddings - still suffers from vocabularly issues (i.e., vocab not present when model was trained will confuse vector rankings)





## A Practical Approach to RAG systems:  https://mallahyari.github.io/rag-ebook/intro.html
- prompt engineering:  creating prompts discrete (manually designed) or continuous (added to input embeddings) to convey task-specific info
- answer engineering: after reformulating the task, the generated answer must be mapped to the correct answer space

