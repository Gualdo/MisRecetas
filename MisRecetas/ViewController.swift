//
//  ViewController.swift
//  MisRecetas
//
//  Created by Eduardo D De La Cruz Marr on 27/2/17.
//  Copyright © 2017 Eduardo D De La Cruz Marrero. All rights reserved...
//

import UIKit

class ViewController: UITableViewController // Tambien se puede hacer dejando el UIViewController dejando el view controller en la vista y agregando UITableViewDataSource y UITableViewDelegate
{
    //MARK: - Global variables and constants
    
    var recipes : [Recipe] = []
    
    //MARK: - Predefined methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // Modifica el boton de retorno a la vista principal que se encuentra en la barra de navegacion
        
        var recipe = Recipe(name: "Tortilla de patatas" , image: #imageLiteral(resourceName: "Tortilla") , cookTime: 20 , ingredients: ["Patatas" , "Huevos" , "Cebolla"] , steps: ["Pelar las patatas y las cebollas" , "Cortar las patatas y las cebollas y sofreir" , "Batir los huevos y echarlos durante 1 minuto a la sarten con el resto"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Pizza Margarita" , image: #imageLiteral(resourceName: "Pizza") , cookTime: 60 , ingredients: ["Hrina" , "Levdura" , "Aceite" , "Sal" , "Salsa de tomate" , "Queso"] , steps: ["Hcemos la masa con harina, levura, aceite y sal" , "Dejamos reposar la masa 30 minutos" , "Extendemos la masa encima de una bandeja y añadimos el resto de los ingredientes" , "Hornear durante 12 minutos"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Hamburgesa con queso" , image: #imageLiteral(resourceName: "Hamburgesa") , cookTime: 10 , ingredients: ["Pan de hamburguesa" , "Lechuga" , "Tomate" , "Queso" , "Carne de Hamburguesa"] , steps: ["Poner al fuego la carne al gusto" , "Montar la hamburguesa con sus ingrdientes entre los panes"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Ensalada Cesar" , image: #imageLiteral(resourceName: "Ensalada") , cookTime: 15 , ingredients: ["Lechuga" , "Tomate" , "Cebolla" , "Pimientos" , "Salsa Cesar" , "Pollo"] , steps: ["Limpiar todas las verduras y trocearlas" , "Cocer el pollo al gusto" , "Juntar todos los ingredientes en una ensaladera y servir con salsa cesar por encima"])
        recipes.append(recipe)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated) // Se debe llamar para invocar al super antes de empezar a modificar
        navigationController?.hidesBarsOnSwipe = true // Hace que al hacer swipe la barra de navegacion desaparezca
    }
    
    override var prefersStatusBarHidden: Bool {return true} // Oculta la barra de estado, operador bateria etc etc

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource methods
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let recipe = recipes[indexPath.row]
        let cellID = "RecipeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RecipeCell
        
        cell.thumbnailImageView.image = recipe.image
        cell.nameLabel.text = recipe.name
        cell.timeLabel.text = "\(recipe.cookTime!) min"
        cell.ingredientsLabel.text = "Ingredientes: \(recipe.ingredients.count)"
        
        if recipe.isFavorite
        {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        
        /*cell.thumbnailImageView.layer.cornerRadius = 34 // Hace la imagen circular con el radio dado
        cell.thumbnailImageView.clipsToBounds = true // Corta todo lo que queda fuera del circulo que creamos antes en el caso de este ejemplo lo hicimos desde el Main.Storyboard por eso esta comentado*/
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) // Funcion que habilita el deslizado a la izquierda para poder borrar etc
    {
        if editingStyle == .delete // Ya que la funcion permite borrar, agregar o no hacer nada hacemos este if para programar el borrado
        {
            self.recipes.remove(at: indexPath.row) // Hace que se borre la receta del modelo (array) pero falta hacer que se actualize la vista para que no pete
        }
        
        self.tableView.deleteRows(at: [indexPath], with: .fade) // Actualiza la vista eliminando con la animacion fade la receta que se esta borrando sin tener que recargar toda la vista en caso de terner 10000000000 recetas que en caso de usar el reloadData() seria ineficiente
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? // Metodo para modificar las opciones que aparecen al deslizar a la izquierda uno de los row
    {
        //Accion Compartir
        
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir")
        { (action, indexPath) in
            
            let shareDefaulText = "Estoy mirando la receta de \(self.recipes[indexPath.row].name!) en la app del curso de iOS 10 con Juan Gabriel"
            
            let activityController = UIActivityViewController(activityItems: [shareDefaulText , self.recipes[indexPath.row].image!], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
        }
        
        shareAction.backgroundColor = UIColor(red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255, alpha: 1.0) // Cambia el color de fondo de la opcion compartir
        
        // Accion Borrar
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar")
        { (action, indexPath) in
            
            self.recipes.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0) // Cambia el color de fondo de la opcion borrar
        
        // Accion Favorito
        
        let favouriteAction = UITableViewRowAction(style: .default, title: "Favorito")
        { (action, indexPath) in
            let recipe = self.recipes[indexPath.row]
            
            let alertController = UIAlertController(title: recipe.name , message: "Valora este plato" , preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            var favouriteActionTitle = "Favorito"
            var favouriteActionStyle = UIAlertActionStyle.default
            
            if recipe.isFavorite
            {
                favouriteActionTitle = "No Favorito"
                favouriteActionStyle = UIAlertActionStyle.destructive
            }
            
            let favoriteAction = UIAlertAction(title: favouriteActionTitle, style: favouriteActionStyle)
            { (action) in
                let recipe = self.recipes[indexPath.row]
                recipe.isFavorite = !recipe.isFavorite
                self.tableView.reloadData()
            }
            alertController.addAction(favoriteAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        favouriteAction.backgroundColor = UIColor(red: 30.0/255.0, green: 253.0/255.0, blue:100.0/255.0, alpha: 1.0) // Cambia el color de fondo de la opcion favorito
        
        return [shareAction , favouriteAction , deleteAction]
    }
    
    //MARK: - UITableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showRecipeDetail"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let selectedRecipe = self.recipes[indexPath.row]
                
                let destinationViewController = segue.destination as! DetailViewController
                
                destinationViewController.recipe = selectedRecipe
            }
        }
    }
}
