//
//  ViewController.swift
//  Todoey
//
//  Created by Haseena Gul on 08/02/2019.
//  Copyright © 2019 lecture. All rights reserved.
//

import UIKit

class TodolistTableViewController: UITableViewController {
    // array will be mutable means var, because user want to add new item.

    var itemArray = ["Buy eggs","Buy bread","Go to office"]
    
   
// we use user default for storing the data back when app terminate.
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Retrive the user data.
        if let  items =   defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
        
    }
    
// Mark - TableView Datasourse methods.
    
    //First add number of row in table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return itemArray.count
    }
    // ask the Datasourse to insert particuler data in parituler location in tableView.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // reuse the cells with indexpath.
         let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    // Mark - TableView Delegate Method.
    // when user click on cell it will be check ✅ or unchecked.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print(itemArray[indexPath.row])
        
        // when user select row it will show a check mark and user again click row it will be uncheck.
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK - add button to add item.
    
    
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
    // pop up alert with title and message.
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add new item", style: .default) { (action) in
            // what will happen when user click add button on our alert.
            
            // append add new user data
      self.itemArray.append(textField.text!)
            
        // data save in array when app again launching.
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // Reload the data in table view.
            self.tableView.reloadData()
            
        }
        // now add textField in alert which user enter their item
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
          
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    }
    
    



