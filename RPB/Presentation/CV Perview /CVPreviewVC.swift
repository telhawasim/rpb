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
    @IBOutlet weak var lblViewProfile: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSkill: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblEducation: UILabel!
    @IBOutlet weak var lblMasterDegreeText: UILabel!
    @IBOutlet weak var lblMasterDegree: UILabel!
    @IBOutlet weak var lblMasterSession: UILabel!
    @IBOutlet weak var lblBachelorsDegreeText: UILabel!
    @IBOutlet weak var lblBachelorDegree: UILabel!
    @IBOutlet weak var lblBachelorSession: UILabel!
    @IBOutlet weak var lblSkillsText: UILabel!
    @IBOutlet weak var lblSoftSkillsText: UILabel!
    @IBOutlet weak var lblHardSkillsText: UILabel!
    @IBOutlet weak var lblExperienceText: UILabel!
    @IBOutlet weak var lblSkillText: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblExperience: UILabel!
    @IBOutlet weak var lblUIDesignerSession: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var lblPhone: UILabel!
    
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

extension CVPreviewVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == softSkillCollectionView {
            return 3
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == softSkillCollectionView {
            let cell = softSkillCollectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.className, for: indexPath) as! TagsCollectionViewCell
            return cell
        } else {
            let cell = hardSkillCollectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.className, for: indexPath) as! TagsCollectionViewCell
            return cell
        }
    }
}
