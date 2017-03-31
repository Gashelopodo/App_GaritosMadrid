//
//  Api_manager_data.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class Api_manager_data: NSObject {
    
    static let shared = Api_manager_data()
    
    var garito : [GMGaritosModel] = []
    
    
    //MARK: - SALVAR DATOS
    func salvarDatos(){
        if let urlData = dataBaseUrl(){
            NSKeyedArchiver.archiveRootObject(garito, toFile: urlData.path)
        }else{
            print("Error guardando datos")
        }
    }
    
    func cargarDatos(){
        if let urlData = dataBaseUrl(), let datosSalvados = NSKeyedUnarchiver.unarchiveObject(withFile: urlData.path) as? [GMGaritosModel]{
            garito = datosSalvados
        }else{
            print("Error cargando datos")
        }
    }
    
    func dataBaseUrl() -> URL?{
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let customUrl = URL(fileURLWithPath: documentDirectory)
            return customUrl.appendingPathComponent("garitos.data")
        }else{
            return nil
        }
    }
    
    func imagenUrl() -> URL?{
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let customUrl = URL(fileURLWithPath: documentDirectory)
            return customUrl
        }else{
            return nil
        }
    }
    
    

}//TODO: - fin de la clase
