//
//  ViewController.swift
//  Todoey
//
//  Created by vishala3 on 14/05/19.
//  Copyright © 2019 vishala3. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    //let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        print(dataFilePath)
        
        loadItems()

//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//             itemArray = items
//        }
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
        cell.textLabel!.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
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
        
        if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }
        
        saveItems()
       // tableView.reloadData()
        
//        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
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
    
    // Add Todo Item
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController.init(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            print(textField.text)
            
            let newItem = Item()
            newItem.title = textField.text ?? "new Item"
            self.itemArray.append(newItem)
            
           // self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
            
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print("Now")
      //      print(alertTextField.text)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Encoding error,\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
             itemArray = try decoder.decode([Item].self, from:data)
            }
            catch {
                print("Decoding error,\(error)")
                
            }
            
        }
    }
}

