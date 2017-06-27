//
//  SignUpViewController.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView! //Avatar image
    @IBOutlet weak var imageViewButton: UIButton! //Change avatar button
    @IBOutlet weak var emailTextField: UITextField! //Email field
    @IBOutlet weak var passwordTextField: UITextField! //Password field
    @IBOutlet weak var signUpButton: UIButton! //Signup button
    
    var signUpPresenter: SignUpPresenter?
    
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
    
    @IBAction func didPressButtonSignUp(_ sender: UIButton) {
        dismissKeyboard()
        signUpPresenter?.signUp(email: emailTextField.text!, password: passwordTextField.text!, image:imageView.image!)
    }
    
    @IBAction func didPressButtonSignIn(_ sender: UIButton) {
        signUpPresenter?.signIn()
    }
    
    @IBAction func didPressButtonImageView(_ sender: UIButton) {
        let alertController = UIAlertController.init(title: "Choose image", message: "Choose image source", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction.init(title: "Camera", style: .default, handler: { (action) in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction.init(title: "Library", style: .default, handler: { (action) in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler:nil))
        
        self.present(alertController, animated:true, completion: nil)
    }
    
    
    // MARK: - Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y = -(keyboardSize.height - (UIScreen.main.bounds.height - signUpButton.frame.origin.y - signUpButton.frame.height - 32))
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y = 0
        }
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y = -(keyboardSize.height - (UIScreen.main.bounds.height - signUpButton.frame.origin.y - signUpButton.frame.height - 32))
            
        }
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}

// MARK: - SignUpPresenterProtocol

extension SignUpViewController: SignUpPresenterProtocol {
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension SignUpViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        imageViewButton.setTitle("", for: .normal)
        picker.dismiss(animated:true, completion: nil);
    }
}
