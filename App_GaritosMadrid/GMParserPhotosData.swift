//
//  GMParserPhotosData.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class GMParserPhotosData: NSObject {
    
    var jsonDataPhotos : JSON?
    
    func getDatosPhotos() -> Promise<JSON>{
        let customRequest = URLRequest(url: URL(string: CONSTANTES.URLS.BASE_URL)!)
        return Alamofire.request(customRequest).responseJSON().then { (data) -> JSON in
            self.jsonDataPhotos = JSON(data)
            return self.jsonDataPhotos!
        }
    }
    
    func getParserPhotos() -> [GMPhotosModel]{
        var arrayPhotosModel = [GMPhotosModel]()
        for item in jsonDataPhotos!{
            let photoModel = GMPhotosModel(pAlbumId: dimeInt(item.1, nombreKey: "albumId"),
                                           pId: dimeInt(item.1, nombreKey: "id"),
                                           pTitle: dimeString(item.1, nombreKey: "title"),
                                           pUrl: dimeString(item.1, nombreKey: "url"),
                                           pThumbnailUrl: dimeString(item.1, nombreKey: "thumbnailUrl"))
            
            arrayPhotosModel.append(photoModel)
            
        }
        
        return arrayPhotosModel
        
    }
    
}
