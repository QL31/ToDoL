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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    //["Find toillet paper","Buy Spaguetti","Buy water"]
    
    // let defauts = UserDefaults.standard
    
    
    //print(dataFilePath
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//
//        let item1=Item()
//        item1.title="Find toillet paper"
//        itemArray.append(item1)
//
//        let item2=Item()
//        item2.title="Buy spaquettiiiiii"
//        itemArray.append(item2)
//        let item3=Item()
//        item3.title="Stay at Home"
//        itemArray.append(item3)
        
        loadItem()
        
        //        if let item=defauts.array(forKey: "TodoListArray") as? [Item]{
        //            itemArray=item
        //        }
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
        
        saveItem()
        
        //tableView.reloadData()
        
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
            //self.defauts.set(self.itemArray, forKey: "TodoListArray")
            self.saveItem()
            
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder="Creat new item"
            textfield=alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItem(){
        
        let encoder=PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch{
            
            print("Error encoding item array ,\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadItem(){
        
        if let data=try? Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
            
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("error decoding item array,\(error)")
            }
            
        }
    }
    
    
    
}

