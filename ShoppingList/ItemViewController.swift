//
//  ItemViewController.swift
//  ShoppingList
//
//  Created by Liubov Kaper  on 11/24/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    
    @IBOutlet weak var newItemTextField: UITextField!
    
    var grocery: Grocery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grocery = Grocery(name: "new item", quantity: 0.5, unit: "pound", purchased: false)
        
        newItemTextField.delegate = self
        
    }

}

extension ItemViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        grocery?.name = textField.text ?? "no new item"
        
        return true
    }
}
