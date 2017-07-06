//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Alina Abidi on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
//import RSKPlaceholderTextView

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}



class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?

    @IBOutlet weak var textField: UITextView!
   
    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var postButton: UIButton!
    
   
    
    @IBAction func closeCompose(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
    }
    
    func updateCharacterCount() {
        if textField.text.characters.count > 140 {
            myTextField.textColor = UIColor.red
            postButton.isEnabled = false
            
        }
        
        if textField.text.characters.count <= 140 {
            myTextField.textColor = UIColor.black
            postButton.isEnabled = true
            
        }
        myTextField.text = String(textField.text.characters.count) + "/140"
    }
    
    @IBAction func didPressPost(_ sender: Any) {
        print(textField.text.characters.count)
        APIManager.shared.composeTweet(with: textField.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true) 
            }
        }
    }
    
//    text view did begin editing
//    text view did change
//    character count
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        // Do any additional setup after loading the view.
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
