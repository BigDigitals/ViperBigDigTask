//
//  GifPresenterProtocol.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import Foundation

protocol GifPresenterProtocol {
    
    func showGif(picture:Data)
    func showErrorMessage(_ message: String)
    
}
