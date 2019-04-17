//
//  DetailViewController.swift
//  MemeMe1.0
//
//  Created by Yar Sher on 4/17/19.
//  Copyright © 2019 Yar Sher. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailedImage: UIImageView!
    
    var memes: Meme!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailedImage.image = memes.memedImage
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
}
