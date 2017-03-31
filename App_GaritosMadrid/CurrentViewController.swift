//
//  CurrentViewController.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CurrentViewController: UIViewController {
    
    
    //MARK: - variables locales
    var garito : GMGaritosModel?
    var locationManager = CLLocationManager()
    var calloutSelected : UIImage?
    var actualizandoLocalizacion = false{
        didSet{
            if actualizandoLocalizacion{
                myBuscarMapa.setImage(#imageLiteral(resourceName: "btn_localizar_off"), for: .normal)
                myActivityIndicator.isHidden = false
                myActivityIndicator.startAnimating()
                myBuscarMapa.isUserInteractionEnabled = false
            }else{
                myBuscarMapa.setImage(#imageLiteral(resourceName: "btn_localizar_on"), for: .normal)
                myActivityIndicator.isHidden = true
                myActivityIndicator.stopAnimating()
                myBuscarMapa.isUserInteractionEnabled = true
                myAddButton.isEnabled = false
            }
        }
    }
    
    
    //MARK: - outlet
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    @IBOutlet weak var myBuscarMapa: UIButton!
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myAddButton: UIBarButtonItem!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    
    
    //MAR: - ACTION
    
    @IBAction func getLocation(_ sender: Any) {
        iniciaLocationManager()
    }
    
    
    
    //MARK: - life VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Api_manager_data.shared.cargarDatos()
        
        actualizandoLocalizacion = false
        
        if revealViewController() != nil{
            myMenuBTN.target = revealViewController()
            myMenuBTN.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }

   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myMapView.delegate = self
        //aquí colocaremos las anotaciones
        myMapView.addAnnotations(Api_manager_data.shared.garito)
    }
    
    
    //MARK: - Utils
    
    func iniciaLocationManager(){
        let estadoAutorizado = CLLocationManager.authorizationStatus()
        switch estadoAutorizado {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            
            present(muestraAlert("Localización desactivada", "Por favor, activa la localización para esta aplicación en los ajustes del dispositivo", "OK"), animated: true, completion: nil)
            
        default:
            if CLLocationManager.locationServicesEnabled(){
                actualizandoLocalizacion = true
                myAddButton.isEnabled = false
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.delegate = self
                locationManager.requestLocation()
                
                let region = MKCoordinateRegionMakeWithDistance(myMapView.userLocation.coordinate, 100, 100)
                myMapView.setRegion(myMapView.regionThatFits(region), animated: true)
            }
        }
    }
    
    
    //MARK: - navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tagGaritoSegue"{
            let navVC = segue.destination as! UINavigationController
            let detalleVC = navVC.topViewController as! DetallearitoViewController
            detalleVC.garito = garito
            detalleVC.gasheDelegate = self
        }
        
        if segue.identifier == "showPinImage"{
            let navVC = segue.destination as! UINavigationController
            let detalleImageVC = navVC.topViewController as! ImagenGaritoViewController
            detalleImageVC.calloutNewImage = calloutSelected
        }
        
    }
    
    


}


//TODO: -- FIN DE LA CLASE

extension CurrentViewController : CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("*** Error en el CoreLocation ***")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.last else {
            return
        }
        
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            self.actualizandoLocalizacion = false
            if error == nil{
                var direccion = ""
                if let placemarkData = placemarks?.last{
                    direccion = self.stringForPlacemark(placemarkData)
                }
                
                self.garito = GMGaritosModel(pDireccionGarito: direccion, pLatitudGarito: latitud, pLongitudGarito: longitud, pImagenGarito: "")
                self.myAddButton.isEnabled = true
            }else{
                self.present(muestraAlert("OOPs!", "Tienes problemas de conexión", "OK"), animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    func stringForPlacemark(_ placemarkData : CLPlacemark) -> String{
        
        var lineaUno = ""
        if let stringUno = placemarkData.thoroughfare, let stringUnoD = placemarkData.subThoroughfare{
            lineaUno += stringUno + ", " + stringUnoD
        }
        
        var lineaDos = ""
        if let stringDos = placemarkData.postalCode, let stringDosD = placemarkData.locality{
            lineaDos += stringDos + " " + stringDosD
        }
        
        var lineaTres = ""
        if let stringTres = placemarkData.administrativeArea, let stringTresD = placemarkData.country{
            lineaTres += stringTres + " " + stringTresD
        }
        
        return lineaUno + "\n" + lineaDos + "\n" + lineaTres
        
    }
    
    

}//TODO: - Fin de la extensión Location Manager


//MARK: - DetalleVC Delegate
extension CurrentViewController : DetallearitoViewControllerDelegate{
    func detalleBarEtiquetado(_ detalleVC: DetallearitoViewController, barEtiquetado: GMGaritosModel) {
        Api_manager_data.shared.garito.append(barEtiquetado)
        Api_manager_data.shared.salvarDatos()
    }
}//TODO: - Fin de la extensión DetalleVC Delegate


//MARK: - Mapkit delegate
extension CurrentViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        //1
        if annotation is MKUserLocation{
            return nil
        }
        //2
        var annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: "garitoPin")
        
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "garitoPin")
        }else{
            annotationView?.annotation = annotation
        }
        
        //3 vamos a configurar la anotacion
        if let place = annotation as? GMGaritosModel{
            let imageName = place.imagenGarito
            if let imageURL = Api_manager_data.shared.imagenUrl(){
                do {
                    let imageData = try Data(contentsOf: imageURL.appendingPathComponent(imageName!))
                    self.calloutSelected = UIImage(data: imageData)
                    let myImageNewScale = resizeImage(calloutSelected!, newWidth: 40)
                    let btnNewAction = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    btnNewAction.setImage(myImageNewScale, for: .normal)
                    annotationView?.leftCalloutAccessoryView = btnNewAction
                    annotationView?.image = #imageLiteral(resourceName: "img_pin")
                    annotationView?.canShowCallout = true
                    
                } catch let error {
                    print("Error en la configuración de la imagen \(error.localizedDescription)")
                }
            }
        }
        
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView{
            performSegue(withIdentifier: "showPinImage", sender: view)
        }
    }
    
    func resizeImage(_ image : UIImage, newWidth : CGFloat) -> UIImage{
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
}





