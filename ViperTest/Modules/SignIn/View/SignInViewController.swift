//
//  ViewController.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField! //Email field
    @IBOutlet weak var passwordTextField: UITextField! //Password field
    @IBOutlet weak var signInButton: UIButton! //Sign in button
    
    var signInPresenter: SignInPresenter?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(swipe)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func didPressButtonSignIn(_ sender: UIButton) {
        dismissKeyboard()
        signInPresenter?.signIn(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func didPressButtonSignUp(_ sender: UIButton) {
        signInPresenter?.sighUp()
    }
    
    // MARK: - Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y = -(keyboardSize.height - (UIScreen.main.bounds.height - signInButton.frame.origin.y - signInButton.frame.height - 32))
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y = 0
        }
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y = -(keyboardSize.height - (UIScreen.main.bounds.height - signInButton.frame.origin.y - signInButton.frame.height - 32))

        }
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }

}

// MARK: - SignInPresenterProtocol

extension SignInViewController: SignInPresenterProtocol {
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

