//
//  ImagenGaritoViewController.swift
//  App_GaritosMadrid
//
//  Created by Gashe on 31/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class ImagenGaritoViewController: UIViewController {
    
    
    //MARK: - Variables locales
    var calloutNewImage : UIImage?
    
    
    
    
    
    //MARK: - IBoutlets
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    
    
    //MARK: - actions
    
    @IBAction func hideVC(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detalleImagen = calloutNewImage{
            myImageView.image = detalleImagen
        }
        
        /*if calloutNewImage != nil{
            myImageView.image = calloutNewImage!
        }*/
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
