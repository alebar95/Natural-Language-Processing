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
    var fakeNewsModel: FakeNewsClassifier!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Variable
        fakeNewsModel = FakeNewsClassifier()
        
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
    
    func showMessage(msg: String) {
        let alertController = UIAlertController(title: "FakeNews", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}

