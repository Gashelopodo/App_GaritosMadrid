//
//  GMListaPostersTableViewController.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import PKHUD

class GMListaPostersTableViewController: UITableViewController {
    
    //MARK: - variables locales
    var arrayPosters : [GMComicsPostersModel] = []
    
    
    //MARK: - OUtlet
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var bookMarkButton: UIBarButtonItem!
    var customRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        llamadaPosters()
        
        customRefreshControl.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        customRefreshControl.addTarget(self, action: #selector(recargado), for: .valueChanged)
        tableView.addSubview(customRefreshControl)
        
        //MARK: menu lateral
        
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            
            bookMarkButton.target = revealViewController()
            bookMarkButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //MARK: registro de xib
        
        tableView.register(UINib(nibName: "GMDetallePosterCustomCell", bundle: nil), forCellReuseIdentifier: "DetallePosterCustomCell")
    
    }
    
    func recargado(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayPosters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetallePosterCustomCell", for: indexPath) as! GMDetallePosterCustomCell
        
        let model = arrayPosters[indexPath.row]
        cell.myTituloPoster.text = model.title
        cell.myIdPoster.text = model.imdbId
        cell.myYearPoster.text = model.year
        cell.myImagenPoster.kf.setImage(with: URL(string: model.poster!), placeholder: #imageLiteral(resourceName: "placehoder"), options: nil, progressBlock: nil, completionHandler: nil)

        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415
    }
    
    
    //MARK: - utils
    
    func llamadaPosters(){
        let posterData = GMParserComicsPostersData()
        let randomNumero = Int(arc4random_uniform(3))
        let arrayPersonajes = ["Batman", "Superman", "Flash"]
        HUD.show(.progress)
        firstly{
            return when(resolved: posterData.getDataImdb(arrayPersonajes[randomNumero], idNumero: "\(randomNumero)"))
        }.then{_ in
            self.arrayPosters = posterData.getParseImdb()
        }.then{_ in
            self.tableView.reloadData()
        }.then{_ in
            HUD.hide(afterDelay: 0)
        }.catch { (Error) in
            self.present(muestraAlert("Estimado usuario", "\(Error.localizedDescription)", "OK"), animated: true, completion: nil)
        }
        
    }
    

   

}
