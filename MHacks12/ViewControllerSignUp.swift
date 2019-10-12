//
//  ViewControllerSignUp.swift
//  MHacks12
//
//  Created by Jennifer Williams on 10/12/19.
//  Copyright © 2019 Jennifer Williams. All rights reserved.
//

import UIKit
import FirebaseAuth
class ViewControllerSignUp: UIViewController {
    
@IBOutlet weak var nameField: UITextField!
@IBOutlet weak var emailField: UITextField!
@IBOutlet weak var passwordField: UITextField!

        var validationErrors = ""

        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
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
        
        @IBAction func signupButtonPressed(_ sender: UIButton) {
            if self.validateFields() {
                Auth.auth().createUser(withEmail: self.emailField.text!, password:
                self.passwordField.text!) { (user, error) in
                    if let  _ = user {
                        self.performSegue(withIdentifier: "segueToMainFromSignUp", sender: self)
                    } else {
                        self.reportError(msg: (error?.localizedDescription)!)
                    }
                }
            } else {
                self.passwordField.text = ""
                self.passwordField.becomeFirstResponder()
                self.reportError(msg: self.validationErrors)
            }
        }
        
        @IBAction func cancelButtonPressed(_ sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }

    extension ViewControllerSignUp : UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == self.emailField {
                self.passwordField.becomeFirstResponder()
            } else {
                if self.validateFields() {
                    print("Congratulations!  You entered correct values.")
                }
            }
            return true
        }
    }
