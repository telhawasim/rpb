//
//  AddMoreTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 16/03/2023.
//

import UIKit

class AddMoreTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var btnAdd: UIButton!
    
    //MARK: Variables
    var addMore: (() -> Void)?
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureButton()
    }
    
    //MARK: Configure Buttons
    func configureButton() {
        self.btnAdd.tintColor = UIColor.appColor
        self.btnAdd.cornerRadius(22)
        self.btnAdd.backgroundColor = UIColor.blueE2E3FF
    }
    
    @IBAction func addMorePressed(_ sender: Any) {
        self.addMore?()
    }
    
}
