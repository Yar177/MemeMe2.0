//
//  CollectionViewController.swift
//  MemeMe1.0
//
//  Created by Yar Sher on 4/17/19.
//  Copyright © 2019 Yar Sher. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayoutSize()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        showBars()
    }
    
    
    func showBars(){
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func setLayoutSize(){
        let minSpace:CGFloat = 3.0
        let area = (view.frame.size.width - (2 * minSpace)) / 3.0
        
        flowLayout.minimumInteritemSpacing = minSpace
        flowLayout.minimumLineSpacing = minSpace
        flowLayout.itemSize = CGSize(width: area, height: area)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.memes!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell" , for: indexPath)as! CollectionViewCell
        cell.cellImage.image = self.memes![(indexPath as NSIndexPath).row].memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailController.memes = self.memes![(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
      
    
    
}
