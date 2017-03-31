//
//  GMComicsPostersModel.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class GMComicsPostersModel: NSObject {
    
    var title : String?
    var year : String?
    var imdbId : String?
    var type : String?
    var poster : String?
    
    init(pTitle : String, pYear: String, pImdbId : String, pType : String, pPoster : String) {
        self.title = pTitle
        self.year = pYear
        self.imdbId = pImdbId
        self.type = pType
        self.poster = pPoster
        super.init()
    }

}
