//
//  ProjectsTableViewCell.swift
//  RPB
//
//  Created by Telha Wasim on 17/04/2023.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var lblProjectType: UILabel!
    @IBOutlet weak var lblTechStack: UILabel!
    @IBOutlet weak var lblProjectLink: UILabel!
    @IBOutlet weak var projectImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureProjects(data: ProjectsResponse?) {
        self.lblProjectName.text = data?.projectName ?? ""
        self.lblProjectType.text = data?.projectType ?? ""
        self.lblTechStack.text = data?.projectTechStack ?? ""
        self.lblProjectLink.text = data?.projectLink ?? ""
        self.projectImage.setImageURLElsePlaceHolder(url: data?.projectImage ?? "", placeholder: UIImage.placeHolder)
    }
}
