//
//  intaController.swift
//  bernat.segura_oscar.julian
//
//  Created by Alumne on 29/10/2021.
//

import Foundation
import UIKit

class instaController: UIViewController {
    @IBOutlet weak var perfilPic: UIImageView!
    
    @IBOutlet weak var lblLikes: UILabel!
    //Like icon
    @IBOutlet weak var heart: UIImageView!
    
    //Flag que ens diu si aquest usuari li ha donat laik o no a la foto
    var liked = false;
    //Numlikes
    var likes : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        perfilPic.layer.cornerRadius = perfilPic.frame.height / 2
    }
    
    @IBAction func fotoDoubleTap(_ sender: Any) {
        likeOnOff()
    }

    @IBAction func hearthTap(_ sender: Any) {
        likeOnOff()
    }
    
    @IBAction func commentTap(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "FUNCIONALIDAD NO IMPLEMENTADA", message: "", preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) -> Void in
        })
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    func likeOnOff() {
        if liked {
            heart.image = UIImage(systemName: "heart")
            likes = likes - 1
        } else {
            likes = likes + 1
            heart.image = UIImage(systemName: "heart.fill")
        }
        lblLikes.text = "Likes \(likes)"
        liked = !liked
    }
    
}
