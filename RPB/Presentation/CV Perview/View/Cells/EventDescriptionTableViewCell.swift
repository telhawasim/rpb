//
//  EventDescriptionTableViewCell.swift
//  TicketLakeConsumer
//
//  Created by Aqsa Arshad on 15/06/2019.
//  Copyright © 2019 Aqsa Arshad. All rights reserved.
//

import UIKit

protocol EventDescriptionDelegate {
    func didChangeExpantion(index: Int, isExpanded: Bool)
}

class EventDescriptionTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var lblDescriptionHeading: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var readMoreHeight: NSLayoutConstraint!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var lblPerviousCompany: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var middleConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblExperience: UILabel!
    @IBOutlet weak var lblRoleDescription: UILabel!
    @IBOutlet weak var roleDescriptionConstraint: NSLayoutConstraint!
    
    //MARK: Variables
    var isExpanded = false
    var delegate: EventDescriptionDelegate?
    var index: Int!
    
    //MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        eventDescription.setLineSpacing()
        self.setColors()
        self.configureFonts()
    }
    
    func configure(_ readMore: ReadMoreModel, index: Int) {
        self.index = index
        self.isExpanded = readMore.isExpanded
        self.lblDescriptionHeading.text = readMore.description
        self.lblPerviousCompany.text = readMore.perviousCompany
        self.readMoreButton.tag = readMore.tag 
        self.readMoreButton.setTitle(isExpanded ? "Read Less" : "Read More", for: .normal)

        if readMoreButton.tag == 1 {
            self.lblPerviousCompany.isHidden = true
        } else {
            self.lblPerviousCompany.isHidden = false
        }
        self.lblRoleDescription.isHidden = true
        self.roleDescriptionConstraint.constant = 0
    }

    // MARK: Colors
    func setColors() {
        lblDescriptionHeading.textColor = UIColor.black
        eventDescription.textColor = UIColor.black
    }
    
    // MARK: Fonts
    func configureFonts() {
        lblDescriptionHeading.font = UIFont.getSemiBoldFont(size: 18)
        lblPerviousCompany.font = UIFont.getMediumFont(size: 14)
        lblExperience.font = UIFont.getRegularFont14()
        eventDescription.font = UIFont.getRegularFont14()
        lblRoleDescription.font = UIFont.getSemiBoldFont(size: 18)
    }
    
    func updateUI(description: BasicInfoResponse?, noOfLines: Int = 3, headingFontSize: CGFloat = 15,topMargin: CGFloat = 0, bottomMargin: CGFloat = 8) {
        self.setDescriptionText(textString: description?.basicInfoSummary ?? "")
        eventDescription.setLineSpacing()
        if (isExpanded) {
            eventDescription.numberOfLines = 0
        } else {
            eventDescription.numberOfLines = noOfLines
        }
        eventDescription.adjustsFontSizeToFitWidth = false
        eventDescription.lineBreakMode = .byTruncatingTail
        //lblDescriptionHeading.text = "Summary"
        
        if (eventDescription.maxNumberOfLines > 3) {
            readMoreButton.isHidden = false
            readMoreHeight.constant = 30
            bottomConstraint.constant = 0
        } else {
            readMoreButton.isHidden = true
            readMoreHeight.constant = 0
            bottomConstraint.constant = 18.5
        }
    }
    
    func updateExperiencesUI(description: Experience?, tag: Int, noOfLines: Int = 3,headingFontSize: CGFloat = 15, topMargin: CGFloat = 0, bottomMargin: CGFloat = 8) {
        
        self.setDescriptionText(textString: description?.jobDescription ?? "")
        eventDescription.setLineSpacing()
        if (isExpanded) {
            eventDescription.numberOfLines = 0
        } else {
            eventDescription.numberOfLines = noOfLines
        }
        eventDescription.adjustsFontSizeToFitWidth = false
        eventDescription.lineBreakMode = .byTruncatingTail
        
        if description?.jobDescription != "" {
            self.lblRoleDescription.isHidden = false
            self.roleDescriptionConstraint.constant = 20
        } else {
            self.lblRoleDescription.isHidden = true
            self.roleDescriptionConstraint.constant = 0
        }

        if (eventDescription.maxNumberOfLines > 3) {
            readMoreButton.isHidden = false
            readMoreHeight.constant = 30
            bottomConstraint.constant = 0
        } else {
            readMoreButton.isHidden = true
            readMoreHeight.constant = 0
            bottomConstraint.constant = 18.5
        }
        self.lblDescriptionHeading.text = description?.designation ?? ""
        self.lblPerviousCompany.text = description?.companyName ?? ""
        self.lblPerviousCompany.isHidden = false
        if tag == 0 {
            self.lblExperience.text = "\(description?.startsFrom?.convertDateToMMM_YYYY() ?? "") - Present"
        } else {
            self.lblExperience.text = "\(description?.startsFrom?.convertDateToMMM_YYYY() ?? "") - \(description?.endsTo?.convertDateToMMM_YYYY() ?? "")"
        }
    }
    
    func setDescriptionText(textString: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        paragraphStyle.lineSpacing = 2.0
        paragraphStyle.lineHeightMultiple = 0.0
        paragraphStyle.hyphenationFactor = 1.0
        
        let attributedString = NSAttributedString(string: textString,
                                                  attributes: [
                                                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                    NSAttributedString.Key.baselineOffset: NSNumber(value: 0)
                                                  ])
        self.eventDescription.attributedText = attributedString
    }
    
    @IBAction func readMoreButtonPressed(_ sender: UIButton) {
        self.isExpanded.toggle()
        self.delegate?.didChangeExpantion(index: self.readMoreButton.tag, isExpanded: self.isExpanded)
    }
}

extension UILabel {
    var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font!],
            context: nil).size
        return labelTextSize.height > bounds.size.height
    }
}

extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font!], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
