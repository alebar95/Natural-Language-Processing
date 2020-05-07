# How to Build Your Own Truth Machine

## Introduction to Machine learning
What is Machine Learning?
Suppose we want to write a program that is able to recognize in a text if the statements that are contained in it are true or false.
If we wanted to write an algorithm, this would be, if not impossible, very difficult and complicated. In fact, we will have to take into account all the possible words that express a meaning, all the different meanings that a word assumes according to how it is arranged in a sentence. Furthermore, we should also understand if there is irony, who is the subject of a sentence, the implied statements, ...
As you can see, it is also long to write down everything that must be taken into account.
But if instead of writing an algorithm with which a machine is able to recognize a fake news it was possible to explain and make a machine understand what a fake news would be, it would learn by itself how to recognize it, a bit like we humans do that when we see a car or bicycle we can recognize them.
Machine learning is a technique that is used precisely for this purpose.
This technique allows the automatic creation of a neural network, which will be built automatically by the computer with the supervised learning technique.
 There are several techniques but this is the most reliable one currently.
This technique in a nutshell involves the use of a certain amount of data, news in this case, which has been divided into true and false news. The computer will analyze the news, extract the information, and check if the news is true or false (information that is given to it).
The thing to keep in mind is that the computer will extract more and more information because it will learn after each news and the analysis will generally be performed several times.
Our computer will then automatically extract all the features from the documents in order to eventually build a model that will be able to predict whether a news is true or false, based on how it is written and therefore without the need to extract the semantics from the news.
What has just been said is valid for any type of thing to be analyzed, from recognizing spam emails from work emails, always to remain in the text, or to recognize a dog from a cat or another type of animal, or even yes will be able to recognize if a child is crying or laughing. In short, the applications are endless.

## Introduction to Natural Language
### Natural Language Processing (NLP) 
“Natural language processing (NLP) is a subfield of linguistics, computer science, information engineering, and artificial intelligence concerned with the interactions between computers and human (natural) languages, in particular how to program computers to process and analyze large amounts of natural language data.”
 [Wikipedia](https://en.wikipedia.org/wiki/Natural_language_processing)

The broader conception of NLP falls in the thematic area of natural language: as the name suggests, The Natural Language Processing refers to computer processing of natural language. By natural language we mean the language we use everyday such as English, Russian, Japanese, Chinese and it is synonymous with human language,mainly to distinguish it from formal language, included computer language. 
Why is this so important? Why have industry experts been trying to provide natural language analysis tools for decades?
 Because maybe it’s the basis of the study that leads to text to speech, to speech recognition and dozens of other possible applications.
Over the time many companies, a lot of frameworks have attempted to give developers useful tools that are simple and ready to analyze the text, but never as these last years where the world of Apps and machine learning with deep learning has increased analytical skills like never before.
Apple couldn’t be less and like it often does, it has provided a simple, enough complete and “ready to start” to analyze the text in different ways and that allows,combinated with a framework of CoreML family, a valuable tool to create amazing features in our apps.
[Apple Documentation](https://developer.apple.com/documentation/naturallanguage)

Apple, differently to other frameworks, have obviously thought about its clients, its developers, and it has provided a spectacular number of languages available today, which are 56, and i didn’t even know many of them existed.
The available languages ​​are the following:
amharic,  arabic, armenian, bengali, bulgarian, burmese, catalan, cherokee, croatian, czech, danish, dutch, english, finnish, french, georgian, german, greek, gujarati, hebrew, hindi, hungarian, icelandic, indonesian, italian, japanese, kannada, khmer, korean, lao, malay, malayalam, marathi, mongolian, norwegian, oriya, persian, polish, portuguese, punjabi, romanian, russian, simplified Chinese, sinhalese, slovak, spanish, swedish, tamil, telugu, thai, tibetan, traditional Chinese, turkish, ukrainian, urdu, vietnamese.

[Apple Documentation](https://developer.apple.com/documentation/naturallanguage/nllanguage)

As often happens in the Apple system, this framework combined with the other frameworks provides a fantastic tool to make our dream app.

## Text classifiers

### Classes
To have a better understanding of what a text classifier is, we should first define what is a class. We can say that a class is a set of items, where every item in the same class has one or more common features. Let’s make an example using images: suppose that you have two classes, class A and class B. An image should belong to class A if there are one or more cats in it; an image should belong to class B if there are no cats in it.
As you can see this is a very simple situation, because as a consequence of our definition of the two classes, an item will belong to A or B. Suppose we have an image with a cat. It goes straight into class A. A picture of a table should go into class B. If we have a photo of a cat relaxing on a table it should belong to class A.

### Classifiers
A classifier is a software or a part of it, that will analyze the item you give it in input, and will tell you the name of the class that item should belong to. Nothing more, nothing less.
When it has to choose between one or two classes, it does a [binary classification](https://en.wikipedia.org/wiki/Binary_classification), with three classes or more, it does a [multiclass classification](https://en.wikipedia.org/wiki/Multiclass_classification). There is one more thing we should pay attention to: in some cases, an item should only belong to one class, but sometimes it could belong to more than one class. Think about this: X is the class containing pictures of dogs, Y is the class containing pictures of cats. A picture with a cat and a dog should belong to both classes. This particular case is called [multi-label classification](https://en.wikipedia.org/wiki/Multi-label_classification), where labels are simply the names of the classes.

### Text classifiers
Now that we know what a classifier is, what classes are, let’s apply these two concepts to text. A text classifier can tell you if a given text satisfies a given property. Think about emails. Probably your email inbox has a text classifier that is protecting it from spam. That classifier, each time a new email is sent to you, will analyze it and then will put it into your inbox or into your spam folder.

## Datasets

### Definition
A dataset is a collection of data. A model will use a dataset to learn how to accomplish its task. For this reason, the dataset should contain data as much similar as possible to those on which the model will work. Let’s say I want a text classifier that tells me if an email is spam or not. I give it a lot of spam emails written in English to learn on. I cannot complain if that model will not be able to recognize spam emails written in Spanish!
Two of the most common formats for a text-based dataset are the [JSON](https://it.wikipedia.org/wiki/JavaScript_Object_Notation) and the [CSV](https://en.wikipedia.org/wiki/Comma-separated_values).

### Labels in dataset
A dataset can be labeled, not labeled, or partially labeled. This is a key feature of the dataset because it would lead to different results and performances when training a model.
A dataset is labeled when each one entry of it has its own label, and that label will be the name of the class that entry belongs to.

email_text, label
“Hey man, this is the file you were searching!”, not_spam 
“Hi dear, do you want to know how to make easy money?”, spam
. . .

A text classifier trained on that kind of dataset will classify the text you give to it, into the class is found in the dataset it was trained on. This is the [supervised learning](https://en.wikipedia.org/wiki/Supervised_learning) approach.

A dataset where no entry is labeled is said not labeled. The classifier will try to infer its own labels, but they easily could not match our expectations. This is the [unsupervised learning](https://en.wikipedia.org/wiki/Supervised_learning) approach.

A dataset in which a small part of entries is labeled and the remaining part is not, is said partially labeled. A text classifier trained on that kind of dataset will use the labels in it, but could also try to infer its own labels. This is the [semi-supervised learning](https://en.wikipedia.org/wiki/Semi-supervised_learning) approach.

Usually the first approach is used when working with text-based data, while the second and third express their potential with numeric based data. Choosing the approach should be made taking into account also the kind of problem we are trying to solve.

