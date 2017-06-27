//
//  GifViewController.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class GifViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backbackgroundView: UIView!
    
    var gifPresenter: GifPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissViewController))
        view.addGestureRecognizer(tap)
        
        gifPresenter?.gif()
    }
    
    // MARK: - Dissmiss
    
    func dismissViewController(){
        self.gifPresenter?.backToList()
    }

}

// MARK: - GifPresenterProtocol

extension GifViewController: GifPresenterProtocol {
    
    func showGif(picture:Data){
        imageView.image = UIImage.gif(data: picture)
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
