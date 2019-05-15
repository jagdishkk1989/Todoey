//
//  ViewController.swift
//  Todoey
//
//  Created by vishala3 on 14/05/19.
//  Copyright © 2019 vishala3. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos","Destroy Demogram"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        // Configure the cell’s contents.
        cell.textLabel!.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //  Tells the delegate that a specified row is about to be selected.
    
//    override func tableView(_: UITableView, willSelectRowAt: IndexPath) -> IndexPath? {
//
//    }
//
    //  Tells the delegate that the specified row is now selected.
    
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath){
        print(itemArray[indexPath.row])
        
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Tells the delegate that a specified row is about to be deselected.
    
//    override func tableView(_: UITableView, willDeselectRowAt: IndexPath) -> IndexPath?{
//
//    }
    
    //  Tells the delegate that the specified row is now deselected.

//    override func tableView(_: UITableView, didDeselectRowAt: IndexPath){
//
//    }
    
  }

