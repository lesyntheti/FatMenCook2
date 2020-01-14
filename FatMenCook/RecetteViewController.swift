//
//  RecetteViewController.swift
//  FatMenCook
//
//  Created by Guillaume Bayle on 10/12/2019.
//  Copyright © 2019 Guillaume Bayle. All rights reserved.
//

import UIKit
import CoreData

class RecetteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet private weak var collectionView: UICollectionView!

    
    override open var shouldAutorotate: Bool {
        return false
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return items.count
        var compte:Int = 0
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recette")
        if  genericClassObject.category == "meat" {
            request.predicate = NSPredicate(format: "category = %@", "meat")
        }
        if  genericClassObject.category == "dessert" {
            request.predicate = NSPredicate(format: "category = %@", "dessert")
        }
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                compte = results.count
                //print(compte)  //debug
            }
        } catch  {
            
        }
        return compte
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recette")
        
        if  genericClassObject.category == "meat" {
            request.predicate = NSPredicate(format: "category = %@", "meat")
        }
        if  genericClassObject.category == "dessert" {
            request.predicate = NSPredicate(format: "category = %@", "dessert")
        }
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        //request.predicate = NSPredicate(format: "name = %@", "Burger")
        request.returnsObjectsAsFaults = false
        
        
        let dbreturn = fetchAllData()
        cell.cellLabel.text = dbreturn[indexPath.item].name
        if let image =  dbreturn[indexPath.item].image as NSData? {
            cell.cellImage.image = UIImage(data:image as Data)
        }
        cell.cellID = Int(dbreturn[indexPath.item].id)
        //cell.cellImage.image = recetteImages[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        //loadDb()   //exécuter cette instruction quand on veut mettre à jour la BD
        
        //sortMoiTout()
        //fetchAllData()
        //let dbrecettes = fetchAllData()
        
        
        let width = (view.frame.size.width - 10) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    
    
    
    func loadDb() {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recette")
        
        request.returnsObjectsAsFaults = false
        
        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object as! NSManagedObject)
            }
        }
        
        
        let newRecette1 = NSEntityDescription.insertNewObject(forEntityName: "Recette", into: context)
        setNewRecette(recette: newRecette1, id: 1, name: "Burger Du Sale", imageName: "burgerDuSale", longdesc: "Un bon gros fat burger sa mère qui déchire !\nPour cette recette, vous aurez besoin :\n - 4 grands pains à burgers\n - 8 steak bien saignants\n - 500g de fromage à raclette\n - 3 feuilles de salade\n - 2 cornichons entiers\n\nINSTRUCTIONS - pour 1 burger\nToaster légèrement les pains à burger, au toaster, poêle ou au four.\nFaire griller les steaks en pensant à mettre une quantité non négligeable de beurre si possible.\nCréer une tour de pise avec tous les ingrédients dans l’ordre désiré. \nEnfoncer un pic à brochette dans la tour pour ne pas qu’elle s’effondre (ça serait dommage)\nPasser le tout rapidement au four pour que le fromage fonde et que les saveurs se mélangent. Deux ou trois minutes à 180° devraient amplement suffire. \nServir chaud, avec un demi kilo de frites à la graisse de boeuf, et une petite salade verte pour la bonne conscience.", category: "meat")
        
        
        let newRecette2 = NSEntityDescription.insertNewObject(forEntityName: "Recette", into: context)
        setNewRecette(recette: newRecette2, id: 2, name: "Mega Cinnamon Roll", imageName: "cinnamonRoll", longdesc: "INGREDIENTS\nFOR THE CAKE\nNonstick cooking spray, for the pan\n3 tubes crescent dough sheets\n1/2 c. butter, melted\n1/2 c. cinnamon-sugar\nFOR THE FROSTING\n1/2 c. butter, softened\n4 oz. cream cheese, softened\n1 1/2 c. powdered sugar\n1 tsp. vanilla extract\n1/4 c. milk or heavy cream\n \nDIRECTIONS\nPreheat oven to 350° and grease an 8” skillet with cooking spray. On a lightly floured surface, unroll one tube of crescent dough. Brush with melted butter and sprinkle with cinnamon-sugar. Cut dough in half lengthwise, then roll each section from long end to long end (to make a rope.) Repeat with remaining tubes of crescent dough.\nRoll up one piece to make a spiral and place in the middle of the pan. Then lay the remaining pieces around the center spiral to form concentric circles. Bake until golden, about 30 minutes. (If the crescents are browning too quickly, tent the skillet with foil.) Let cool for at least 10 minutes. \nMeanwhile make frosting: In a large bowl, combine butter and cream cheese and beat until light and fluffy. Add powdered sugar and vanilla and beat until smooth. Gradually add milk (or heavy cream) to loosen the icing if necessary. \nDrizzle frosting onto cake and spread. Slice into wedges and serve warm.\n\n", category: "dessert")
        
        let newRecette3 = NSEntityDescription.insertNewObject(forEntityName: "Recette", into: context)
        setNewRecette(recette: newRecette3, id: 3, name: "Giant Pizza Bagel", imageName: "pizzaBagel", longdesc: "INGREDIENTS\nCooking spray, for pan\n2 (11-oz.) tubes refrigerated bread dough\n2 c. pizza sauce\n2 c. mozzarella\n1/2 c. mini pepperoni\n1 tsp. oregano\n1 tbsp. Chopped parsley, for garnish\n \nDIRECTIONS\nPreheat oven to 350°. Grease a bundt pan with cooking spray. Place bread dough into the bottom of the pan and pinch all ends together to form a single ring. Bake until golden brown and cooked through, about 25-30 minutes. Let cool for 5 minutes, then invert onto cooling rack to cool completely.\nWhen bread is cool, slice in half lengthwise. Spread pizza sauce evenly on cut side of bread, then top with cheese and pepperoni. Season with oregano and bake until cheese is melty and pepperoni are crisp, 12 to 15 minutes. If desired, switch oven to broil and cook 2 minutes more.\nGarnish pizza bagel with parsley, slice and serve.", category: "meat")
        
        let newRecette4 = NSEntityDescription.insertNewObject(forEntityName: "Recette", into: context)
        setNewRecette(recette: newRecette4, id: 4, name: "Ultimate Grilled Cheese", imageName: "grilledCheese", longdesc: "INGREDIENTS\n2 11-oz. tubes refrigerated french bread dough\n1/2 lb. bacon\n4 c. shredded Cheddar\n2 tbsp. melted butter\n2 cloves garlic, minced\n1/4 c. freshly grated Parmesan\n1 tbsp. chopped parsley\nTomato soup, for serving\n \nDIRECTIONS\nPreheat oven to 350°. Grease a Bundt pan with cooking spray. \nPlace bread dough into the bottom of the pan and pinch all ends together to form a single ring. Bake until golden brown and cooked through, 25 to 30 minutes. Let cool for 5 minutes, then invert onto cooling rack to cool completely.\nMeanwhile, cook bacon in a large skillet over medium heat until crispy. Drain slices on paper towels. \nSlice baked bread in half. On a large baking sheet, place one half cut side-down and the other cut side-up. Top the cut side-up bottom half with cheese and bacon. Brush the other half with melted butter and sprinkle with garlic, Parmesan and parsley. \nBake until the cheese is melted, 3 to 5 minutes.\nPlace the garlicky half of the bread on top of the melted cheese and bacon. Slice into wedges and serve warm with a bowl of warm tomato soup in the middle for dunking.", category: "meat")
        
        let newRecette5 = NSEntityDescription.insertNewObject(forEntityName: "Recette", into: context)
        setNewRecette(recette: newRecette5, id: 5, name: "Oreo XXL Cake", imageName: "oreoCake", longdesc: "INGREDIENTS\nFOR THE COOKIE LAYERS\n2 1/2 c. all-purpose flour\n2 c. granulated sugar\n1 c. brown sugar\n1 c. dark cocoa powder\n2 tsp. baking soda\n1/2 tsp. baking powder\n1/2 tsp. kosher salt\n1 c. butter, softened\n2 large eggs\nFOR THE FILLING\n1/2 c. butter, softened\n1/2 c. vegetable shortening\n2 tsp. pure vanilla extract\n4 c. powdered sugar\n \nDIRECTIONS\nPreheat oven to 350°. Line two 8” round cake pans with parchment paper and spray with cooking spray.\nIn a large bowl, combine flour, sugars, cocoa powder, baking soda, baking powder, and salt and whisk until thoroughly combined. Add butter and mix with a hand mixer on low speed until the dough starts to come together in a mass. Add eggs and mix until thoroughly combined. The mixture should feel sandy.\nPress dough into prepared baking pans, then press a large fork around the edges of the cookie to make indentations similar to Oreos. Bake until cookies are slightly crackly on top, about 20 minutes. Let cool in pan for 10 minutes before inverting onto cooling racks to cool completely. \nMeanwhile, make filling: In a large bowl, combine butter, vegetable shortening, and vanilla. Beat with a hand mixer until smooth and fluffy. Gradually add sugar, about 1 cup at a time, and mix until smooth. \nGather filling into a large ball then, on a piece of parchment paper, pat it into a large disc approximately 8 inches in diameter. \nTransfer one of the cookie layers to a serving dish. (Save the prettier of the two for the top layer.) Place filling on top of cooled cookie then top with remaining cookie, indentation side-up. Slice into wedges and serve with milk.", category: "dessert")
        
        
        do {
            try context.save()
            print("Context saved")
        } catch  {
            print("erreur, impossible de sauvegarder")
        }
    }
    
    
    
   func setNewRecette(recette: NSManagedObject, id: Int16, name: String, imageName: String, longdesc: String, category: String) {
    recette.setValue(name, forKey: "name")
    recette.setValue(id, forKey: "id")
    recette.setValue(category, forKey: "category")
    let imageTemp = UIImage(named: imageName)!.pngData() as NSData?
    recette.setValue(imageTemp, forKey: "image")
    recette.setValue(false, forKey: "favorite")
    recette.setValue(longdesc, forKey: "longdesc")
    
    
    
    }
    
    
    
    func fetchAllData() -> [Recette] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recette")
        if  genericClassObject.category == "meat" {
            request.predicate = NSPredicate(format: "category = %@", "meat")
        }
        if  genericClassObject.category == "dessert" {
            request.predicate = NSPredicate(format: "category = %@", "dessert")
        }
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        //request.predicate = NSPredicate(format: "name = %@", "Burger")
        request.returnsObjectsAsFaults = false
        
        var recettes  = [Recette]() // Where Locations = your NSManaged Class
        
        do{
            recettes =  try context.fetch(request) as! [Recette]
            
            
        } catch {
            
        }
        // Then you can use your properties.
        
        return recettes
    }
    

}
