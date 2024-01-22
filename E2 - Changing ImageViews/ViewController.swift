//
//  ViewController.swift
//  bernat.segura_oscar.julian_Ex2
//
//  Created by Alumne on 15/10/2021.
//

import UIKit
let album:[String] = ["Photo1","Photo2","Photo3","Photo4","Photo5","Photo6"]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var myButton: UIButton!
    @IBAction func clickButton(_ sender: Any) {
        print("Adeu")
        
    }
    
    @IBAction func buttonImage(_ sender: Any) {
        let count = Int.random(in: 0..<6)
        myButton.setImage(UIImage(named: album[count]), for: UIControl.State.normal)
    }
}

