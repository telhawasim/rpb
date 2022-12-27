//
//  ProfileVC.swift
//  RPB
//
//  Created by Bilal Nisar on 22/12/2022.
//

import UIKit

class ProfileVC: UIViewController {

    // MARK: Outlet
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var btnAddCV: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var lblProfiles: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: Variables

    // MARK: Lifecylce

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureButtons()
        self.configureFonts()
        self.configureTableView()
    }

    // MARK: Configure TableView
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ProfileTVCell.className)
    }

    // MARK: Configure Buttons
    func configureButtons() {
        self.btnback.isCircularButton()
        self.btnAddCV.isCircularButton()
    }

    // MARK: Configure Fonts
    func configureFonts() {
        self.lblName.font = UIFont.montserratBold(20)
        self.lblDesignation.font = UIFont.montserratMedium(14)
        self.lblEmail.font = UIFont.montserratRegular(16)
        self.lblProfiles.font = UIFont.montserratSemiBold(24)
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

   guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTVCell.className, for: indexPath) as? ProfileTVCell else {
            fatalError("Failed to get expected kind of reusable cell from the tableView. Expected type `ProfileTVCell`")
        }
        return cell
    }
}
