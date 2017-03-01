//
//  SingleViewController.swift
//  MisRecetas
//
//  Created by Eduardo D De La Cruz Marr on 17/2/17.
//  Copyright © 2017 Eduardo D De La Cruz Marrero. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController
{
    //MARK: - Global variables and constants
    
    @IBOutlet var tableView: UITableView!
    
    var recipes : [Recipe] = []
    
    //MARK: - Predefined methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*self.tableView.dataSource = self
        self.tableView.delegate = self*/ //Se Comenta ya que lo hicimos de la forma graficas
        
        var recipe = Recipe(name: "Tortilla de patatas" , image: #imageLiteral(resourceName: "Protoss") , cookTime: 20 , ingredients: ["Patatas" , "Huevos" , "Cebolla"] , steps: ["Pelar las patatas y las cebollas" , "Cortar las patatas y las cebollas y sofreir" , "Batir los huevos y echarlos durante 1 minuto a la sarten con el resto"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Pizza Margarita" , image: #imageLiteral(resourceName: "terran") , cookTime: 60 , ingredients: ["Hrina" , "Levdura" , "Aceite" , "Sal" , "Salsa de tomate" , "Queso"] , steps: ["Hcemos la masa con harina, levura, aceite y sal" , "Dejamos reposar la masa 30 minutos" , "Extendemos la masa encima de una bandeja y añadimos el resto de los ingredientes" , "Hornear durante 12 minutos"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Hamburgesa con queso" , image: #imageLiteral(resourceName: "Zerg") , cookTime: 10 , ingredients: ["Pan de hambuerguesa" , "Lechuga" , "Tomate" , "Queso" , "Carne de Hamburguesa"] , steps: ["Poner al fuego la carne al gusto" , "Montar la hamburguesa con sus ingrdientes entre los panes"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Ensalada Cesar" , image: #imageLiteral(resourceName: "StarCraft2_SC2_Logo1") , cookTime: 15 , ingredients: ["Lechuga" , "Tomate" , "Cebolla" , "Pimientos" , "Salsa Cesar" , "Pollo"] , steps: ["Limpiar todas las verduras y trocearlas" , "Cocer el pollo al gusto" , "Juntar todos los ingredientes en una ensaladera y servir con salsa cesar por encima"])
        recipes.append(recipe)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableViewDataSource methods

extension SingleViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let recipe = recipes[indexPath.row]
        let cellID = "RecipeCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = recipe.name
        cell.imageView?.image = recipe.image
        return cell
    }
}
