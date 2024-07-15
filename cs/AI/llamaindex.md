# llamaindex notes
- majority of notes from book "Building Data Driven Applications"
  - https://learning.oreilly.com/library/view/building-data-driven-applications/9781835089507/B21861_11.xhtml

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
    - Doc1 and Doc2 could also be sequentially linked via SummaryIndex






## Retrievers
- return a `NodeWithScore` object
  - note: all retrievers return this object, but not all retrievers associate a specific node score

- all retrievers accept a query directly or a `QueryBundle`, accept `callback_manager` argument
  - all are subclasses of `BaseRetriever`
    - all have `retrieve()` and `aretrieve()` (async retrieve)

- retrieval can be 
  - dense: uses vector embedding with semantic understanding
    - can have difficulty with long documents
    - cannot manage logical reasoning
    - depends on model quality

  - sparse
    - associates documents with keywords based on exact keyword matching or overlaps between query and document
    - typically TF-IDF (term frequency, inverse document frequency)
    - good for large datasets, high precision, simpler and more interpretable than dense methods, less resource intensive

- `SummaryIndexRetriever` for `SummaryIndex`
  - "direct construction"
    ```python
    from llama_index.core import SummaryIndex, SimpleDirectoryReader
    summary_index = SummaryIndex.from_documents(documents)
    retriever = summary_index.as_retriever( retriever_mode='embedding' )
    result = retriever.retrieve("Tell me about ancient Rome")
    ```

  - "direct instantiation"
    ```python
    from llama_index.core import SummaryIndex, SimpleDirectoryReader
    from llama_index.core.retrievers import SummaryIndexEmbeddingRetriever
    summary_index = SummaryIndex.from_documents(documents)
    retriever = SummaryIndexEmbeddingRetriever( index=summary_index )
    ```

- `VectorIndexRetriever`:  `VectorStoreIndex.as_retriever()`
  - uses similarity-based searches in vector space
- `VectorIndexAutoRetriever`
  - more advanced retriever
  - uses LLM to automatically set query parameters in a vector store based on natural language description of content and supporting metadata
  - retriever will transform vague or unclear queries into more structured queries
  - https://docs.llamaindex.ai/en/stable/examples/vector_stores/elasticsearch_auto_retriever.html

- `SummaryIndexLLMRetriever`
  - `SummaryIndex.as_retriever(retriever_mode='llm')`

- `DocumentSummaryIndexLLMRetriever`
  - `DocumentSummaryIndex.as_retriever(retriever_mode='llm')`
  - also returns relevance score associated with each node
    - note relevance scores all seemed to be returned as high
    - if nuanced distribution of scores is important, may need to adjust prompt or apply post-processing to LLM responses

- `DocumentSummaryIndexEmbeddingRetriever`
  - `DocumentSummaryIndex.as_retriever(retriever_mode='embedding')`

- `TreeSelectLeafRetriever`
  - note:  Tree indexes in llamaIndex always contain summaries about the data at each level of the tree, hence they are computationally expensive
  - `TreeIndex.as_retriever(retriever_mode='select_leaf')`
  - will recursively navigate index structure to identify most relevant leaf nodes to query
  - setting `Verbose` to `True` will display the selection process used to select child nodes
  - no relevance score is returned
- `TreeSelectLeafEmbeddingRetriever`
  - uses similarity of the embeddings between query and node text
- `TreeAllLeafRetriever`
  - essentially returns all nodes, like a bulk retrieval
- `TreeRootRetriever`
  - retrieves responses directly from root nodes
  - asumes that the index tree already stores the response
  - does not return relevance scores


- `KeywordTableGPTRetriever`
  - `KeywordTableIndex.as_retriever(retriever__mode='default')`
  - uses LLM query to identify relevant keywords, returns nodes associated with those keywords
- `KeywordTableSimpleRetriever`
  - does not use LLM - faster
  - may be less efficient at identifying complex or contextual keywords
  - uses regex
- `KeywordTableRAKERetriever`


- `KGTableRetriever`
  - the default retriever for `KnowledgeGraphIndex`
  - there are 3 retrieval modes:
    - keyword only : `KnowledgeGraphIndex.as_retriever(retriever_mode='keyword')`
      - case sensitive
      - extracts keywords from query to find relevant nodes
    - embedding only : `KnowledgeGraphIndex.as_retriever(retriever_mode='embedding')`
      - finds nodes in graph whose vector representation is similar to query embedding
    - hybrid (combo) : `KnowledgeGraphIndex.as_retriever(retriever_mode='hybrid')`

- `KnowledgeGraphRAGRetriever`
  - identifies key entries within a query and uses these to navigate the knowledge graph
  - uses `extraction entity_extract_fn` and `entity_extract_template`
  - also uses `synonym_expand_fn` and `synonym_expand_template`
  - retriever also uses `with_nl2graphquery` which converts natural language queries into graph-based query languages









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

- `QueryTransform` : can rewrite and modify a query before using it to interrogate an index
  - `IdentityQueryTransform` (does NOT transform - good for default or basic behaviour)
  - `HyDEQueryTransform` : for HyDE
  - `DecomposeQueryTransform` : transfosm to simpler and more focused subquery
  - `ImageOutputQueryTransform` : adds instructions for formatting results as images (e.g., adding <img> tags)
  - `StepDecomposeQueryTransform` : adds an additional layer by taking previous reasoning or context into account when decomposing the query

- `OpenAIQuestionGenerator` / `LLMQuestionGenerator` (uses special parser to structure output)






## Metadata filters
```python
from llama_index.core.vector_stores.types import MetadataFilter, MetadataFilters
# ...
filters = MetadataFilters(
  filters=[
    MetadataFilter(key="department", value=user_department)
  ]
)
retriever = index.as_retriever(filters=filters)
```

- note: default vector store (`VectorStoreIndex`) only supports `FilterOperator.EQ` (equal to) as metadata operator
  - need to use more sophisticated vector store (e.g., pinecone or chroma) to get additional metadata operators
    - e.g., > `GT`, < `LT`, != `NE`, >= `GTE`, <= `LTE`, in `in`, `nin` (not in)




## Selectors
- can be used for any conditional logic in an application
  - e.g., choose from a list of parsers, indexers, retrievers, tools, etc.

- commonly used for selecting retrievers
- allows the choice of retriever to be used to be based upon the query
- `LLMSingleSelector` : LLM makes decision
- `LLMMultiSelector`
- `EmbeddingSingleSelector` : decision based on similarity calculation
- `PydanticSingleSelector` : decision based on pydandic objects
- `PydanticMultiSelector`

- "SingleSelector" returns 1 selection
- "MultiSelector" returns multiple selections





## Tools
- a generic container with some functionality that an agent can use
- e.g., composing and sending emails, querying APIs, interacting with the file system, etc.

- could also encapsulate a retriever in a tool container and then use selectors to implement adaptive retrieval
  - `RetrieverTool` class
  - `RouterRetriever`



## Postprocessing
- typically for filtering, transforming, or re-ranking nodes
- after retrieval, but before prompt context injection

- `SimilarityPostprocessor` : filters out nodes below a specified similarity score
- `KeywordNodePostprocessor` : keeps only nodes with require keywords, or filters out nodes with unwanted keywords
  - e.g., could be setup to exclude confidential or restricted information
  - requires spacy library
  - note: keywords are processed in case-sensitive way
- `PrevNextNodePostprocessor` : can retrieve previous, next, or both nodes based on position relationship within a document
  - e.g., could be useful in legal context for retrieving preceding and suceeding notes which could contain related precedents or subsequent rulings
  - also `AutoPrevNextNodePostprocessor`

- `MetadataReplacementPostprocessor` : replaces content of a node with a specific field from that node's metadata
  - used in situations where full surrounding sentences may be stored in metadata during parsing and after retrieval based on a more specific sentence, a larger text chunk is submitted as context

- `SentenceEmbeddingOptimizer` : optimizes longer text passages by selecting most relevant sentences within a node based on semantic similarity

- can also filter on:
  - time (date)
  - embedding recency : also used to find similar nodes and filter them out (e.g., for a news aggregation service)
  - most recently accessed
  - 
- re-ranking
  - doesn't change or remove nodes, just re-order
  - required to overcome limitations of LLMs in handling long or complex queries

- need to measure effectiveness of LLM-based re-ranking
  - manually
  - use benchmark datasets
  - user feedback
  - A/B testing
  - domain expert evaluation

- model drift:
  - occurs when new concepts emerge that were not included in model training data, or data may shift in distribution
  - data drift : properties/distribution of input data changes over time
  - concept drift : relationships between input features and target variable evolve (i.e., model's understanding of domain becomes outdated and performance degrades)
  - upstream data changes : training data is different than production data
  - feedback loops : if outputs of model can influence future inputs, model may become biased towards its previous outputs and narrow information provided over time
  - domain shift : a model is applied to a different domain or context than originally trained for
  - temporal drift : includes both data and concept drift


## Response synthesizers
- responsible for generating a response from LLM using user query and retrieved context
- will iteratively "send" a prompt using each node of returned context
  - will "aggregate" answers depending on defined behaviour, e.g.:
  - `refine` : considers each piece of info
  - `compact` : similar as above, but concatenates responses
  - `tree_summarize` : uses recursive summarization and concatenates each node
  - `simple_summarize` : truncates nodes to fit into 1 LLM query for basic summarization
  - `accumulate` : applies query to each node and accumulates the responses
  - etc.



## Structured output
- critical in automated processes
- options:
  - `guardrails` library to check output format and re-submit to LLM
  - `LangchainOutputParser`
  - `OpenAIPydanticProgram`



## Query engine
- combines retriever, synthesizer, postprocessor into a `QueryEngine`
  - e.g., `CitationQueryEngine`, `MultiStepQueryEngine`, `SQLJoinQueryEngine`
  
- `RouterQueryEngine` : will choose the appropriate `QueryEngine` then sythesize responses
- `SubQuestionQueryEngine` : if different questions need to be sent to different document stores






## Chatbots
- *ChatOps* - the ability to integrate chat platforms with operational workflows, facilitating transparent collaboration among people, processes, tools, bots to enhance service dependability, accelerate recovery, boost productivity

- current limitations are often how the chatbot integrates with organizational knowledge bases
  - interface has recently been primarily addressed via NLP technologies

- LlamaIndex `ChatEngine` class
  - `ChatMemoryBuffer` class : specialized memory buffer stores chat history efficiently and manages token limits of LLM
  - note:  `chat_repl()` resets the conversation history during initialization
  - `ContextChatEngine` : leverages proprietary knowledge base (retriever, llm, etc.)
  - `CondensePlusContextChatEngine` : condenses chat history and leverages proprietary knowledge base




## Agents
- agents operate with a reasoning loop and has tools at its disposal
  - i.e., can do more than just answer questions, can execute tools

- tools:
  - `QueryEngineTool` : can only provide read-only access to data
  - `FunctionTool` : leverages a user-defined function as a tool
    - uses a *docstring* (`__doc__` attribute) to help agent understand the tool
    - can also use `ToolSpec`, see LlamaHub

- reasoning loops:
  - how agents make decisions: evaluate context, understand requirements, selects appropriate tool
  - implementation of reasoning loop will vary based on agent
  - e.g., `OpenAIAgent` : uses function calling API to make decisions
    - tool selection logic is "hard-coded" into the OpenAI LLM
  - e.g., `ReActAgent` : relies on chat or text completion endpoints
    - performance is heavily dependent on quality of underlying LLM
    - see paper on ReAct (uses strategic prompting for tool orchestration)

- agents that enter an infinite loop are called "rogue agents"

- agents may need `LoadAndSearchToolSpec` utility : return only needed output to LLM and not ALL returned info (e.g., from a SQL query)
- `OnDemandLoaderTool` : a wrapper for any existing data loader
  - allows agent to fetchm, index, query data on demand
- `LLMCompilerAgentPack` : allows creation of LLM Compiler Agent - can orchestrate parallel function calls
  - uses three-part system to plan, dispatch, execute tasks
  - planner creates a DAG (directed acyclic graph) : determines which tasks are sequential and which can be in parallel

### Agent protocol
- see https://agentprotocol.ai
- in LlamaIndex, uses `AgentRunner` and `AgentWorker`
  - `AgentRunner` orchestrates tasks and stores conversational memory
  - `AgentWorker` control execution of each task step without storing state themselves
  - can use `chat()` or `create_task()` (more granular control)



## Custom / Local models
- can use LMStudio (for non-commercial uses)
  - green models:  enough GPU / video memory to load / execute inference
  - blue: not deal, but okay
  - gray: may or may not work
  - red: won't be able to run

  - will create a localhost server with an "OpenAI API"



- Zephyr-7B : a compact model, manageable size, popular
  - derived from Mistral-7B
  - surpasses llama2-chat-70b on lmsys leaderboard

- quantization : reduces model parameters (typically 32-bit float) to lower-bit representations (e.g., 8-bit integers)


- LLM routers:
  - neutrino
  - OpenRouter

  - both are supported as integration packages in llamaIndex





## Eval
- key aspects:
  - retrieval quality
  - generation quality : final output correctness, coherence, adherence
  - faithfulness : output is consistent with retrieved info
  - efficiency : computational efficiency, scalability (e.g., size of dataset)
  - robustness : diverse queries, edge cases, adversarial inputs





## Prompt engineering
- in llamaindex, use the `get_prompts()` method
  - allows you to identify templates used by specific components
  ```python
  prompts = summary_index.as_query_engine().get_prompts()
  for k, p in prompts.items():
    print(f"Prompt key: {k} text {p.get_template()}")
  ```

- use `update_prompts()` to customize prompts

- advanced prompting techniques:  https://docs.llamaindex.ai/en/stable/examples/prompts/advanced_prompts.html

- will depend on model types
  - BERT:  encoder-only
  - BART: encoder-decoder
  - decoder-only:  GPT, Mistral, Claude, LLaMa
  - Mixture-of-Experts (MoE):  e.g., Mixtral 8x7B

  - model size (# of parameters), e.g., 10bn parameters are medium sized
  - chat models:  optimized for conversational interactions
  - instruct models: fine tuned to execute specific instructions or queries
  - codex models: understanding / generating code
  - summarization models
  - translation models
  - QA models



## Misc2
- llamaIndex slack data connector (ingestion):  https://docs.llamaindex.ai/en/stable/examples/data_connectors/SlackDemo/
- discord chat data ingestion: https://docs.llamaindex.ai/en/stable/examples/discover_llamaindex/document_management/Discord_Thread_Management/
- multi-tenancy example: https://docs.llamaindex.ai/en/stable/examples/multi_tenancy/multi_tenancy_rag/
- CitationQueryEngine example:  https://docs.llamaindex.ai/en/stable/examples/query_engine/citation_query_engine/

- Stanford AI ethics:  https://plato.stanford.edu/entries/ethics-ai
- Corporate controls on AI (for boards):  https://corpgov.law.harvard.edu/2023/10/07/ai-and-the-role-of-the-board-of-directors/
- IEEE:  ethically aligned design:  https://standards.ieee.org/industry-connections/ec/ead-v1/
- EU AI Act:  https://artificialintelligenceact.eu
- article on evolution of human cognition with LLMs:  https://www.psychologytoday.com/us/blog/the-digital-self/202403/llms-and-the-specter-of-the-cognitive-black-hole




