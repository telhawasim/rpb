//
//  EventDescriptionTableViewCell.swift
//  TicketLakeConsumer
//
//  Created by Aqsa Arshad on 15/06/2019.
//  Copyright © 2019 Aqsa Arshad. All rights reserved.
//

import UIKit

protocol UpdateCustomCell {
    func updateTableView(willExpand: Bool)
}

class EventDescriptionTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var lblDescriptionHeading: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var readMoreButton: UIButton!
    
    //MARK: Variables
    var isExpanded = false
    var delegate: UpdateCustomCell?
    
    //MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setTypoGraphy()
        eventDescription.setLineSpacing()
        self.setColors()
        self.configureFonts()
    }
    
    func setTypoGraphy() {
        
    }
    
    // MARK: Colors
    func setColors() {
        lblDescriptionHeading.textColor = UIColor.customBlack
        eventDescription.textColor = UIColor.black
    }

    // MARK: Fonts
    func configureFonts() {
        lblDescriptionHeading.font = UIFont.getRegularFont(size: 23)
        eventDescription.font = UIFont.getCustomFont_Thin()
    }
    
    func updateUI(noOfLines: Int = 3,headingFontSize: CGFloat = 15,topMargin: CGFloat = 0, bottomMargin: CGFloat = 8) {
        self.setDescriptionText(textString: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.")
        eventDescription.setLineSpacing()
        if (isExpanded) {
            eventDescription.numberOfLines = 0
        } else {
            eventDescription.numberOfLines = noOfLines
        }
        eventDescription.adjustsFontSizeToFitWidth = false
        eventDescription.lineBreakMode = .byTruncatingTail
        lblDescriptionHeading.text = "Summary"
        
        if (eventDescription.maxNumberOfLines > 3) {
            readMoreButton.isHidden = false
        } else {
            readMoreButton.isHidden = true
        }
    }
    
    func updateViewEventUI(noOfLines: Int = 3,headingFontSize: CGFloat = 15,topMargin: CGFloat = 0, bottomMargin: CGFloat = 8) {
        self.setDescriptionText(textString: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.")
        eventDescription.setLineSpacing()
        if (isExpanded) {
            eventDescription.numberOfLines = 0
        } else {
            eventDescription.numberOfLines = noOfLines
        }
        eventDescription.adjustsFontSizeToFitWidth = false
        eventDescription.lineBreakMode = .byTruncatingTail
        lblDescriptionHeading.text = "Description"
        
        if (eventDescription.maxNumberOfLines > 3) {
            readMoreButton.isHidden = false
        } else {
            readMoreButton.isHidden = true
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
    
    //    func updateUI(venue : EventVenueDetail, NoOfLines : Int = 3,headingFontSize: CGFloat = 15,topMargin :CGFloat = 0, bottomMargin : CGFloat = 8) {
    //        if(venue.description == nil || venue.description == ""){
    //            lblDescriptionHeading.text = ""
    //        }
    //        self.setDescriptionText(textString: venue.description ?? "")
    ////        eventDescription.setLineSpacing()
    //        if(isExpanded){
    //            eventDescription.numberOfLines = 0
    //        }else{
    //            eventDescription.numberOfLines = NoOfLines
    //        }
    //        eventDescription.adjustsFontSizeToFitWidth = false
    ////        eventDescription.lineBreakMode = .byTruncatingTail
    //        if(eventDescription.maxNumberOfLines > 3)
    //        {
    //            readMoreButton.isHidden = false
    //        }else{
    //            readMoreButton.isHidden = true
    //        }
    //    }
    
    //    func updateUI(event: EventDetailViewModel) {
    //        self.setDescriptionText(textString: event.description ?? "")
    ////        eventDescription.setLineSpacing()
    //        if(isExpanded){
    //            eventDescription.numberOfLines = 0
    //        }else{
    //            eventDescription.numberOfLines = 3
    //        }
    //        eventDescription.adjustsFontSizeToFitWidth = false
    ////        eventDescription.lineBreakMode = .byTruncatingTail
    //
    //        if(eventDescription.maxNumberOfLines > 3)
    //        {
    //            readMoreButton.isHidden = false
    //        }else{
    //            readMoreButton.isHidden = true
    //        }
    //    }
    
    //    func updateUI(newVenue: NewVenue) {
    //        self.setDescriptionText(textString: newVenue.description ?? "")
    ////        eventDescription.setLineSpacing()
    //        if(isExpanded){
    //            eventDescription.numberOfLines = 0
    //        }else{
    //            eventDescription.numberOfLines = 3
    //        }
    //        eventDescription.adjustsFontSizeToFitWidth = false
    ////        eventDescription.lineBreakMode = .byTruncatingTail
    //
    //        if(eventDescription.maxNumberOfLines > 3)
    //        {
    //            readMoreButton.isHidden = false
    //        }else{
    //            readMoreButton.isHidden = true
    //        }
    //    }
    
    
    //    func updateUI(event: VotingEvent) {
    //        self.setDescriptionText(textString: event.description ?? "")
    ////        eventDescription.setLineSpacing()
    //        if(isExpanded){
    //            eventDescription.numberOfLines = 0
    //        }else{
    //            eventDescription.numberOfLines = 3
    //        }
    //        eventDescription.adjustsFontSizeToFitWidth = false
    ////        eventDescription.lineBreakMode = .byTruncatingTail
    //
    //        if(eventDescription.maxNumberOfLines > 3)
    //        {
    //            readMoreButton.isHidden = false
    //        }else{
    //            readMoreButton.isHidden = true
    //        }
    //    }
    
    //    func updateNotificationData(notification : NotificationData) {
    //        lblDescriptionHeading.text = notification.notificationTitle
    //        eventDescription.text = notification.notificationDetail
    //        eventDescription.setLineSpacing()
    //    }
     
    @IBAction func readMoreButtonPressed(_ sender: Any) {
        if (readMoreButton.title(for: .normal) == "Read More") {
            isExpanded = true
            readMoreButton.setTitle("Read Less", for: .normal)
        } else {
            isExpanded = false
            readMoreButton.setTitle("Read More", for: .normal)
        }
        delegate?.updateTableView(willExpand: isExpanded)
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
