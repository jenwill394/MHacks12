//
//  ViewControllerLogIn.swift
//  MHacks12
//
//  Created by Jennifer Williams on 10/12/19.
//  Copyright © 2019 Jennifer Williams. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewControllerLogIn: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

        var validationErrors = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // dismiss keyboard when tapping outside oftext fields
            let detectTouch = UITapGestureRecognizer(target: self, action:
                #selector(self.dismissKeyboard))
            self.view.addGestureRecognizer(detectTouch)
            
            // make this controller the delegate of the text fields.
            self.emailField.delegate = self as! UITextFieldDelegate
            self.passwordField.delegate = self as! UITextFieldDelegate
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        @objc func dismissKeyboard() {
            self.view.endEditing(true)
        }
        
        func validateFields() -> Bool {
            let pwOk = self.isEmptyOrNil(password: self.passwordField.text)
            if !pwOk {
                self.validationErrors += "Password cannot be blank. "
            }
            
            let emailOk = self.isValidEmail(emailStr: self.emailField.text)
            if !emailOk {
                self.validationErrors += "Invalid email address."
            }
            
            return emailOk && pwOk
        }
        @IBAction func logInButtonPressed(_ sender: UIButton) {
            if self.validateFields() {
                print("Congratulations!  You entered correct values.")
                Auth.auth().signIn(withEmail: self.emailField.text!, password:
                self.passwordField.text!) { (user, error) in
                    if let _ = user {
                        self.performSegue(withIdentifier: "View", sender: self)
                    } else {
                        self.reportError(msg: (error?.localizedDescription)!)
                        self.passwordField.text = ""
                        self.passwordField.becomeFirstResponder()
                    }
                }
            } else {
                self.reportError(msg: self.validationErrors)
            }
        }
        
    }
extension ViewControllerLogIn : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailField {
            self.passwordField.becomeFirstResponder()
        } else {
            if self.validateFields() {
                print(NSLocalizedString("Congratulations! You entered correct values.", comment: ""))
            }
        }
        return true
    }
}

