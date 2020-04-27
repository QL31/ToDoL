//
//  ViewController.swift
//  ToDoL
//
//  Created by li qinglian on 27/04/2020.
//  Copyright © 2020 li qinglian. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    
    var itemArray=["Find toillet paper","Buy Spaguetti","Buy water"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text=itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK-TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARM --add new Item
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield=UITextField()
        
        let alert=UIAlertController(title: "Add new TodoL Item", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add new Item", style: .default) { (atction) in
            //what will happen when user presse the add new item button
            print("succes!")
            
            self.itemArray.append(textfield.text!)
            
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

