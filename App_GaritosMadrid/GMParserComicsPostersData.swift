//
//  GMParserComicsPostersData.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import SwiftyJSON

class GMParserComicsPostersData: NSObject {
    
    var jsonDataPosterImdb : JSON?
    
    func getDataImdb(_ idObjeto: String, idNumero: String) -> Promise<JSON>{
        let customRequest = URLRequest(url: URL(string: CONSTANTES.URLS.BASE_URL_OMDB + idObjeto + "&page=" + idNumero)!)
        
        return Alamofire.request(customRequest).responseJSON().then{ (data) -> JSON in
            self.jsonDataPosterImdb = JSON(data)
            return self.jsonDataPosterImdb!
        }
    }
    
    
    func getParseImdb() -> [GMComicsPostersModel]{
        var arrayDatosImdb = [GMComicsPostersModel]()
        for item in jsonDataPosterImdb!["Search"]{
            let dataModel = GMComicsPostersModel(pTitle: dimeString(item.1, nombreKey: "title"),
                                                 pYear: dimeString(item.1, nombreKey: "Year"),
                                                 pImdbId: dimeString(item.1, nombreKey: "imdbID"),
                                                 pType: dimeString(item.1, nombreKey: "Type"),
                                                 pPoster: dimeString(item.1, nombreKey: "Poster"))
            arrayDatosImdb.append(dataModel)
        }
        return arrayDatosImdb
    }

}
