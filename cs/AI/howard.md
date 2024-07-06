# A Hacker's Guide to Language Models (Jeremy Howard youtube video)
- https://youtu.be/jkrNMKz9pWU?feature=shared


## models
- ~00:01:49 - text-davinci-003 (from OpenAI)
  - will predict the next words
  - can play with models on https://nat.dev

- ~00:04:50 - talks about tokens:  parts of words, etc.
  - library tiktoken

## ULMFiT
- ~00:06:50 - LM pre-training, LM fine-tuning, classifier fine-tuning
  - algo defined in paper written by Jeremy Howard and Seb Ruder
    - model trained on wikipedia (had to guess words and maximize rewards)
    - initial model 100M parameters, now they have billions of parameters

- ~00:11:31 - relationship between intelligence and "compression"
  - models employ "compression" - when they predict what happens next
  - talks about fine-tuning (feed documents closer to final task, still predicting)

- ~00:12:57 - nowadays, employ "instruction tuning"
  - e.g., use dataset "OpenOrca" (on HuggingFace)
    - use 4Gb of questions with answers - LLM needs to answer, and then use the responses to train it - in a way specific to answer questions that might be useful

- ~00:15:03 - RLHF (Reinforcement Learning with Human Feedback) - last stage
  - various other approaches may be used
  - can also be done with more advanced models
  - the model should spit out 2 answers and human (or more advanced model) will pick the better answer

## GPT
- ~00:16:26 - what GPT models can/can't do
  - e.g., reasoning (use CoT), prompt engineering
    - he did his own testing of problems from another paper that he WAS able to solve
  - best model is GPT-4 (as of this video Sep 2023) - $20 is enough to not run out of tokens

- ~00:21:17 - models are trained to give most likely next words, not give correct answers
  - when dataset is the internet, there is a lot of bad data, etc.
  - RLHF - people are asked which answers they LIKE more, not which is correct

- ~00:22:34 - Howard's prompt:  "You are an autoregressive language model that has been fine-tuned with ... ... tell me if there is no correct answer"
  - more computation is better - so spend a few sentences explaining background context, assumptions, and step-by-step thinking BEFORE you try to answer a question

- ~00:25:03 - things GPT's don't know / can't do
  - e.g., hallucination (a by-product of its training)
  - e.g., itself
  - e.g., URLs (not part of training dataset)
  - e.g., knowledge cutoff (Sep 2021 for GPT-4)

- ~00:26:45 - modification of wolf, goat, cabbage problem
  - model tries to answer based upon what it knows from wikipedia page (not the same problem), NOT the actual problem given
  - better to EDIT the original prompts rather than continue feeding context into the next prompt
    - i.e., NOT multistage conversation
  - once it's wrong, it tends to continuing being wrong - it's hard to make it right
    - once it's wrong, just edit the prior prompt
    - need to prime it to look for "tricks"



## advanced data analysis
- ~00:31:31 - ask GPT to write code for you
  - e.g., splitting markdown
  - ultimately, it's not a substitute for programmers
  - wasn't great at markdown
  - was better at OCR

- ~00:34:25 - OCR is better / faster with GPT models 
  - Google Bard was quite good - also provided a source reference
  - great at code that it's likely to have seen before



## Using GPT models
- ~00:38:04 - talks about pricing of gpt models (actually quite good)
- ~00:39:20 - using openAI api
  - prompts:  "system" vs "user" vs "assistant" (~00:43:52)
  - try GPT 3.5 turbo first, if the results are bad, then try GPT-4
  - usage field, mentions # of tokens used (prompt is separate from completion)
  - provides code examples to use openAI API

- ~00:46:00 - code to manage limits on token usage



## language interpreter
- ~00:46:42 - talks through how to create your own language interpreter using OpenAI API
  - using "function calling"
  - OpenAI API will return "function_call" code
  - API can be instructed to use the python interpreter to execute python code with the correct prompts and a bit of code

## running models on your own
- To run an LLM on your own computer, need a GPU
  - pricing of OpenAI is pretty good - so it may not make sense
  - Kaggle or Colab can provide GPUs
  - GPU server providers exist:  e.g., runpod, lambda labs, vast.ai
  - to buy your own GPU (24GB memory) - check which are best (he recommends)

- huggingFace
  - try different models (can check leaderboard)
    - be aware of "leakage" (leaderboard answers are used as part of training dataset)
  - for small things, should only 13B or 12B models

- fasteval
  - also has decent evals

- to run those models, use `torch`
  - from ~1:03:53 onwards - discusses code to load model, tokenize, autoregressively use model, decode tokens, etc.
  - discusses size of model, bits, etc.
  - CPTQ - model is adapated to use lower precision data
  - ~1:07:00 - discusses instruction tuning and different models
    - remember to check the prompt format for different models

## RAG
- starting from around ~1:11:00
- talks about scraping wikipedia (using python package)
- ~1:14:00 - using SentenceTransformer
- h2oGPT
- ~1:20:00 - h2oGPT page lists other private GPT options

## datasets
- ~1:23:00 - datasets, axoltl training LLM datasets
  - talks about training your owm model (need a GPU)

## running your own models
- ~1:27:00 - MLC project: running a language model on different hardware (e.g., android, iPhone, browsers, etc)

- ~1:28:00 - llama.cpp; need a GGUF file from HuggingFace

- generally need a GPU, python, pyTorch library

# Practical Deep Learning for Coders
- fast.ai course by Jeremy Howard

## Lesson 1
https://course.fast.ai/Lessons/lesson1.html
- see video above

### "normal" computer program vs ML program
- ~01:11:15 - normal program has inputs > program > results
  - ML program has inputs + weights > model > results
    - weights are also called "parameters"
    - the model is a mathematical function
    - model takes inputs, multiplies by weights adds them up - replaces negatives with 0, then goes to next layer
    - weights are very important, but weights are randomly chosen
    - once you get model results you have a "loss" result (e.g., accuracy)
      - once you have a loss, you update the weights and then run it through the model again to try and make the loss better (i.e., less)
      - if you do this enough times you can get a pretty good function
    - the neural network is a special type of function
    - once the weights are determined, they can be incorporated into the model

- ~1:17:50 - deploying models can be tricky, but it can be invoked like any function

## Lesson 2
https://course.fast.ai/Lessons/lesson2.html

### Misc
- see https://aiquizzes.com - new questions about AI
- see forums (more detailed)

### Create model first and then clean data
- see ch 2 of the book
- gather and clean data first
- train the model then clean the data
- think about different image processing (crop vs squish vs pad vs RandomResizedCrop)
  - RandomResizedCrop - you'll get different versions of the same immage in various epochs to make the picture slightly different each time
    - can also use aug_transforms
  - these are real-time transforms that are applied to the image in memory for each epoch
  - generally for 10 or more epochs, it's great to use these transforms

- confusion matrix: summarizes which classifications may have been difficult (e.g., grizzly vs black bears)
  - "plot_top_losses" : shows you incorrect answers, or un-confident answers

  - ImageClassifierCleaner : can check out the images that have been classified and clean them up

- if you build the model first, you'll see the kinds of problems you're having

- note:  GPUs don't swap - so you need to close things that are open and make sure you don't run out of GPU RAM

### Deployment
- see Tanishq Abraham's blog:  Gradio + HuggingFace Spaces: A Tutorial
- HuggingFace Spaces
  - copy the model to the server and create a UI space
  - can launch to gradio interface

- fastai learners are "pkl" files
  - can export and load those learners
- then need to create gradio inputs
- note the jupyter notebooks export default - a bit of a shortcut if you're using jupyter

- talks about local installs for jupyter, etc.
- talks about github pages
  - uses huggingface spaces to create an API endpoint for a model


## Lesson 3 (Math foundations of neural nets)
- https://course.fast.ai/Lessons/lesson3.html

- talks about another platform:  paperspaces
  - includes persistent storage

- from lesson 2:  important thing is training the model is separate from using the model
- to optimize the model, need to load a different base model (e.g., not resnet18)
  - e.g., use `convnext` architectures - a better model architecture for visual recognition
  - need to retrain that model

- fast.ai stores the various classifications in a `vocab` object
- models are object type 'learner'
  - talks about data blocks, etc.
  - can look at model with learn.model
    - contains layers, in a tree
    - contains stem, stages
    - in pyTorch, get get_submodule
    - LayerNorm2d - contains a series of numbers

- machine models fit a function to data
  - e.g., with a quadratic function (use Latex)
  - can create a partial function application using `from functools import partial`
  - then show a contrived example to create noise and plot a series of points which roughly follow the quadratic function described
  - now try to fit a quadratic function using `from ipywidgets import interact` (gives you sliders to play with parameters a, b, c - the coefficients of the quadratic function)
  - define a loss function : most common is mean square error (mse)
  - now moving each parameter we can optimize for best (i.e., least MSE) and modify each parameter sequentially
  - can optimize the parameters by calculating the derivative
  - in pytorch, everything is a tensor
    - but pytorch can calculate derivatives
    - e.g., [1.5, 1.5, 1.5] is a rank 1 tensor
    - can calculate the gradients (which indicate how much to adjust each parameter based upon the returned gradients)
    - if we iterate those steps, the loss will continue to decrease
    - it will eventually converge towards the initial parameters defined

- for ML, can't just use a quadratic function
  - instead, use a function type called a "rectified linear" (relu) function
    - y = mx + b
    - if it is smaller than 0, it will make it 0
  - parameters m and b can be modified
  - a double rectified linear is 2 ReLus added together
  - the more relus you add together you can start to match any waveform and create an accurate model
  - the computer will figure out how many relus are added and what each of the parameters need to be to fit the function

- what model to use:
  - best to start with a simpler, faster model
  - this allows you to iterate, try things out, play around
  - then start to think about tradeoffs and look at slower models and decide if the improved accuracy is worth it

- how do you know you need more data?
  - start by seeing with the data you have if it's good enough
  - you won't know until you build a model
  - just start with what you have, since you may have a good enough accuracy, or perhaps you might need more - but you won't know until you train a model

  - semi-supervised learning - can get more out of your data
  - it's easy to get inputs, but it might be hard to get more outputs (labels)
  - there are things you can do with unlabelled data

- "learning rate" - a "hyper-parameter" - the amount by which you should change the parameters as part of each iteration of loss "fitting"
  - if learning rate is too big, you'll jump too far
  - it's a tradeoff between speed and accuracy

- matrix multiplication
  - is used to combine relu functions together
  - see matrixmultiplication.xyz
  - just need to multiply numbers together and add them up
  - GPUs do matrix multiplication very quickly

- example using Excel (titanic)
  - convert various data columns to "numerical" and "binary" (for discrete numerical values) data columns
  - needed to normalize the other numerical data columns (e.g., age, fare, etc.) to make them between 0 and 1
    - for fare: used the log of the fare to make the distribution more even
    - prevents any particular column from saturating another
- calculations start around ~1:11:53

- calculating a regression:
  - start with random coefficients for each data column
  - do sumproduct for each random coefficient by each data point
  - if you add a column containing 1 at the end of your data it makes things easier, don't need to add a constant parameter
  - you can create your own loss function (difference squared)
    - used the (sumproduct - survived column)^2  (survived was 1 for survived, 0 for died)
    - then took the average loss calculated for every row of data in the dataset
    - then used the excel solver to update value of coefficients to minimize the average loss among the entire dataset
      - the coefficients (and the corresponding sumproduct) will then update
      - note that the sumproduct will sometimes be less than 0, sometimes more than 1, etc.
      - making those sumproducts between 0 and 1 is more ideal, but requires more tweaking

- need to do this a few different times to make it a neural net
  - i.e., need another set of coefficients
  - will get another set of sumproducts

  - can't just add 2 linear functions together - you just get a resulting linear function (not the desired output - need "squiggles")
  - hence, need to create relus : if sumproduct is less than 0 replace with 0
  - the prediction then is the sum of both relus (from each set of coefficients)
  - loss is the same calc (prediction - survived column)^2
  - now, with 2 layers (neural net), the mean loss is less than with just 1 regression

  - ~01:19:30 - can also calculate sumproduct using matrix multiplication

### NLP
- ~1:24:10 - starts
- NLP - for processing "prose"
  - good for classification of a document (could be a page, book, etc.)
    - sentiment analysis
    - author identification
    - legal discovery
    - organizing docs by type
    - triaging inbound emails
    - etc.
  - similar to images, but uses a different library : HuggingFace Transformers
    - doesn't have a high-level library like fastai
- works on US patent phrase to phrase matching


## Lesson 4 (NLP)
- https://course.fast.ai/Lessons/lesson4.html

- won't use fastai at all
- will use huggingface sentence transformers library
  - this has a different structure than fastai, a bit lower library

- a pre-trained model has already been fit - some parameters you know, some you aren't as sure about
- step 1: just build a language model for a wikipedia article
  - basically understand language
  - started with random weights

- step 2: used pre-trained model to train with imdb model reviews

- step 3: used step 2 model and trained it on sentiment (positive vs negative) of movie reviews

- document is an input to an NLP (could be long or short)
- pandas - a python library for tabular data
  - `import pandas as pd`

- 4 critical python libraries:
  - numpy
  - matplotlib
  - pandas
  - pytorch

- see book "Python for Data Analysis, 3rd Ed"

- `df.describe(include='object')` : summarizes number of distinct values in each column, etc.

### tokenization
- `from datasets import Dataset, DatasetDict`
- tokenization:  split each text up into words (or tokens - parts of words)
- numericalization:  convert each word (or token) into a number

- tokenizing is based on the model you choose to use
  - models are often pretrained with various types of data (e.g., model may be pre-trained on patent corpus)

  - `microsoft/deberta-v3-small` is a great general-purpose NLP model as a starting point
    - starting with 'small' is generally best, faster to train, less memory, etc.
  
  - `AutoTokenizer` - allows you to tokenize the same way the model does

- numericalization: use a function `tokz` to numericalize each token (letters, characters)
  - uses tokenizer library using Rust, etc.

- new output contains a list of numbers - just need to look up numbers to see what token it correlates to

- can choose any format to feed input:  just need some separator for different fields
- doing documents with 1000s of words, ULMFiT may be better, but transformers is best for smaller docs since it uses less GPU compute

- need to have separate training, validation, test data sets

### overtraining
- trying to fit a linear function to a polynomial function will create "underfit"
  - if the model is too simple, you'll be systematically wrong
- overfit is when you use a polynomial function which is too high of an order

- if you remove some of the dataset (e.g., 20%) then you can see how the fit to the remaining data is
  - this is the validation set
  - understanding the right way to remove data for validation is critical
  - e.g., can't remove from the middle, may need to remove cycles at the end (which may need to be used to see if prediction is possible)
  - see https://fast.ai/2017/11/13/validation-sets
  - validation sets shouldn't necessarily be randomized

- test set:
  - another validation set, but is used to confirm if your model is fit properly

- with validation set, measure metrics
  - kaggle competition will define the desired metrics
  - avg mean absolute error is better.  accuracy may be a tough metric since it's "bumpy"

  - see https://fast.ai/2019/09/24/metrics
  - choosing metrics can be hard
  - need to be careful what metrics you pick

- talks about correlation coefficients
- best to plot data to see what it looks like
  - look for truncation of data, etc.
  - correlation relies on square of difference - so you'll get large outliers
  - be careful with outliers

- when looking at metrics, always plot the data
- just try a few learning rates to see which is better
  - start low, then keep doubling the learning rate and see what comes out

- using a pre-trained model makes it much faster - doesn't require much fine-tuning (the training) that occurs in the example

- re outliers:
  - outliers should never just be removed - they need to be treated differently, different kind of analysis
  - most useful insights is digging into outliers - you discover things like processes, etc. that may go wrong
    - never delete outliers without investigating and understanding them

- need to fix predictions - shouldn't be less than 0 or bigger than 1

- NLP is a very recent area in the past few years (as of the video)



## Lesson 5 (neural networks)
- https://course.fast.ai/Lessons/lesson5.html

- building a tabular model from scratch (without using excel)
- "imputing" missing values
  - easiest is using "mode" of that column for missing values
  - can use some built-in functions in pandas

- missing values don't make much difference
  - so the first time around, can do it the easiest way possible

- generally - wouldn't throw away data - they may be good predictors
  - could create another column which indicates if there is a value in a particular column (especially if the value is frequently missed)

- can use histograms to show how frequently values appear
- for long-tailed distributions (i.e., lots of small values) can use the log of those values
  - log histogram of "fares" will be much better

- ~19:32 - dummy variables
  - necessary for data which isn't inherently numeric (e.g., "embarked", "sex")

- pytorch does everything numpy can do, but allows use of GPU
  - hence, could just use pytorch
  - number type needs to be floats for pytorch

- tables are rank 2 tensors
  - scalars are rank 0
  - rank is the length of the shape

- need to set a seed to initially generate random coefficients
- multiplying a matrix by a product ( `t_indep*coeffs`) - this is actually element-wise multiplication
  - this is "broadcasting" and is done on the GPU - is done very quickly
  - it was acutally written in C - this is fast, even tho Python is slow
  - google "numpy broadcasting rules"

- since age is very large relative to the other variables
  - to optimize, change age to a percentage of max age
  - could also subtract mean and divide by standard deviation

- for titanic data, using random split is fine
  - can use `from fastai.data.transforms import RandomSplitter`

### sigmoid
- ~48:32 - using sigmoid
- sigmoid:  as numbers get larger they asymptote to 1, or smaller than 0 they asymptote to 0
  - use `import sympy`
  - can put `indeps*coeffs` through sigmoid
  - using sigmoid - it allowed increase of the learning rate, improved accuracy


~58:33 - matrix multiply  in python, `@` is the operator for matrix multiply (since `*` is for element-wise multiply)
~1:09:36 - deep learning
  - the last layer runs through sigmoid
  - go through all layers and all constants
  - creates about the same loss / accuracy

- note that neural net and deep learning didn't create a better outcome with the titanic dataset
  - generally, tabular data requires thinking to make it work well

~1:15:47 - using a framework
  - although you can build things on your own
  - but it's often best to use a framework so you don't need to build it all from scratch
  - pandas can do a lot of "feature engineering"
    - it's worth looking at the sample code from jupyter notebook to see what can be done

~1:23:30 - ensembling
  - ensembling is creating multiple models and combine them to create a single prediction
  - using mode may be better than mean - but not sure why
    - may be best to just try it


~1:27:02 - random forests
  - can be very elegant, hard to mess up
  - logistic regression - is very hard, outliers, etc.
  - random forests: it's rare to mess this up in industry

  - a random forest is an ensemble of trees
    - a tree is an ensemble of binary splits

  - a binary split - something that splits the rows into 2 groups
    - e.g., titanic data set - male vs female
      - the survival rate is very different among males vs females

  - a 1-R model (a simple binary split)
    - in a review in the 90s, ended up being of the best (if not the best) models for classifying real world data sets



