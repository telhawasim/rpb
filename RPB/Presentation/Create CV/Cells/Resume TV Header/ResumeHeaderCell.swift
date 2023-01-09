//
//  ResumeHeaderCell.swift
//  RPB
//
//  Created by Telha Wasim on 26/12/2022.
//

import UIKit

class ResumeHeaderCell: UITableViewHeaderFooterView {
    
    //MARK: Outlet
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnaddMoreCell: UIButton!
    
    //MARK: Variables
    var addMore: (() -> Void)?
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
        self.configureLabel()
    }
    
    //MARK: Configure
    func configureView() {
        self.headerView.backgroundColor = UIColor.blueF1F1FF
        self.headerView.cornerRadius(10)
    }
    
    func configureLabel() {
        self.lblHeading.font = UIFont.montserratMedium(20)
    }
    
    @IBAction func tappedAddMoreCell(_ sender: Any) {
        self.addMore?()
    }
}
