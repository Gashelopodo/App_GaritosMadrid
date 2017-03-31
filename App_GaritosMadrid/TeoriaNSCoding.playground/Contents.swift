//: Playground - noun: a place where people can play

import UIKit

class Persona : NSObject, NSCoding{
    
    var nombre : String!
    var apellido : String!
    var direccion : String!
    var email : String!
    
    init(pNombre : String, pApellido : String, pDireccion : String, pEmail : String) {
        self.nombre = pNombre
        self.apellido = pApellido
        self.direccion = pDireccion
        self.email = pEmail
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let nombreKey = aDecoder.decodeObject(forKey: "nombreKey") as! String
        let apellidoKey = aDecoder.decodeObject(forKey: "apellidoKey") as! String
        let direccionKey = aDecoder.decodeObject(forKey: "direccionKey") as! String
        let emailKey = aDecoder.decodeObject(forKey: "emailKey") as! String
        
        self.init(pNombre : nombreKey, pApellido : apellidoKey, pDireccion : direccionKey, pEmail : emailKey)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.nombre, forKey: "nombreKey")
        aCoder.encode(self.apellido, forKey: "apellidoKey")
        aCoder.encode(self.direccion, forKey: "direccionKey")
        aCoder.encode(self.email, forKey: "emailKey")
    }
    
}//TODO: - Fuera de la clase

var multitud = [Persona]()

multitud.append(Persona(pNombre: "Mario", pApellido: "Alcázar", pDireccion: "Calle minas 9", pEmail: "mario@hotmail.com"))
multitud.append(Persona(pNombre: "Juan", pApellido: "Sin Miedo", pDireccion: "Calle ponzano 34", pEmail: "juan@hotmail.com"))
multitud.append(Persona(pNombre: "Teo", pApellido: "Martinez", pDireccion: "Calle santander 69", pEmail: "teo@hotmail.com"))

func dateBaseUrl() -> URL?{
    
    if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
        let customUrl = URL(fileURLWithPath: documentDirectory)
        return customUrl.appendingPathComponent("multitud.data")
    }else{
        return nil
    }
    
}


func salvarInfo(){

    if let urlData = dateBaseUrl(){
        NSKeyedArchiver.archiveRootObject(multitud, toFile: urlData.path)
        print(urlData.path)
    }else{
        print("Error al guardar los datos")
    }
}

/*
func cargarInfo(){
    if let urlData = dateBaseUrl(){
        if let datosSalvados = NSKeyedUnarchiver.unarchiveObject(with: urlData.path) as? [Persona]{
        
        }
    }
}*/

func cargarInfo(){
    
    if let urlData = dateBaseUrl(), let datosSalvados = NSKeyedUnarchiver.unarchiveObject(withFile: urlData.path) as? [Persona]{
        multitud = datosSalvados
    }else{
        print("Error al cargar datos")
    }
    
}

//
salvarInfo()
//
multitud.removeAll()
//
cargarInfo()

for c_persona in multitud{
    print("Nombre: \(c_persona.nombre) \n Apellido: \(c_persona.apellido) \n Email: \(c_persona.email) \n Direccion: (c_persona.direccion)")
}


