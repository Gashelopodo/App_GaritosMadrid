//
//  Api_utils.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation

let CONSTANTES = Constantes()

struct Constantes {
    let COLORES = Colores()
    let URLS = BaseUrl()
}

struct Colores {
    let AZUL_BARRA_NAV = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
    let BLANCO_TEXTO_BARRA_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
}

struct BaseUrl {
    let BASE_URL = "https://jsonplaceholder.typicode.com/photos"
    let BASE_URL_OMDB = "http://www.omdbapi.com/?s="
}
