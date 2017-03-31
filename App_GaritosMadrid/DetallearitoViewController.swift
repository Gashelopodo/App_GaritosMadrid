//
//  DetallearitoViewController.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

//TODO: - Fase delegado
protocol DetallearitoViewControllerDelegate{
    func detalleBarEtiquetado(_ detalleVC : DetallearitoViewController, barEtiquetado : GMGaritosModel)
}


class DetallearitoViewController: UIViewController {
    
    //MARK: - variables locales
    
    var garito : GMGaritosModel?
    var gasheDelegate : DetallearitoViewControllerDelegate?
    
    
    //MARK: - oultet
    
    @IBOutlet weak var myImageViewPicker: UIImageView!
    @IBOutlet weak var myLatitudLabe: UILabel!
    @IBOutlet weak var myLongitudLabel: UILabel!
    @IBOutlet weak var myDireccionLabel: UILabel!
    @IBOutlet weak var mySalvarDatosBTN: UIBarButtonItem!
    
    
    //MARK: - action
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveInfo(_ sender: Any) {
        if let imageData = myImageViewPicker.image{
            let randomNameImage = UUID().uuidString.appending(".jpg")
            if let customUrl = Api_manager_data.shared.imagenUrl()?.appendingPathComponent(randomNameImage){
                if let imageDataDes = UIImageJPEGRepresentation(imageData, 0.3){
                    do{
                        try imageDataDes.write(to: customUrl)
                    }catch{
                        print("Error salvando datos")
                    }
                }
            }
            
            garito = GMGaritosModel(pDireccionGarito: myDireccionLabel.text!, pLatitudGarito: Double(myLatitudLabe.text!)!, pLongitudGarito: Double(myLongitudLabel.text!)!, pImagenGarito: randomNameImage)
            
            if let infoGarito = garito{
                gasheDelegate?.detalleBarEtiquetado(self, barEtiquetado: infoGarito)
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageViewPicker.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImageViewPicker.addGestureRecognizer(tapGR)
        
        configuredLabels()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - utils
    
    func configuredLabels(){
        myLatitudLabe.text = String(format: "%.8f", (garito?.coordinate.latitude)!)
        myLongitudLabel.text = String(format: "%.8f", (garito?.coordinate.longitude)!)
        myDireccionLabel.text = garito?.direccionGarito
    }
    

}//TODO: - fin de la clase

extension DetallearitoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func pickerPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        }else{
            muestraLibreriaFotos()
        }
    }
    
    func muestraMenu(){
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tomaFotoCamaraAction = UIAlertAction(title: "Toma foto", style: .default) { _ in
            self.muestraCamaraDispositivo()
        }
        let seleccionaFotoAction = UIAlertAction(title: "Selecciona desde la libreria", style: .default) { _ in
            self.muestraLibreriaFotos()
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(tomaFotoCamaraAction)
        alertVC.addAction(seleccionaFotoAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func muestraLibreriaFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func muestraCamaraDispositivo(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImageViewPicker.image = imageData
            mySalvarDatosBTN.isEnabled = true
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
}
