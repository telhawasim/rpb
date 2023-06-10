//
//  SummaryTVCell.swift
//  RPB
//
//  Created by Telha Wasim on 27/12/2022.
//

import UIKit

class SummaryTVCell: UITableViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: Variables
    var textDidChange: ((UITextView) -> Void)?
    
    //MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
        self.configureTextView()
    }
    
    func configureView() {
        self.summaryView.borderColor = UIColor.greyE2E2E2
        self.summaryView.borderWidth = 1
        self.summaryView.cornerRadius(10)
    }
    
    func configureTextView() {
        self.textView.delegate = self
        textView.addPadding(size: 20)
        textView.text = "Write Here"
        textView.font = UIFont.getMediumFont()
        textView.textColor = UIColor.lightGray
    }
    
    func configure(data: TextFieldModel) {
        self.textView.text = data.textValue
        if textView.text != "" && textView.text != "Write Here" {
            textView.textColor = UIColor.black
        } else if textView.text == "" {
            textView.text = "Write Here"
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK: UITextView Methods
extension SummaryTVCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.textDidChange?(textView)
            textView.text = "Write Here"
            textView.textColor = UIColor.lightGray
        } else if textView.text != "" && textView.text != "Write Here" {
            self.textDidChange?(textView)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 500
    }
}
