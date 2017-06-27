//
//  PicturesListCollectionViewController.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PicturesListCollectionViewController: UICollectionViewController {
    
    var picturesListPresenter: PicturesListPresenter?

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (UIScreen.main.bounds.size.width - 300)/3
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(width, width, width, width)
        flow.minimumInteritemSpacing = width
        flow.minimumLineSpacing = width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.picturesListPresenter?.getPicturesList()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressAddButton(_ sender: UIButton) {
        picturesListPresenter?.addNewImage()
    }
    
    @IBAction func didPressPlayButton(_ sender: UIButton) {
        picturesListPresenter?.playGIFImage()
    }

}

// MARK: - UICollectionViewDataSource

extension PicturesListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesListPresenter!.numberOfImages();
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as! PictureCell
        
        let picture = picturesListPresenter!.picture(index: indexPath.row)
        
        cell.pictureImageView.af_setImage(withURL: URL.init(string: picture.url)!)
        cell.weatherLabel.text = picture.weather
        cell.addressLabel.text = picture.address
        
        return cell
    }
    
}

// MARK: - PicturesListPresenterProtocol

extension PicturesListCollectionViewController: PicturesListPresenterProtocol {
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func reloadData(){
        self.collectionView?.reloadData()
    }
    
}


 
