//
//  Recipe.swift
//  MisRecetas
//
//  Created by Eduardo D De La Cruz Marr on 17/2/17.
//  Copyright © 2017 Eduardo D De La Cruz Marrero. All rights reserved.
//

import Foundation
import UIKit

class Recipe: NSObject
{
    //MARK: - Global Variables
    
    var name : String!
    var image : UIImage!
    var cookTime : Int!
    var ingredients : [String]!
    var steps : [String]!
    var isFavorite : Bool = false
    var rating : String = "rating"
    
    //MARK: - Object Constructor
    
    init(name: String , image: UIImage , cookTime: Int , ingredients: [String] , steps: [String])
    {
        self.name = name
        self.image = image
        self.cookTime = cookTime
        self.ingredients = ingredients
        self.steps = steps
    }
}
