# llamaindex notes

- created in 2022 by Princeton graduate Jerry Liu
- LlamaIndex (LI) guides the responses based on real data rather than just making up vague answers
- LI reveals complexity "progressively"
  - looks simple to start, but allows deeper tweaking if required

## Classes
- `Document`
  - `id_` : will be auto-generated if not indicated
  - `text` : can be a string, tuple(?)
  - `metadata = {}`

- Nodes
  - `TextNode`
    - `text`
    - `doc_id`
    - `metadata`
    - `relationships`: `NodeRelationship` (`NEXT`, `PREVIOUS`, `SOURCE`, `PARENT`, `CHILD`)

## Logging
```python
import loggin
logging.basicConfig(level=logginng.DEBUG)
```


## Readers
- `SimpleWebPageReader`
  - `pipenv install llama-index-readers-web`
  - `from llama_index.readers.web import SimpleWebPageReader`
- `DatabaseReader`
  - `pipenv install llama-index-readers-database`
  - `from llama_index.readers.database import DatabaseReader`

- `SimpleDirectoryReader` : automatically adapts to different file types
  ```python
  from llama_index.core import SimpleDirectoryReader
  reader = SimpleDirectoryReader(
    input_dir="files",
    recursive=True
  )

  documents=reader.load_data()
  for doc in documents:
    print(doc.metadata)
  ```

## Parse
- `from llama_parse import LlamaParse` : paid service with free tier - hosted and provides advanced parsing capabilities for documents
- `NodeParser` (a generic class for parsers)
  - `include_metadata`: bool
  - `Include_prev_next_rel`: bool
  - `Callback_manager` : to define a callback function for debugging, tracing, cost analysis, etc.
- `SentenceWinodwNodeParser`
- `LangchainNodeParser` : allows you to use LangChain parsers (`langchain` library must be installed)
- `SimpleFileNodeParser` : will scan by file types
- `HTMLNodeParser` : uses Beautiful Soup to parse HTML files
- `MarkdownNodeParser` : generates nodes based on structure and content of markdown
- `JSONNodeParser`
- `HierarchicalNodeParser` : uses `SentenceSplitter` to chunk text by default
  - e.g., `chunk_sizes=[128, 64, 32], chunk_overlap=0`
- `UnstructuredElementNodeParser` : used for docs with a mix of text and data tables
  - leverages `Unstructured` library
  - creates text nodes and table nodes
    - table nodes can be loaded into pandas DataFrame or structure DBs for SQL


## Splitters
- `FlatReader`
  ```python
  from llama_index.core.node_parser import <Splitter_Module>
  from llama_index.readers.file import FlatReader
  from pathlib import Path
  reader = FlatReader()
  document = reader.load_path(Path(<file_name>))

  for node in nodes:
    print(f"{node.metadata} {node.text}")
  ```

- `SentenceSplitter`: provides nodes containing groups of sentences
- `TokenTextSplitter` : respects sentence boundaries at the token level
  - `chunk_size` : int
  - `chunk_overlap` : int
  - `separator` : str
  - `backup_separators` : list(str)
- `CodeSplitter`
  - requires `tree_sitter` and `tree_sitter_languages` (use `pipenv install`)


## Extractors
- used to extract metadata which parsing / splitting
  - remember, an LLM is used to extract metadata - could result in privacy / regulatory / security / legal issues

- `SummaryExtractor`: will use LLM to create a summary for each node or adjacent node
- `QuestionsAnsweredExtractor` : generates a specified number of questions the node text can answer
  - can set `prompt_template` and `embedding_only` (bool)
- `TitleExtractor`
- `EntityExtractor` : used for NamedEntityRecognition (NER) (based on NLTK)
- `KeywordExtractor`
- `PydanticProgramExtractor`
- `MarvinMetadataExtractor` : based on the Marvin AI Eng Framework (https:/www.askmarvin.ai)
  - good for business logic transformations

- can hide metadata when submitted to LLM using
  - e.g., `document.excluded_llm_metadata_keys = ["file_name"]` : hides metadata "file_name"
  - enum: `MetadataMode` : can be `ALL`, `LLM`, `EMBED`



## Indexing
- note: indexing requires LLm calls - can incur cost and raise privacy issues

- `VectorStoreIndex` : most commonly utilized index
  - stores embeddings for input text chunks within the Vector Store of index
  - allows for similarity searches (cosine similarity)
  - by default, LlamaIndex uses OpenAI `text-embedding-ada-002` for embeddings
    - good local model to reduce costs is `huggingface.co/BAAI/bge-small-en-v1.5`
    - `Universal AnglE Embedding` model (`huggingface.co/WhereIsAI/UAE-Large-V1`) is one of the best-performing models at the moment (~May 2024)
    - MTEB is a text embedding benchmark on HF
    - for latency, check: https://blog.getzep.com/text-embedding-latency-a-semi-scientific-look/
    - complete list:  https://docs.llamaindex.ai/en/stable/module_guides/models/embeddings.html#list-of-supported-embeddings

- use `.persist()` method to write indexes to disk
  ```python
  # create index
  from llama_index.core import VectorStoreIndex, SimpleDirectoryReader
  documents = SimpleDirectoryReader("data").load_data()
  index = VectorStoreIndex.from_documents(documents)

  # persist
  index.storage_context.persist(persist_dir="index_cache")
  print("Index persisted to disk.")

  # load from storage
  from llama_index.core import StorageContext, load_index_from_storage
  storage_context = StorageContext.from_defaults(
      persist_dir="index_cache")
  index = load_index_from_storage(storage_context)
  print("Index loaded successfully!")
  ```

- `StorageContext` : used for configurable storage components
  - `docstore`
  - `index_store`
  - `vector_stores`
  - `graph_store`

- "vector store":  a storage system or repo where vectors are stored
  - focuses primarily on efficient storage and retrieval of vectors for various tasks
  - may not have advanced capability for querying or analyzing data
- "vector database": a more sophisticated system that stores and provides advanced functionality for querying and analyzing vectors
  - will be better for quickly searching through large volumes of vectorized data quickly and accurately

- `SummaryIndex` : simple index, nodes in sequential list
  - best for simplicity and speed (linear scan through docs, no complex embedding retrieval req'd), e.g., project document repository
  - used with `SummaryIndexRetriever`, `SummaryIndexEmbeddingRetriever`, `SummaryIndexLLMRetriever`
    - while scanning, a preliminary answer is created based on the first chunk
    - answer is refined based upon subsequent chunks

- `DocumentSummaryIndex` : optimizes retrieval by summarizing docs and mapping summaries to coresponding Nodes within index
  - useful when overviews can significantly reduce search space (i.e., large / diverse datasets)

- `KeywordTableIndex` : extracts keywords from docs and constructs keyword-to-node mapping
  - useful when precise keyword matching is required (e.g., glossary)
  - keywords may be single words or short phrases
  - LLM with specially designed prompt determines keywords
  - retrieval could use 'RAKE' (advanced method) or LLM-based keyword extraction and matching
  - also a "create and refine" approach

- `SimpleKeywordTableIndex` : doesn't use LLM (uses regex extractor)
- `RAKEKeywordTableIndex` : uses rake_nltk python package

- `TreeIndex` : hierarchical tree format
  - each parent summarizes child nodes using a general summarization prompt
  - LLM is used with `summary_prompt` to generate nodes
  - uses recursive building process
  - requires more computation to create, maintain, and query (traverse) a `TreeIndex`
    - has summarization overhead
    - requires additional storage
    - requires regular updates and re-organization as data is modified
      - summaries must be updated, etc.
  - overhead is justified for large-scale dataset which requires efficient context-aware retrieval
    - searching can be faster which improves generation and overall user response time


- `KnowledgeGraphIndex` : extracts triplets (subject-predicate-object) to create a knowledge graph
  - can use custom extraction functions
  - ideal for complex, interlinked relationships where contextual info is important
    - captures connections b/w entities and concepts
    - good for multifaceted questions
    - e.g., news aggregation, tutor app
  - uses `KGTableRetriever` or `KnowledgeGraphRAGRetriever`

- `ComposableGraph` : allows stacking of indexes
  - e.g., doc 1 could have a TreeIndex, doc2 could have a TreeIndex
    - Doc1 and Doc2 could also be sequentially linked

## Misc
- `from llama_index.core.llms.mock import MockLLM` : can be used to estimate cost and not submit to LLM API
  - will provide a worst-case scenario, actual cost will depend on response size
  ```python
  from llama_index.core import Settings
  from llama_index.core.callbacks import (
    CallbackManager,
    TokenCountingHandler
  )

  llm = MockLLM(max_tokens=256)
  Settings.llm = llm
  counter = TokenCountingHandler(verbose=False)
  # ...
  print(f"prompt tokens {counter.prompt_llm_token_count}, completion tokens {counter.completion_llm_token_count}, total token count {counter.total_llm_token_count})
  ```

- node post-processors can help solve data privacy issues - scrub data before extracting metadata using LLM
  - `PIINodePostprocessor` (works with local LLM) or `NERPIINodePostprocessor` (use with specialized NER model)

- ingestion pipelines
  - are cached - so if 1 part of the pipeline changes, cached data can be used for all parts prior to the change
  - use `CustomTransformation`
