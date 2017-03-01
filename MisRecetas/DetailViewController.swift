//
//  DetailViewController.swift
//  MisRecetas
//
//  Created by Eduardo D De La Cruz Marr on 20/2/17.
//  Copyright © 2017 Eduardo D De La Cruz Marrero. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    //MARK: - Global variables and constants
    
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var ratingButton: UIButton!
    
    var recipe : Recipe!
    
    //MARK: - Predefined methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = recipe.name // Coloca en la barra de navegacion el nombre de la receta
        
        self.recipeImageView.image = self.recipe.image
        
        self.tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25) // Cambia el color del fondo de cada una de las celdas
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero) // Hace que despues de la ultima celda modificada por nosotros no aparezca nada mas ninguno otra celda vacia.
        
        self.tableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75) // Cambia el color de las divisiones entre cada una de las Row
        
        self.tableView.estimatedRowHeight = 44.0 // Se le da la altura que estimamos que va a tener la fila
        
        self.tableView.rowHeight = UITableViewAutomaticDimension // Se le dice a xcode que dimensiona automaticamente la fila segun la medida que colocamos arriba, con estas dos lineas de codigo hacemos las filas autoescalables y se ajuste a su contenido dinamicamente
        
        self.ratingButton.setImage(UIImage(named: self.recipe.rating), for: .normal) // Coloca la imagen que le corresponde al boton de valoracion
    }
    
    override func viewWillAppear(_ animated: Bool) // Semejante al viewDidLoad pero en vez de llamarse solo cuando se carga la vista se llama cada vez que la vista aparezca
    {
        super.viewWillAppear(animated) // Se llama al super
        navigationController?.hidesBarsOnSwipe = false // Hace que no se oculte la barra
        navigationController?.setNavigationBarHidden(false, animated: true) // Si la barra estaba oculta hace que aparezca
    }
    
    override var prefersStatusBarHidden: Bool {return true} // Oculta la barra de estado de bateria operador etc etc
    
    @IBAction func close(segue: UIStoryboardSegue)
    {
        if let reviewVC = segue.source as? ReviewViewController
        {
            if let rating = reviewVC.ratingSelected
            {
                self.recipe.rating = rating // Guarda el nombre de la imagen que corresponde al boton de valoracion de ese recipe
                self.ratingButton.setImage(UIImage(named: self.recipe.rating), for: .normal) // Coloca la imagen que le corresponde al boton de valoracion
            }
        }
    }
}

//MARK: - UITableViewDataSource methods

extension DetailViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
            case 0:
                return 3
            case 1:
                return self.recipe.ingredients.count
            case 2:
                return self.recipe.steps.count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRecipeCell", for: indexPath) as! RecipeDetailViewCell
        
        cell.backgroundColor = UIColor.clear
        
        switch indexPath.section // Swith para la seccion elegida
        {
            case 0:
                switch indexPath.row // Swith para el row elegido
                {
                    case 0:
                        cell.keyLabel.text = "Nombre:"
                        cell.valueLabel.text = self.recipe.name
                    case 1:
                        cell.keyLabel.text = "Tiempo:"
                        cell.valueLabel.text = "\(self.recipe.cookTime!) min"
                    case 2:
                        cell.keyLabel.text = "Favorito: "
                        if self.recipe.isFavorite
                        {
                            cell.valueLabel.text = "Si"
                        }
                        else
                        {
                            cell.valueLabel.text = "No"
                        }
                    default:
                        break
                }
            case 1:
                if indexPath.row == 0
                {
                    cell.keyLabel.text = "Ingredientes:"
                }
                else
                {
                    cell.keyLabel.text = ""
                }
                cell.valueLabel.text = self.recipe.ingredients[indexPath.row]
            case 2:
                if indexPath.row == 0
                {
                    cell.keyLabel.text = "Pasos:"
                }
                else
                {
                    cell.keyLabel.text = ""
                }
                cell.valueLabel.text = self.recipe.steps[indexPath.row]
            default:
                break         
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        var title = ""
        
        switch section
        {
            case 0:
                title = "Descripcion"
            case 1:
                title = "Ingredientes"
            case 2:
                title = "Pasos"
            default:
                break
        }
        
        return title
    }
}

//MARK: - UITableViewDelegate methods

extension DetailViewController : UITableViewDelegate
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showReview"
        {            
            let destinationViewController = segue.destination as! ReviewViewController // Crea la conexion de esta clase con la siguiente a traves del segue utilizado
                
            destinationViewController.recipe = recipe // Envia la informacion del recipe en el que nos encontramos en esta vista al controller de la siguiente vista
        }
    }
}
