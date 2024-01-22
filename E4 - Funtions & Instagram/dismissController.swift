//
//  dismissController.swift
//  bernat.segura_oscar.julian
//
//  Created by Alumne on 26/10/2021.
//

import Foundation
import UIKit

class  dismissController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

