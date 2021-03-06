//
//  PicturesListInteractorProtocol.swift
//  ViperTest
//
//  Created by Artem Melnyk on 6/26/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import Foundation

protocol PicturesListInteractorInputProtocol {
    
    func getPicturesListRequest()
    
}

protocol PicturesListInteractorOutputProtocol {
    
    func getPicturesListSuccessRequest(pictures: [Picture])
    func getPicturesListFailRequest(error: String)
    
}
