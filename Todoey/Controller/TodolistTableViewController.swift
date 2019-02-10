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
    var itemArray = [item]()
    
    // save costom data type of users in file directory.
    //FileManager is create object for files, and default share and return that files and objects.
    // userDomainMask is s home directory to install your personal data.
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.Plist")
    
    
   
// we use user default for storing the data back when app terminate.
   // let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(dataFilePath!)
        
        
        
        
        
//    // iniliaze new object of class.
//        let newItem = item()
//        newItem.title = "Buy eggs"
//        itemArray.append(newItem)
//
//        let newItem1 = item()
//        newItem1.title = "Buy Milk"
//        itemArray.append(newItem1)
//
//        let newItem2 = item()
//        newItem2.title = "Buy pamper"
//        itemArray.append(newItem2)
        
        loadItems()
        
        //Retrive the user data and its a costom data type (item)
     //  if let  items =   defaults.array(forKey: "TodoListArray") as? [item]{
        //    itemArray = items
        //}
        
        
    }
        
        
        
        
        
    
    
// Mark - TableView Datasourse methods.
    
    //First add number of row in table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return itemArray.count
    }
    
    
    // ask the Datasourse to insert particuler data in parituler location in tableView.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
   
       
       // reuse the cells with indexpath
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        // when user add new item its store in array  and user can check and uncheck that item.
        cell.textLabel?.text = item.title
        
        
        
        
        // Ternery Operator.
        // value = condition ? valueIfTrue : valueIfFalse.
        // both lines of code are working same .
        cell.accessoryType = item.done  ? .checkmark : .none
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else{
//           cell.accessoryType = .none
//        }
        
        
        return cell
        
    }
    
    // Mark - TableView Delegate Method.
    // when user click on cell it will be check ✅ or unchecked.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print(itemArray[indexPath.row])
         // for user check or uncheck the item in tableview
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        
       
        //data reloaded with user enter new data
        //tableView.reloadData()
        
        
        
        // when user select row it will show a check mark and user again click row it will be uncheck.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // MARK - add button to add item.
    
    
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
    // pop up alert with title and message.
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add new item", style: .default) { (action) in
            
            
        // what will happen when user click add button on our alert.
            let newItem = item()
            newItem.title = textField.text!
            
        // append add new user data
      self.itemArray.append(newItem)
            
            
            // call the savefunction
            self.saveItems()
            
        
        }
        
        // now add textField in alert which user enter their item
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
          
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
// MARK - Model manupulation Methods.
func saveItems (){
    
    // data save in array when app again launching and its reterive the costom data from costom plist.
    let encoder = PropertyListEncoder()
    
    do{
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
    } catch{
        print("Error encoding item array, \(error)")
    }
        // Reload the data in table view.
       self.tableView.reloadData()
    
}
    func loadItems(){
        if let data =  try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([item].self, from: data)
            }
            catch{
                print("Error encoding item array,\(error)")
            
        }
        }
        
    }



}
