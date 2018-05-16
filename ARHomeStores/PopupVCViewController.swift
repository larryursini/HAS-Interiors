//
//  PopupVCViewController.swift
//  ARHomeStores
//
//  Created by Larry Ursini on 5/15/18.
//  Copyright © 2018 Gabriel Abraham. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PopupVCViewController: UIViewController {

    var chosenNode = SCNNode()
    let myItem  = ItemList()
    
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10
        
        popupView.layer.masksToBounds = true

    }

    
    @IBAction func closePopup(_ sender: Any) {
        
        chosenNode = myItem.addChair()
        
       
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
