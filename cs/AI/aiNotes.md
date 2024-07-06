# Notes from Microsot "Gnerative AI for Beginners" course
- https://github.com/microsoft/generative-ai-for-beginners/tree/main?tab=readme-ov-file

## Lesson 1: Intro to GenAI
- the main capability of LLMs is generating a text from scratch, starting from a textual input, written in natural language
- input = "prompt"
- output = "completion"

- LLMs predict output probabalistically
  - however, some randomness is added (temperature) : "non-deterministic"
  - for the same input, you don't get the same output

- prompts can include:
  - instructions (e.g., please summarize, create, write, etc.)
  - questions
  - a chunk of text to complete
  - a chunk of code and an ask to explain, document, generate more code, etc.

## Lesson 2: Exploring and comparing different LLMs
- types of models:
  - audio and speech recognition:  e.g., Whisper-type models (OpenAI)
  - image generation:  e.g., DALL-E, Midjourney
  - text generation: e.g., GPT-3.5, GPT-4
  - multi-modality:  e.g., GPT-4o

- foundation models vs LLMs
  - foundation models are AI models that:
    - are trained using unsupervised or self-supervised learning (unlabeled multi-modal data, do not require human annotation or labeling of data for training)
    - based on vey deep neural networks trained on billions of parameters
    - intended to serve as a foundation for other models (e.g., used as starting point for fine-tuning)

- LLMs are a subset of foundation models (FM)

- open source vs proprietary
  - open source is available for public, can be used by anyone
    - these may not be optimized for production use
    - may not be as performant as proprietary models
    - e.g., Alpaca, Bloom, LLaMA
  - proprietary is owned by a company, not madse available to public
    - these are often optimized for production use
    - not allowed to be inspected, modified, or customized for different use cases
    - may require a subscription or payment to use
    - users have no control over the data used to train the model
    - e.g., OpenAI, Google Bard, Claude 2, etc.

- embedding vs image generation vs text and code generation
  - embeddings:  models that convert text into a numerical form called embedding (a numerical representation of the input text)
    - these may be consumed as inputs by other models, such as classification models or clustering models that perform nbetter on numerical data
    - used for transfer learning:  where a model is built for a surrogate task which has an abundance of data, and the model weights (embedding) are re-sed for other downstream tasks

  - image generation: models often used for image editing, image synthesis, image translation
    - may be trained on large image datasets (e.g., LAION-5B)

  - text and code generation models:  generate text or code
    - often used for text summarization, translation, question answering
    - may be trained on datasets like BookCorpus
    - e.g., CodeParrot


- encoder-decoder vs decoder-only
  - decoder-only : similar to content creater only model (e.g., GPT-3)
  - encoder-only : good at seeing relationships betwen text and understanding context (e.g., BERT)
  - encoder-decoder:  good at both encoding and decoding (e.g., BART, T5)


- service vs model
  - a product offered by a provider:  typically a combo of models, data, other components
  - model:  a core component of a service, often a foundation model (e.g., LLM)

- improving model performance (increasing difficulty and cost):
  - prompt engineering with context
  - RAG : storing your data in a db or web endpoint to make it (or a subset) available at the time of prompting to incorporate into the user's prompt
  - fine-tuned model : further training of a model on your own data; can be costly

- prompt engineering with context
  - "zero-shot" learning:  a short prompt like a sentence to complete or a question

## Lesson 4: Prompt Engineering Fundamentals
- Basic Prompt (input) > Completion (output)
- zero-shot learning:  prompt does not provide examples (prompt describes output)
- one-shot learning: prompt includes 1 example (LLM infers desired output)
- few-shot learning:  prompt includes a few examples (LLM infers output)

- prompt cues:
  - provide a start for the LLM to complete
  - distinct from examples

- prompt templates:
  - a pre-defined recipe for a prompt that can be stored and reused as needed 

- prompt structure
  - instruction:  what to do
  - primary content:  provide a few examples of desired output
  - secondary content: additional context to influence output in some way]

- recommendations:
  - separate isntructions and context
  - start with zero-shot, then try few-shot
  - be descriptive, specific, clear
  - instructions may need to be repeated - experiment
  - order matters - try different options
  - provide "fallback" completion responses if a task cannot be completed

## Lesson 5: Advanced Prompting
- additional techniques:
  - chain-of-thought:
    - give the LLM a similar example
    - show the calculation and how to calculate it correctly
    - provide the original prompt

  - generated knowledge:
    - incorporate domain-specific knowledge into the prompt (e.g., cost of insurance packages)
    - use the "restrict" keyword as part of the prompt to limit potential responses

  - least to most:
    - break a bigger problem down into subproblems
    - guide the LLM on how to "conquer" the bigger problem
  
  - self-refine
    - ask the LLM to critique itself

    - initial prompt asking the LLM to solve a problem
    - after the LLM answers, you critique the answer and ask the LLM to improve
    - LLM answers again

  - maieutic prompting
    - asking the LLM to explain itself with the goal of reducing inconsistencies in the output to arrive at a correct answer

    - ask the LLM to answer a question
    - for each part fo the answer, ask the LLM to explain it in more detail
    - if there are inconsistencies, discard the parts that are inconsistent

- common LLM parameters (which affect output)
  - temperature:  from 0 (least varied) - 1 (most varied)
  - top-k
  - top-p
  - repetition penalty
  - length penalty
  - diversity penalty


## Lesson 9: Building image applications
- meta prompts:  text prompts used to control the output of a generative AI model
  - text positioned before the text prompt
  - typically embedded in the application to control the output of the model



