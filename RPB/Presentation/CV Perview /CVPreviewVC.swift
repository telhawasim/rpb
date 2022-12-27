//
//  CVPreviewVC.swift
//  RPB
//
//  Created by Bilal Nisar on 27/12/2022.
//

import UIKit

class CVPreviewVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var softSkillCollectionView: UICollectionView!
    @IBOutlet weak var hardSkillCollectionView: UICollectionView!
    
    //MARK: Variables
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
    }
    
    //MARK: Register Cell
    func registerCell() {
        softSkillCollectionView.delegate = self
        softSkillCollectionView.dataSource = self
        softSkillCollectionView.register(TagsCollectionViewCell.className)
        hardSkillCollectionView.delegate = self
        hardSkillCollectionView.dataSource = self
        hardSkillCollectionView.register(TagsCollectionViewCell.className)
    }
}

extension CVPreviewVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == softSkillCollectionView{
            return 3
        }else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == softSkillCollectionView {
            let cell = softSkillCollectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.className, for: indexPath) as! TagsCollectionViewCell
            return cell
        }else{
            let cell = hardSkillCollectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.className, for: indexPath) as! TagsCollectionViewCell
            return cell
        }
    }
}




