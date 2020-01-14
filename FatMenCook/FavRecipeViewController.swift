//
//  FavRecipeViewController.swift
//  FatMenCook
//
//  Created by Guillaume Bayle on 01/01/2020.
//  Copyright © 2020 Guillaume Bayle. All rights reserved.
//



import UIKit
import CoreData

class FavRecipeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
        
        
        request.predicate = NSPredicate(format: "favorite == %@", NSNumber(booleanLiteral: true))
        
        
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
        
        request.predicate = NSPredicate(format: "favorite == %@", NSNumber(booleanLiteral: true))
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
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("reloading list")
        collectionView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let width = (view.frame.size.width - 10) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    

    
    
    func fetchAllData() -> [Recette] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recette")
        request.predicate = NSPredicate(format: "favorite == %@", NSNumber(booleanLiteral: true))
        
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
