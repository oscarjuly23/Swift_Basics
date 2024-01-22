//
//  ViewController.swift
//  bernat.segura_oscar.julian
//
//  Created by Alumne on 25/10/2021.
//

import UIKit

class ViewController: UIViewController {

 
    
    var newTaskCreated : (_ newTask: String) -> Void = {arg in}
    

    @IBOutlet weak var textInputTask: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func readingText(_ sender: Any) {
        newTaskCreated(textInputTask.text!)
        dismiss(animated: true, completion: nil)
        
    }
    
}

