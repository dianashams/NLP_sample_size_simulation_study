# Determinants of the training corpus size for clinical text classification.

### Collaborators: 
Diana Shamsutdinova<sup>1</sup>, Jaya Chaturvedi<sup>1</sup>, Saniya Desphande<sup>1</sup>, Chankai Ma<sup>3</sup>, Robert Cobb<sup>3</sup>, Angus Roberts<sup>1</sup>, Daniel Stahl<sup>1</sup> 

<sup>1</sup>Department of Biostatistics and Health Informatics, IoPPN; 

<sup>2</sup>Department of Informatics, King's College London; 

<sup>3</sup>Department of Biomedical Engineering, King's College London

### Funding 
The project is funded by the ECR Seed Funding Scheme, King's College London, London, and by the NIHR Maudsley Biomedical Research Centre at South London and Maudsley NHS Foundation Trust and King’s College London, UK. The views expressed are those of the author(s) and not necessarily those of the NIHR or the Department of Health and Social Care.

### Background: 

Classification tasks using natural language processing models (NLP) are often used in clinical research to automate identification of specific information in electronic health records. Such information can be a specific diagnosis (e.g., diabetes, or depression), a symptom (e.g. feeling of pain), or a treatment (e.g. therapy, prescription). This study aims to test sample size requirements for classification models of clinical texts, and how such requirements depend on the language properties of the underlying documents. The practical question we address in this project is whether the 200-500 documents that are usually get annotated in clinical research studies are enough? 

The pilot study was completed by a 2022/2023 MSc student Saniya Deshpande under Daniel Stahl and Diana Shamsutdinova's supervision. It was found that properties such as vocabulary size, word frequencies in different classes of documents, and outcome prevalence, have a significant impact on the optimal size of the training corpus. However, this work was mainly based on classical statistical methods. 

Here, in collaboration with  Chnkai Ma, Robert Cobb, and Jaya Chaturvedi,  we aim to investigate similar questions with the state-of-the-art NLP deep learning models, such as pre-trained large language models (LLM) BERT (subtypes – BERT_base, SAPBERT, Bio-Clinical BERT), LLAMA 2, and Gatortron.

Methods: We utilized a publicly available dataset MIMIC-III. Our annotated corpus of the documents contained MIMIC-III's hospital discharge notes and corresponding ICD-10 diagnoses. We then trained classification models to identify one of the chosen diagnoses. We varied the size of the training corpus to investigate the learning curves of the classification models. Further, we tested whether the learning curves depend on the vocabulary properties of the underlying clinical texts. 

### Results: 
* First, we have found that learning curves of the classification models of different diagnoses varied significantly, despite them using the same underlying preprocessing methods and models. However, further analyses of the text vocabularies were inconclusive, in which variability of the vocabulary complexity did not explain the differences in the learning speeds.

* Half of the modelled outcomes did not reach accuracy of 0.70 or above even with the 10,800 documents (the maximum training size in the experiments).

![image](Sample_size_fig1.jpg)

* The models reached their performance at the sample sizes above 1000-5000, and therefore, existing practice of annotating as little as few hundreds can be suboptimal.

* *n = 600 would be enough to achieve 95% of the performance that would have been possible with the training size of 10,000* for 10 out of 11 modelled diagnoses.

![image](Sample_size_fig2.jpg)

### Insights and Implications:

![image]

## Observations

* The 'original' dataset exhibited an unusually steep learning curve compared to other samples, marking it as an outlier.

* Texts with less noise in the data consistently demonstrated a strong predictors.

* Few regression analyses were conducted to predict the maximum AUC (Area Under the Curve) or AUC_max out of auc_300 and the number of the strong and noise predictors (high and near 0 coefficients) based on all datasets. These models were run both including and excluding the original outlier dataset.

* A clear pattern emerged between predictor quality and potential AUC: More strong predictors and fewer noisy predictors were associated with higher AUC-max. Conversely, more noise and fewer strong predictors were associated with lower AUC-max.

* Quantitative Guidelines: Based on the analysis excluding the 'original' dataset, an increase of 100 noisy words corresponds to a decrease of approximately 0.02 in AUC-max. In addition, an increase of 100 strong predictors corresponds to an increase of approximately 0.04 in AUC-max.

## Potential Implications

* A simple analysis of key words in a dataset can serve as an indicator of the learning curve's steepness. This insight can be valuable for estimating the potential performance of NLP models before extensive training.

* Data cleaning techniques focused on identifying and isolating relevant parts of larger documents can significantly impact model performance. 

* Understanding the relationship between strong predictors, noisy data, and AUC can guide decisions on optimal sample sizes for training data in NLP tasks, potentially saving computational resources and time.

* The quantitative guidelines provided can be used to estimate potential improvements in model performance based on data cleaning efforts or the acquisition of additional data.


### Limitations and further steps: 
The analysis of the text properties that may underly the differences in the learning curves of the classification NLP models is ongoing, including key words frequencies and distances in the LLMs' document  representations.
We have not explored the modern generative methods that can help increase training data, which is out of scope in the present project.
 
### Code 
The code is available from this repository

### Other related works and resources by the collabolators:

Preprint: [Sample Size in Natural Language Processing within Healthcare Research](https://arxiv.org/abs/2309.02237).

![image](Fig4.png)

[A useful tool for comparison of different models for a given sample size and class proportion](https://jayachaturvedi-sample-size-in-healthcare-nlp-dashboard-poic0t.streamlit.app/)


