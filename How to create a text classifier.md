# What you can find here?

We wrote a documentation about create, train and use a machine learning model that can distinguish a fake news from a real one
* [**Intro**](README.md) Let's talk about what Machine Learning and Natural Language processing techiques are about
* [**How to create a text classifier**]((How&#32;to&#32;create&#32;a&#32;text&#32;classifier.md)) **Learn how to teach your machine to distinguish a fake news from a real one**
* [**How to use a text classifier**](How&#32;to&#32;use&#32;a&#32;text&#32;classifier.md) Build your own truth machine app

# How to create and train a text classifier with CreateML

## Creation of the Model

To create a CreateML model you can use the CreateML software that comes preinstalled on every mac. 

1. You will be greeted with a Finder window, to select an existing CreateML project. To create a new one select “New Document” in the left bottom corner.
2. Now you can select the type of model you want to create. To create a text classifier select “Text Classifier” and click next.
3. Now you can enter the name of the project and some other project metadata. After you are finished click Next.
4. Now you will see a Finder window where you select the location to save the project. Click Create to create the project at the specified location.
5. Now you will see the CreateML Dashboard, where you can train your model.
![Create ML Dashboard](/images/createML_dashboard.png)
6. To train your model you will have to provide data, so you should have a dataset ready. You can select the data you want to train your model on in the “Data Input” section in the dashboard.
CreateML uses the folder structure of your dataset to label data. Below you see the folder structure we used for our project. 
![Example dataset structure](/images/strutturaFile.png)
In the “Data Input” section select the “choose” dropdown for the training data and select your training data folder. In our folder structure this would be the folder located at “/Example Fake News    dataset/Train data”.
CreateML will detect the data labels using the two subfolders “Fake news data” and “Real news data”. All data that is in the subfolder “Fake news data”, will be labeled as fake and the data in the “Real news data” will be labeled as real. In the picture below you can see that CreateML detects two Input Classes, which corresponds to real and fake news.
![Input classes](/images/inputClasses.png)
7. For the “Validation Data” you can leave the dropdown on “Automatic”. With this setting CreateML will take a subset of the training data to validate the model.
8. For the “Testing Data” click the dropdown and select the training data. In our folder structure this would be the folder located at “/Example Fake News dataset/Test data”. The subfolders should be named the same as the for the training data folder, so the labels will be automatically detected.
9. Select “Transfer learning” as algorithm and click the button “Train” in the left half of the navigation bar to start training the model. 
Depending on the dataset size this might take some hours or days.

## Algorithms

When using CreateML for training a text classifier, you can choose between different types of algorithms for training it. Each one has its own features and drawbacks. The [MLTextClassifier](https://developer.apple.com/documentation/createml/mltextclassifier/modelalgorithmtype).[ModelAlgorithmType](https://developer.apple.com/documentation/createml/mltextclassifier/modelalgorithmtype) enumeration contains your possible choices.

### Maximum entropy
This type of algorithm is also known as [multinomial logistic regression](https://en.wikipedia.org/wiki/Multinomial_logistic_regression). The idea behind it,  is the [linear predictor function](https://en.wikipedia.org/wiki/Linear_predictor_function). Simplifying it a bit, but not moving too far from reality, we can say that this algorithm tries to find the right inclination of a straight line, to make that straight line as much as possible near to a set of points in a Cartesian plane.
![Piano Cartesiano - Regressione lineare](/images/Linear_regression.png) 

>[Image from Wikimedia](https://commons.wikimedia.org/wiki/File:Linear_regression.svg)


Sadly in real life is more complicated than this because a lot of times our problem has more than two dimensions, and cannot be described with a straight line.
As the documentation states, choosing this algorithm among the others will give you a shorter training time, but probably the trained model performances won’t be always good enough.

### Conditional random field

This type of algorithm leverages the sequence structure of data. It has a lot of applications, indeed it is used in natural language processing for solving the name entity recognition (NER) problem. What a conditional random field algorithm does, is keeping track of patterns in sequences that lead to an entity during the training phase, and then tries to search these patterns to predict the presence of that kind of entity. This is helpfully applied to NER problem because one of its most challenging aspects is that statistically in the training sets entity names are rare. One approach could be to classify each word in an independent way, but doing this will just ignore the informations given by context. Instead, a conditional random field algorithm will focus on the context.

### Transfer learning

In my opinion [transfer learning](https://en.wikipedia.org/wiki/Transfer_learning) is a really smart technique. In general we can describe it saying that if we have to solve a problem, we try to use the knowledge acquired by solving another related problem. Back to the spam/inbox classifier example, let’s say this time we have to put a real person in doing this check. Our first step could be teaching him that when he reads words related to bank, money, or to a distant relative we have never known that wants to make us his only heir, it should flag the email as spam. A smarter first step we could do is teaching him general knowledge, about finance, advertising, promotions, special offers, and after that we train him on recurring scams. This way his work will be more accurate.
That said, choosing this type of algorithm, we will use a model that is pre-trained on general texts, and we will make it specialize in the domain of our problem.

### Feature Extraction

If you choose the transfer learning algorithm, you have to choose the feature extractor type. The [MLTextClassifier.FeatureExtractorType](https://developer.apple.com/documentation/createml/mltextclassifier/featureextractortype) enumeration contains the possible choices, but using CreateML you can only choose between two of them. This additional parameter is about [word embedding](https://en.wikipedia.org/wiki/Word_embedding). Word embedding is a mathematical technique of language modeling. It is about transforming words into vectors and put them into multi-dimensional spaces. To make it easy word embedding tries to map words into points in a Cartesian plane (again!), the closer two points are to each other, the closer are the meanings of the words mapped to those points. Sadly in real life is more complicated than this because a lot of times our problem has more than two dimensions (again!).
If we choose a static word embedding, we are telling the model to not take into account the context for establishing the similarity of the meanings of the words. On the opposite, if we choose a dynamic word embedding, we are telling the model to take into account the context for establishing the similarity of the meanings of the words. What is the right choice? It depends on the domain of the problem you are trying to solve.
Keep in mind that the static embedding is available in seven languages, the dynamic embedding is only available with English and Spanish.

### Evaluation Phase

The training phase is finally completed after a relatively high number of hours (depending on the number of entries to be used). In our case it was pretty high considering that we had something like 10k entries.

We are now entering the **Evaluation Phase**, in this exact moment, we check if the model is any good by taking a look at the parameters in the dashboard, that the CreateML app returned.

If we have a look at CreateML dashboard we can see two main graphs, one in the Training section, and another one in the Validation section; despite being similar graphs there’s obviously a difference between them: during the **training**, it’s useful to periodically check how well the model is doing and for this purpose, CreateML sets aside a small portion of the training dataset (~5%, for example, if we have a training set composed by 1000 entries, we could have 50 entries used for the described process). So if our validation percentage is not 100% we understand that not all of the entries had its class correctly predicted.
What CreateML does with this 5%: it’s being used to evaluate how well the model does and possibly tuning certain settings of the logistic regression.

![Training 100%](/images/training-100.png) 

There’s something else to look at, I’m talking about the testing section.
First of all, you have to know that the testing dataset entries should be around ~20% (in numbers) of the training dataset (training dataset: 1000 -> testing dataset: 200). Doing so is going to increase the performance of the testing phase. You can load the testing dataset before starting the whole process of training, or you can just test the model after it has been trained, the choice is up to you. 

![Testing 91%](/images/testing-91.png) 

You are now wondering, what it the actual difference between the validation set and the one we just introduced:
* They are both used to find how well the trained model does on new entities to be classified, in our case, we are talking about text.
* Nevertheless the validation set is used to tune the settings of the learning algorithm, the **hyper-parameters**. The validation set actually influences the model, even though the training process never looks at its entities and, while the validation scores give a better idea of the true performance of a model than the training accuracy, it is not unbiased at all.
* It’s a good idea to reserve a separate test set you’d evaluate your model with once, when you’re done training it. Consecutive testing should happen with a different test set.

Let's have a closer look at some parameters that CreateML computes after the training of the model, and that are present in the sections I described above, for each class.
I’m talking about **Precision** and **Recall**. These values are useful to understand which class are performing better than others, and act in consequence.

>If we have a model that recognizes fake from real news, and hypothetically, we have the following values for the fake class: Precision -> 98% | Recall ->95% 

**Precision** means: of all the news the model predicts to be fake, 98% of them are actually fake. Precision is high if we don’t have many **false positives** and it’s low if we often misclassify something as being “fake”.

**Recall** means: it’s quite similar but obviously different; it counts how many fake news the model found among the total number of fake news, in our hypothetical case we can see a value of 95%. This value gives us an idea of the number of false negatives. If the value is low means that we actually missed a lot of news that was fake.

The following image can give you a perspective on what are **false negatives/positives**, also called: **Type II error** and **Type I error**:

![Type I and II Errors](/images/demo.png) 

If these two parameters meanings are still not clear, let’s have a look at what [this wikipedia page](https://en.wikipedia.org/wiki/Precision_and_recall) says:

>**Precision**: it’s the fraction of relevant instances among the retrieved instances
**Recall**: it’s the fraction of the total amount of relevant instances that were actually retrieved

For example, suppose we have a model for recognizing dogs in photographs. It identifies 8 dogs in a picture containing 12 dogs and some cats. Of the 8 identified as dogs, 5 actually are dogs (**true positives**), while the rest are cats (**false positives**). The model’s precision is 5/8 while its recall is 5/12.

Closed parenthesis on what we just said here, we can finally take a look at the output of all these operations, and usable model, that we can actually test on the go inside the CreateML app:

![CreateML Output Model](/images/empty-output.png) 

This dashboard enables the user to write something down that can be reviewed by the model, but for a more effective handmade testing of this model we can tap the “+” button in the left corner and just add an entire folder of text that the model can automatically review.

![simple news](/images/simple-news.png) 

Just select all of the .txt files you need and they will be loaded into CreateML. The model will classify all of the inputs in a relatively small time and you can see what are the predictions for each one of them:

![simple news processed](/images/news-processed.png) 

After this operation it’s time to make our app smarter by implementing the model into our code, the following chapters will guide you through this journey!


When you're ready you can go to the [Next Step](How&#32;to&#32;use&#32;a&#32;text&#32;classifier.md)