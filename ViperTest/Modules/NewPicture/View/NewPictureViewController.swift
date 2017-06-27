//
//  NewPictureViewController.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import Photos
import CoreLocation

class NewPictureViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var hashtagTextField: UITextField!
    
    var newPicturePresenter: NewPicturePresenter?
    var imageInfo: Dictionary<String, Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(swipe)
    }

    // MARK: - Keyboard
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction func didPressButtonSave(_ sender: UIBarButtonItem) {
        dismissKeyboard()
        newPicturePresenter?.newPicture(image:imageView.image!, description: descriptionTextField.text!, hashtag: hashtagTextField.text!, imageInfo: imageInfo!)
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
}

// MARK: - NewPicturePresenterProtocol

extension NewPictureViewController: NewPicturePresenterProtocol {
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension NewPictureViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        imageViewButton.setTitle("", for: .normal)
        imageInfo = info
        picker.dismiss(animated:true, completion: nil);
        
        
    }
}
