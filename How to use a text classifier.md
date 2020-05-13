# What you can find here?

We wrote a documentation about create, train and use a machine learning model that can distinguish a fake news from a real one
* [**Intro**](README.md) Let's talk about what Machine Learning and Natural Language processing techiques are about
* [**How to create a text classifier**]((How&#32;to&#32;create&#32;a&#32;text&#32;classifier.md)) Learn how to teach your machine to distinguish a fake news from a real one
* [**How to use a text classifier**](How&#32;to&#32;use&#32;a&#32;text&#32;classifier.md) **Build your own truth machine app**

# How to use a text classifier made with CreateML

## Before starting

[Here](https://github.com/alebar95/Natural-Language-Processing/tree/master/Projects/CheckFakeNews) you can find the source code of our example app using the CoreML model we created. This app checks whether news is fake or not, taking the news text as input.

## Adding the model

We started by adding our trained model to an Xcode project. When you do so, Xcode automatically creates a class that has a property of the type MLModel storing the actual model we created, in our case a text classifier model. It’ll also have a method that takes an input and returns an output representing predictions about the former. It goes without saying that a text classifier model will have a text as input. 

![nlmodel view](/images/XCode-Model.png)

## Creating a NLModel object

We can use the model to create a NLModel object. The NLModel class is one of the classes of the Natural Language framework, useful to analyze natural language text.  An NLModel
object is built upon a CoreML model. In the screen you can see that its initializer takes an MLModel object as input.
This class provides a  predictedLabelfor method to generate predictions on new text inputs. It takes the text and returns its prediction. As we initialized it with our MLModel object it will tell apart fake and real news.

    class ViewController: UIViewController {
        @IBOutlet weak var newsTextView: UITextView!
        
        //MARK:
        var fakeNewsModel: FakeNewsClassifier!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            //MARK: Variable
            fakeNewsModel = FakeNewsClassifier()
            
        }

        @IBAction func onClickCheck(_ sender: UIBarButtonItem) {
            if let news = newsTextView.text {
                if news.count == 0 {
                    showMessage(msg: "Copy/Paste the fake news")
                    return
                }
                do {
                    let labelPredictor = try NLModel(mlModel: self.fakeNewsModel.model)
                    if let prediction = labelPredictor.predictedLabel(for: news) {
                        showMessage(msg: prediction)
                    }
                } catch {
                    print(error)
                }
            }
        }
        
    }


![fane news view](/images/demoFake.png)

![real news view](/images/demoReal.png)

## Identifying parts of speech

Identifying the parts of a speech (also known as PoS) is one of the tasks that natural language processing is often asked to solve. Solving this problem means to understand which category of PoS a word in a sentence belongs to. It is not a trivial problem, because as you may already know, the same word can belong to different categories of PoS.

>“I will **book** the flight and during the flight I will read a **book**.“

As you can see, in this sentence the word “book” is a noun and then a verb. It depends on the context.

The Apple Natural Language framework provides a set of classes to solve this problem. The main one is the [NLTagger](https://developer.apple.com/documentation/naturallanguage/nltagger?language=swift). You can provide a rich set of options to this class, to have a better fit with the data it will process. The first one you will choose is the [NLTagScheme](https://developer.apple.com/documentation/naturallanguage/nltagscheme) that you have to pass as a parameter when initializing the tagger. The tagging scheme represents the purpose of the tagger you are creating. In this particular case we used the [lexicalClass](https://developer.apple.com/documentation/naturallanguage/nltagscheme/2976610-lexicalclass) one. When the tagger will process its input, it will split it according to this tagging scheme, obtaining tokens. The lexical class tag scheme includes three types of tokens: words, punctuation, and whitespaces. For our purpose we chose to ignore the last two of them, and we did that through the [NLTagger.Options](https://developer.apple.com/documentation/naturallanguage/nltagger/options), using the omit words and omitPuntuaction constants. Then you can start the process of tokenization and tagging using the [enumerateTags](https://developer.apple.com/documentation/naturallanguage/nltagger/3017457-enumeratetags) method. One important thing to keep in mind when using a NLTagger is that it is not thread-safe.

## Identifying people, places, and organizations

This problem is a common task for natural language processors too. It is also known as named entity recognition (NER). Solving this problem means finding out which word, or group of words are proper names, and what is the type of the named entity, such as locations or people, and so on. The first thing you would think is that we can easily reduce the complexity of this problem looking at the first letter of each word and considering only the words which start with a capital letter, but if we are processing a transcription of a speech, this can mislead us because transcription sometimes can be not accurate enough. Also some languages do not have capital letters, and some other languages use them in a different way.

Again, the Apple Natural Language framework comes to rescue us. In fact, as in the previous paragraph, we are tagging words in our text. The differences are in the rules we want to be applied for the tagging. We use a [NLTagger](https://developer.apple.com/documentation/naturallanguage/nltagger?language=swift) instance, and we initialize it with an [NLTagScheme](https://developer.apple.com/documentation/naturallanguage/nltagscheme) [nameType](https://developer.apple.com/documentation/naturallanguage/nltagscheme/2976611-nametype). That way we will obtain three classes of names: personal names, organization names, and place names. In our code we also chose to add options through the [NLTagger.Options](https://developer.apple.com/documentation/naturallanguage/nltagger/options) struct, omitPuntuaction, omitWhiteSpaces, and join name. Of course you should adapt these options to the features of the text you will process. After that, you only need to start the process with the [enumerateTags](https://developer.apple.com/documentation/naturallanguage/nltagger/3017457-enumeratetags) method as said before.

## Tokenization and tagging

You can see how much similar, as a developer, are the things you need to do both for identifying parts of speech and recognize named entity with the Apple Natural Language framework. This is a great thing, because the code you need to write reflects the fact that we are solving the tokenization and tagging problem in both cases, but we do it applying different sets of rules.

## Sentiment analysis

Sentiment analysis is the classification of texts according to the emotion that the text appears to convey. It classifies texts according to positive, negative and neutral classifications;
This means that “You are fantastic!” is classified as positive, while “That is too dirty, it’s disgusting!” is classified as negative.

### Sentiment score

In the last two paragraphs you saw that you pass an NLTagScheme as a parameter when you create a new [NLTagger](https://developer.apple.com/documentation/naturallanguage/nltagger?language=swift) object.  Besides the scheme you saw before, there is the [sentiment score](https://developer.apple.com/documentation/naturallanguage/nltagscheme/3113856-sentimentscore), used for sentiment analysis. So the kind of information we are interested in here is the sentiment analysis score. The range of a sentiment score is [-1.0, 1.0]. A score of 1.0 is the most positive, a score of -1.0 is the most negative, and a score of 0.0 is neutral.
In the second example [app](https://github.com/alebar95/Natural-Language-Processing/tree/master/Projects/CheckFakeNews2) we use an NLTagger with a sentiment score to check the general sentiment value of the news text.
NLTagger class has a ‘string’ property and the news text is assigned to it.
Then, as shown in the screen, we use the tag method setting as scheme the sentimentScore enum value. This method will return the tag for the sentiment score.

    @IBAction func onClickSentiment(_ sender: Any) {
        
        if let news = newsTextView.text {
            let tagger = NLTagger(tagSchemes: [.sentimentScore])
            tagger.string = news

            // ask for the results
            let (sentiment, _) = tagger.tag(at: news.startIndex, unit: .paragraph, scheme: .sentimentScore)

            let score = Double(sentiment?.rawValue ?? "0") ?? 0
            let output = "Sentiment value: \(score)\nThe range of a sentiment score is [-1.0, 1.0]. A score of 1.0 is the most positive, a score of -1.0 is the most negative, and a score of 0.0 is neutral."
            showMessage(msg: output)
        }
    }

