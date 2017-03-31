//
//  Api_helpers.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

func muestraAlert(_ titleData: String, _ messageData: String, _ titleAction: String) -> UIAlertController{
    let alert = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: titleAction, style: .default, handler: nil))
    
    return alert
}


//MARK: - NUll to String

public func dimeString(_ json: JSON, nombreKey: String) -> String{
    
    var response = ""
    
    if let stringResult = json[nombreKey].string{
        response = stringResult
    }
    
    return response
}

//MARK: Null to Int

public func dimeInt(_ json: JSON, nombreKey: String) -> Int{
    
    var response = 0
    
    if let intResult = json[nombreKey].int{
        response = intResult
    }
    
    return response
}

//MARK: Null to Double

public func dimeDouble(_ json: JSON, nombreKey: String) -> Double{
    
    var response = 0.0
    
    if let doubleResult = json[nombreKey].double{
        response = doubleResult
    }
    
    return response
}

//MARK: Null to Float

public func dimeFloat(_ json: JSON, nombreKey: String) -> Float{
    
    var response : Float = 0.0
    
    if let floatResult = json[nombreKey].float{
        response = floatResult
    }
    
    return response
}


