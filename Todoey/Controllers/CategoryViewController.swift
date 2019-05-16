//
//  CategoryViewController.swift
//  Todoey
//
//  Created by vishala3 on 16/05/19.
//  Copyright © 2019 vishala3. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [ItemCategory]()
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Cateogories.plist")
//
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //  print(dataFilePath)

        let request: NSFetchRequest<ItemCategory> = ItemCategory.fetchRequest()
        loadCategories(with: request)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        // Configure the cell’s contents.
        cell.textLabel!.text = categoryArray[indexPath.row].name
        
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController.init(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default){ (action) in
            print(textField.text)
            
            
            
            let newCategory  = ItemCategory(context: self.context)
            
            newCategory.name = textField.text ?? "new Category"
            
            self.categoryArray.append(newCategory)
            
            // self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveCategory()
            
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
            print("Now")
            //      print(alertTextField.text)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategory(){
        
        do{
            try context.save()
        }catch{
            print("Error saving context,\(error)")
        }
        self.tableView.reloadData()
    }
    
    // Load categories
    func loadCategories(with request : NSFetchRequest<ItemCategory>){
        
        do{
            categoryArray =  try context.fetch(request)
        }catch{
            print("Error fetching context,\(error)")
        }
        
        tableView.reloadData()
        
    }
}
