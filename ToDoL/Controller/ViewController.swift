//
//  ViewController.swift
//  ToDoL
//
//  Created by li qinglian on 27/04/2020.
//  Copyright © 2020 li qinglian. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    
    //["Find toillet paper","Buy Spaguetti","Buy water"]
    
    let defauts = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let item1=Item()
        item1.title="Find toillet paper"
        itemArray.append(item1)
        
        let item2=Item()
        item2.title="Find toillet paper"
        itemArray.append(item2)
        let item3=Item()
        item3.title="Find toillet paper"
        itemArray.append(item3)
        
        
        
        if let item=defauts.array(forKey: "TodoListArray") as? [Item]{
            itemArray=item
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //Ternary operator==>
        //value=condition ? valueIfTrue :valueIfFalse
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        cell.textLabel?.text=itemArray[indexPath.row].title
        
        return cell
    }
    
    //MARK-TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARM --add new Item
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield=UITextField()
        
        let alert=UIAlertController(title: "Add new TodoL Item", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add new Item", style: .default) { (atction) in
            //what will happen when user presse the add new item button
            //print("succes!")
            
            let item=Item()
            item.title=textfield.text!
            self.itemArray.append(item)
            
            //self.itemArray.append(textfield.text!)
            self.defauts.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder="Creat new item"
            textfield=alertTextField
            
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

