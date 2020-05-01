//
//  CategorieTableViewController.swift
//  ToDoL
//
//  Created by li qinglian on 30/04/2020.
//  Copyright © 2020 li qinglian. All rights reserved.
//

import UIKit

import CoreData

class CategorieTableViewController: UITableViewController {

    var categorieArray = [Categorie]()

    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadCategorie()

    }
    
    //MARK: TableView source method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categorieArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieCell", for: indexPath)
        
        cell.textLabel?.text = categorieArray[indexPath.row].name
        
        return cell
    }
    
    
    //MARK:tableview delegate method
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.seletedGategoris = categorieArray[indexPath.row]
        }
        
    }
   
    

    
    
    //MARK: add new category
    
   
    @IBAction func addCateforie(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new categorie", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add cagegorie", style: .default) { (action) in
            
            let categoie = Categorie(context: self.context)
            
            categoie.name = textField.text!
            
            self.categorieArray.append(categoie)
            
            self.saveCategorie()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            
            textField = alertTextField
            
            alertTextField.placeholder = "Creat a new categorie"
            
        }
        
        present(alert, animated: true, completion: nil)
       
    }
    
    //MARK:data manipulation method
    
    func saveCategorie(){
        
        do{
            try self.context.save()
        }catch{
           print("Error saving categorie \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategorie(){
        
        let request: NSFetchRequest<Categorie> = Categorie.fetchRequest()
        
        do{
    
                categorieArray = try context.fetch(request)
        }catch{
            
            print("Error fetching data from context \(error) ")
        }
        
        tableView.reloadData()
        
    }
    

}
