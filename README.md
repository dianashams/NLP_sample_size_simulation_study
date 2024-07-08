# Sample size for clinical text clasification

## The project is funded by the King's College London

### Collaborators: 
Diana Shamsutdinova, Jaya Chaturvedi, Saniya Desphande, Chankai Ma, Robert Cobb, Angus Roberts, Daniel Stahl (King's College London)

### Background: 

Classification tasks using natural language processing models (NLP) are often used in clinical research to automate identification of specific information in electronic health records. Such information can be a specific diagnosis (e.g., diabetes, or depression), a symptom (e.g. feeling of pain), or a treatment (e.g. therapy, prescription). This study aims to test sample size requirements for classification models of clinical texts, and how such requirements depend on the language properties of the underlying documents. The practical question we address in this project is whether the 200-500 documents that are usually get annotated in clinical research studies are enough? 

The pilot study was completed by a 2022/2023 MSc student Saniya Deshpande under Daniel Stahl and Diana Shamsutdinova's supervision. It was found that properties such as vocabulary size, word frequencies in different classes of documents, and outcome prevalence, have a significant impact on the optimal size of the training corpus. However, this work was mainly based on classical statistical methods. 

Here, in collaboration with  Chnkai Ma, Robert Cobb, and Jaya Chaturvedi,  we aim to investigate similar questions with the state-of-the-art NLP deep learning models, such as pre-trained large language models (LLM) BERT (subtypes – BERT_base, SAPBERT, Bio-Clinical BERT), LLAMA 2, and Gatortron.

Methods: We utilized a publicly available dataset MIMIC-III. Our annotated corpus of the documents contained MIMIC-III's hospital discharge notes and corresponding ICD-10 diagnoses. We then trained classification models to identify one of the chosen diagnoses. We varied the size of the training corpus to investigate the learning curves of the classification models. Further, we tested whether the learning curves depend on the vocabulary properties of the underlying clinical texts. 

### Results: 
First, we have found that learning curves of the classification models of different diagnoses varied significantly, despite them using the same underlying preprocessing methods and models. However, further analyses of the text vocabularies were inconclusive, in which variability of the vocabulary complexity did not explain the differences in the learning speeds. 
Secondly, most models reached their performance at sample sizes of 2000-5000, and therefore, existing practice of annotating as little as few hundreds seems suboptimal, though we acknowledge that this should be weighed against the time cost of people annotating them. 

### Limitations and further steps: 
The analysis of the text properties that may underly the differences in the learning curves of the classification NLP models is ongoing, including key words frequencies and distances in the LLMs' document  representations.
We have not explored the modern generative methods that can help increase training data, which is out of scope in the present project.

### Code 
The code is available from this repository
