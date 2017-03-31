//
//  GMGaritosModel.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import MapKit

class GMGaritosModel: NSObject, NSCoding{
    
    
    var direccionGarito : String?
    var latitudGarito : Double?
    var longitudGarito : Double?
    var imagenGarito : String?
    
    
    init(pDireccionGarito : String, pLatitudGarito : Double, pLongitudGarito : Double, pImagenGarito : String) {
        self.direccionGarito = pDireccionGarito
        self.latitudGarito = pLatitudGarito
        self.longitudGarito = pLongitudGarito
        self.imagenGarito = pImagenGarito
        super.init()
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        let direccionKey = aDecoder.decodeObject(forKey: "direccionKey") as! String
        let latitudKey = aDecoder.decodeObject(forKey: "latitudKey") as! Double
        let longitudKey = aDecoder.decodeObject(forKey: "longitudKey") as! Double
        let imagenKey = aDecoder.decodeObject(forKey: "imagenKey") as! String
        
        self.init(pDireccionGarito : direccionKey, pLatitudGarito : latitudKey, pLongitudGarito : longitudKey, pImagenGarito : imagenKey)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.direccionGarito, forKey: "direccionKey")
        aCoder.encode(self.latitudGarito, forKey: "latitudKey")
        aCoder.encode(self.longitudGarito, forKey: "longitudKey")
        aCoder.encode(self.imagenGarito, forKey: "imagenKey")
    }
    

}


//TODO:  Fin de la clase modelo

extension GMGaritosModel : MKAnnotation{
    
    
    public var coordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: latitudGarito!, longitude: longitudGarito!)
        }
    }
    

    var title: String? {
        get{
            return "Garito de Madrid"
        }
    }
    
   var subtitle: String? {
        get{
            return direccionGarito?.replacingOccurrences(of: "\n", with: "")
        }
    }
    
    
}
