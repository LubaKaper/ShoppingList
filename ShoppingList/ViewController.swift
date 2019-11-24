//
//  ViewController.swift
//  ShoppingList
//
//  Created by Liubov Kaper  on 11/24/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var groceries = [Grocery]()
    
    var editingTableView = false {
        didSet {
            tableView.isEditing = editingTableView
            navigationItem.leftBarButtonItem?.title = editingTableView ? "Done" : "Edit"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    @IBAction func addNewGrocery(segue: UIStoryboardSegue) {
        guard let itemViewController = segue.source as? ItemViewController, let createdGrocery = itemViewController.grocery else {
            fatalError("failed to access ItemViewController")
        }
        groceries.insert(createdGrocery, at: 0)
        let indexView = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexView], with: .automatic)
    }
    
    @IBAction func edirListButton(_ sender: UIBarButtonItem) {
        editingTableView.toggle()
    }
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groceries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        let grocery = groceries[indexPath.row]
        cell.textLabel?.text = grocery.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            print("inserting")
        case .delete:
            groceries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            print("...")
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let groceryToMove = groceries[sourceIndexPath.row]
        groceries.remove(at: sourceIndexPath.row)
        groceries.insert(groceryToMove, at: destinationIndexPath.row)
    }
}

