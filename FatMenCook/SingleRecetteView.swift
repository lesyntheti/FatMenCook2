//
//  SingleRecetteView.swift
//  FatMenCook
//
//  Created by Guillaume Bayle on 26/12/2019.
//  Copyright © 2019 Guillaume Bayle. All rights reserved.
//

import UIKit
import CoreData

class SingleRecetteView: UIViewController {

    var favoriteBool = false
    
    @IBOutlet weak var singleRecipeImage: UIImageView!
    
    @IBOutlet weak var singleRecipeName: UILabel!
    
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var singleRecipeDescription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let dbReturnRecipe = fetchRecipeData()
        
        self.singleRecipeName.text = dbReturnRecipe[0].name
        self.singleRecipeDescription.text = dbReturnRecipe[0].longdesc
        
        if let image =  dbReturnRecipe[0].image as NSData? {
            self.singleRecipeImage.image = UIImage(data:image as Data)
        }
        
        if dbReturnRecipe[0].favorite == true {
            self.heartButton.setImage(UIImage(named:"heartFull"), for: .normal)
        }
        
        print ("favorite : ")
        print(dbReturnRecipe[0].favorite)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func fetchRecipeData() -> [Recette] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recette")
        
        let idFiltre: String = String(genericClassObject.currentRecipeID)
        //filtrage de la requête
        request.predicate = NSPredicate(format: "id = %@", idFiltre)
        
        
        request.returnsObjectsAsFaults = false
        
        var recettes  = [Recette]() // Where Locations = your NSManaged Class
        
        do{
            recettes =  try context.fetch(request) as! [Recette]
            favoriteBool = recettes[0].favorite
            
            
        } catch {
            
        }
        // Then you can use your properties.
        
        return recettes
    }
    
    
    @IBAction func tickFavorites(_ sender: UIButton) {
        
        print("button clicked")
        
        
        if favoriteBool == false  {
            print ("favoriteBool false to true")
            sender.setImage(UIImage(named:"heartFull"), for: .normal)
            favoriteBool = true
            print(favoriteBool)
            
            
            
            //code to add to favorites, change bool value
            toggleFavorite()
            
            
            /*
            var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            var context: NSManagedObjectContext = appDel.managedObjectContext!
            
            var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginData")
            fetchRequest.predicate = NSPredicate(format: "userName = %@", userName)
            
            if let fetchResults = appDel.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    var managedObject = fetchResults[0]
                    managedObject.setValue(accessToken, forKey: "accessToken")
                    
                    context.save(nil)
                }
            }
            */
        }
        else {
            sender.setImage( UIImage(named:"heartEmpty"), for: .normal)
            print ("favoriteBool = true to false")
            favoriteBool = false
            print(favoriteBool)
            
            //change the bull value to remove from favorites
            toggleFavorite()
        }
    }
    
    
    func toggleFavorite() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requestFav = NSFetchRequest<NSFetchRequestResult>(entityName: "Recette")
        
        let idFiltre: String = String(genericClassObject.currentRecipeID)
        //filtrage de la requête
        requestFav.predicate = NSPredicate(format: "id = %@", idFiltre)
        
        var recetteFav = [Recette]()
        var recetteFavNS = [NSManagedObject]()
        
        
        do{
            recetteFav =  try context.fetch(requestFav) as! [Recette]
            recetteFavNS = try context.fetch(requestFav) as! [NSManagedObject]
            
            if recetteFav[0].favorite == false {
                recetteFavNS[0].setValue(true, forKey: "favorite")
                print("mis en favoris")
            } else {
                recetteFavNS[0].setValue(false, forKey: "favorite")
                print("retiré des favoris favoris")
            }
            
            
            
            
        } catch {
            
        }
        
        do {
            try context.save()
            print("context saved")
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

