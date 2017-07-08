//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Alina Abidi on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import KRProgressHUD


protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?

    @IBOutlet weak var textField: UITextView!
   
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var postButton: UIButton!
    
   
    
    @IBAction func closeCompose(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postButton.isEnabled = false
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textField.text.isEmpty {
            textField.text = "#tweet"
            textField.textColor = UIColor.lightGray
        }
    }
    
    func updateCharacterCount() {
        if textField.text.characters.count > 140 {
            countLabel.textColor = UIColor.red
            postButton.isEnabled = false
            let overloadInt = 140 - textField.text.characters.count
            countLabel.text = String(overloadInt)
        }
        
        else if textField.text.characters.count == 0 {
            postButton.isEnabled = false
            countLabel.text = String(textField.text.characters.count) + "/140"
        }
        
        else {
            countLabel.textColor = UIColor.black
            postButton.isEnabled = true
            countLabel.text = String(textField.text.characters.count) + "/140"
        }
    }
    
    @IBAction func didPressPost(_ sender: Any) {
        KRProgressHUD.show()
        APIManager.shared.composeTweet(with: textField.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true)
                KRProgressHUD.dismiss()
            }
        }
    }
    
//    text view did begin editing
//    text view did change
//    character count
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.text = "#tweet"
        textField.textColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
