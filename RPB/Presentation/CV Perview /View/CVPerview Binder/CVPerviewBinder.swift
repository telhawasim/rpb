//
//  CVPerviewBinder.swift
//  RPB
//
//  Created by Bilal Nisar on 31/01/2023.
//

import Foundation

class CVPerviewBinder: NSObject {
    
    //MARK: IBOutlets
    weak var lblViewProfile: UILabel?
    weak var lblName: UILabel?
    weak var btnEdit: UIButton?
    weak var btnDownload: UIButton?
    weak var tableView: UITableView?
    
    //MARK: Initialation
    init(lblViewProfile: UILabel, lblName: UILabel, btnEdit: UIButton, btnDownload: UIButton, tableView: UITableView) {
        self.lblViewProfile = lblViewProfile
        self.lblName = lblName
        self.btnEdit = btnEdit
        self.btnDownload = btnDownload
        self.tableView = tableView
    }
    
    
}
