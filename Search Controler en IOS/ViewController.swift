//
//  ViewController.swift
//  Search Controler en IOS
//
//  Created by alumno on 7/03/17.
//  Copyright © 2017 alg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    let SearchController = UISearchController(searchResultsController: nil)
    
    var dispositivos = Array<Dispositivo>()
    var dispositivosFiltrados = Array<Dispositivo>()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtBuscar: UITextField!
    
    
    @IBAction func txtBuscarEdit(_ sender: AnyObject) {
        let texto = txtBuscar.text
        
        dispositivosFiltrados = dispositivos.filter({ (dispositivo) -> Bool in
            //connvertimos un numero a string para realizar la busqueda de numeros con un string
            return ("\(dispositivo.precio)".contains(texto!) || dispositivo.nombre.lowercased().contains(texto!) || dispositivo.fabricacion.contains(texto!))
            //return String(dispositivo.precio).contains(texto!)
            
            //return dispositivo.nombre.lowercased().contains(texto!)
            
        })
        
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SearchController.searchBar.placeholder = "Busqueda"
        SearchController.searchBar.prompt = "Titulo"
        SearchController.searchResultsUpdater = self
        tableView.tableHeaderView = SearchController.searchBar
        
        
        for i in 1...9 {
            
            var dispositivo = Dispositivo()
            
            switch i {
            case 1:
                dispositivo.nombre = "IPhone"
                dispositivo.precio = 599.00
                dispositivo.fabricacion = "2007"
            case 2:
                dispositivo.nombre = "IPod"
                dispositivo.precio = 399.00
                dispositivo.fabricacion = "2001"
            case 3:
                dispositivo.nombre = "IPod touch"
                dispositivo.precio = 210.00
                dispositivo.fabricacion = "2007"
            case 4:
                dispositivo.nombre = "Ipad"
                dispositivo.precio = 499.00
                dispositivo.fabricacion = "2010"
            case 5:
                dispositivo.nombre = "Ipad mini"
                dispositivo.precio = 659.00
                dispositivo.fabricacion = "2012"
            case 6:
                dispositivo.nombre = "IMac"
                dispositivo.precio = 659.00
                dispositivo.fabricacion = "1997"
            case 7:
                dispositivo.nombre = "Mac Pro"
                dispositivo.precio = 2499.00
                dispositivo.fabricacion = "2006"
            case 8:
                dispositivo.nombre = "MacBook Air"
                dispositivo.precio = 1799.00
                dispositivo.fabricacion = "2008"
            default:
                dispositivo.nombre = "MacBook Pro"
                dispositivo.precio = 1499.00
                dispositivo.fabricacion = "2006"
            }
            
            dispositivos.append(dispositivo)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if SearchController.isActive && SearchController.searchBar.text != "" {
            return dispositivosFiltrados.count
        }else{
            return dispositivos.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        let item:Dispositivo
        
        if SearchController.isActive && SearchController.searchBar.text != "" {
            item = dispositivosFiltrados[indexPath.row]
        }else{
            item = dispositivos[indexPath.row]
        }
        
        cell.textLabel?.text = item.nombre
        cell.detailTextLabel?.text = "$\(item.precio!) | " + item.fabricacion
        
        return cell
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let texto = SearchController.searchBar.text?.lowercased()
        
        dispositivosFiltrados = dispositivos.filter({ (dispositivo) -> Bool in
            //connvertimos un numero a string para realizar la busqueda de numeros con un string
            return ("\(dispositivo.precio)".contains(texto!) || dispositivo.nombre.lowercased().contains(texto!) || dispositivo.fabricacion.contains(texto!))
            //return String(dispositivo.precio).contains(texto!)
            
            //return dispositivo.nombre.lowercased().contains(texto!)
            
        })
        
        tableView.reloadData()
    }


}

