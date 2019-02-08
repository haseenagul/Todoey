//
//  ViewController.swift
//  Todoey
//
//  Created by Haseena Gul on 08/02/2019.
//  Copyright © 2019 lecture. All rights reserved.
//

import UIKit

class TodolistTableViewController: UITableViewController {

    let itemArray = ["Buy eggs","Buy bread","Go to office"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    }
    
    



