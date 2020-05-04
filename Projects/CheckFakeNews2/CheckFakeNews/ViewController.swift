//
//  ViewController.swift
//  CheckFakeNews
//
//  Created by Fabio Palladino on 31/03/2020.
//  Copyright © 2020 Fabio Palladino. All rights reserved.
//

import UIKit
import NaturalLanguage

class ViewController: UIViewController {
    @IBOutlet weak var newsTextView: UITextView!
    
    //MARK:
    var textNews: String = ""
    var previusSegmentSelected: Int = -1
    var fakeNewsModel: FakeNewsClassifier!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Variable
        fakeNewsModel = FakeNewsClassifier()
        previusSegmentSelected = 0
    }
    // DISMISS KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    //-------------------------------------------------------
    
    @IBAction func onClickClear(_ sender: UIBarButtonItem) {
        newsTextView.text = ""
    }
    @IBAction func onClickPaste(_ sender: UIBarButtonItem) {
        if UIPasteboard.general.hasStrings {
            if let pasteBoard = UIPasteboard.general.string {
                newsTextView.text = pasteBoard
            }
        }
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
    
    func showMessage(msg: String) {
        let alertController = UIAlertController(title: "FakeNews", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    @IBAction func onChangeView(_ sender: UISegmentedControl) {
        if  previusSegmentSelected == 0 {
            textNews = newsTextView.text
        }
        previusSegmentSelected = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == 0 { //Text News
            newsTextView.text = textNews
        } else if sender.selectedSegmentIndex == 1 { //People/Place/Organization
            newsTextView.text = findPeoplePlaceOrganization(text: textNews)
        } else if sender.selectedSegmentIndex == 2 { //Part of Speach
            newsTextView.text = findPartOfSpeach(text: textNews)
        }
    }
    func findPeoplePlaceOrganization(text: String) -> String {
        var result =  ""
        
        let tagger = NLTagger(tagSchemes: [.nameType]) //Schema base on nameType
        tagger.string = text
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        let tags: [NLTag] = [.personalName, .placeName, .organizationName]
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .nameType, options: options) { tag, tokenRange in
            if let tag = tag, tags.contains(tag) {
                result += "\(text[tokenRange]): \(tag.rawValue) \n"
            }
            return true
        }
        if result.isEmpty {
            result = "No People/Place/Organization Found"
        }
        return result
    }
    func findPartOfSpeach(text: String) -> String {
        var result =  ""
        
        let tagger = NLTagger(tagSchemes: [.lexicalClass]) //Schema base on lexicalClass
        tagger.string = text
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange in
            if let tag = tag {
                result += "\(text[tokenRange]): \(tag.rawValue) \n"
            }
            return true
        }
        if result.isEmpty {
            result = "No Part of Speach Found"
        }
        return result
    }
}

