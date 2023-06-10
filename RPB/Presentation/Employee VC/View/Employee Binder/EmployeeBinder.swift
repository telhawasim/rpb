//
//  EmployeeBinder.swift
//  RPB
//
//  Created by Telha Wasim on 18/01/2023.
//

import Foundation
import UIKit
import AlignedCollectionViewFlowLayout

class EmployeeBinder: NSObject {
    
    //MARK: Variables
    weak var tableView: UITableView?
    weak var collectionView: UICollectionView?
    weak var lblEmployee: UILabel?
    weak var txtSearch: UITextField?
    weak var mainView: UIView?
    weak var bottomSheetHeight: NSLayoutConstraint?
    weak var bottomSheetView: UIView?
    weak var selectedCell: UICollectionViewCell?
    
    init(tableView: UITableView, collectionView: UICollectionView, lblEmployee: UILabel?, txtSearch: UITextField, mainView: UIView,bottomSheetHeight: NSLayoutConstraint, bottomSheetView: UIView ) {
        self.tableView = tableView
        self.collectionView = collectionView
        self.lblEmployee = lblEmployee
        self.txtSearch = txtSearch
        self.mainView = mainView
        self.bottomSheetView = bottomSheetView
        self.bottomSheetHeight = bottomSheetHeight
    }
    
    var selectedIndex = IndexPath(item: 0, section: 0)
    var employeeListing: EmployeeListingResponse?
    var departments: [Departments]?
    var currentPage: Int = 1
    var departmentID: String?
    var didTapProfileAt: ((String) -> Void)?
    var didTapFilterAt: ((String, Int, String) -> Void)?
    var showPagination: ((Int) -> Void)?
    var didShowSearch: ((String, String) -> Void)?
    var didRefresh: ((UIRefreshControl) -> Void)?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .gray
        
        return refreshControl
    }()
    
    // MARK: Colors
    func setColors() {
        self.lblEmployee?.textColor = UIColor.customBlack
    }
    
    // MARK: Fonts
    func configureFonts() {
        self.lblEmployee?.font = UIFont.getMediumFont(size: 24)
    }
    
    // MARK: Configure TextField
    func configureTextField() {
        self.txtSearch?.attributedPlaceholder = NSAttributedString(string: Localization.Employee.kSearch, attributes: [NSAttributedString.Key.foregroundColor: UIColor.customBlack, NSAttributedString.Key.font: UIFont.getMediumFont(size: 14)])
        self.txtSearch?.delegate = self
    }
    
    // MARK: Configure Bottom Sheet
    func configureBottomSheet() {
        self.bottomSheetView?.cornerRadius(20)
    }
    
    // MARK: Register Cell
    func registerCell() {
        self.tableView?.refreshControl = self.refreshControl
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(EmployeesTableViewCell.className)
        self.tableView?.register(EmptyTVCell.className)
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.flashScrollIndicators()
        self.collectionView?.register(FilterCollectionViewCell.className)
        let alignedFlowLayout = collectionView?.collectionViewLayout as? AlignedCollectionViewFlowLayout
        alignedFlowLayout?.horizontalAlignment = .left
        alignedFlowLayout?.minimumInteritemSpacing = 10

    }
    
    // MARK: TableView Animation
    func tableViewAnimation() {
        self.tableView?.reloadWithAnimation()
    }
    
    // MARK: For Dynamic size of the CollectionView Cell
    func calculateDynamicWidth(of string: String, padding: CGFloat ) -> CGFloat {
        if string.count > 1 {
            return string.widthOfString(usingFont: UIFont.getSemiBoldFont()) + padding
        } else {
            return 0
        }
    }
    
    //MARK: Show Filter
    func showFilter() {
        self.collectionView?.alpha = 0
        self.bottomSheetView?.alpha = 0
        
        UIView.transition(with: self.collectionView ?? UIView(),
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
            self.mainView?.backgroundColor = UIColor.black
            self.mainView?.alpha = 0.6
            self.mainView?.isUserInteractionEnabled = true
            self.bottomSheetView?.isHidden = false
            self.collectionView?.isHidden = false
            self.bottomSheetHeight?.constant = 360
            self.collectionView?.alpha = 1
            self.bottomSheetView?.alpha = 1
        }, completion: nil)
    }
    
    //MARK: Hide Filter
    func hideFilter() {
        UIView.transition(with: self.collectionView ?? UIView(),
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
            self.collectionView?.alpha = 0
            self.bottomSheetView?.alpha = 0
        }, completion: { finished in
            self.bottomSheetView?.isHidden = true
            self.collectionView?.isHidden = true
            self.bottomSheetHeight?.constant = 0
            self.mainView?.backgroundColor = .clear
            self.mainView?.alpha = 1
            self.mainView?.isUserInteractionEnabled = false
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.didRefresh?(self.refreshControl)
    }
}

//MARK: TextField Methods
extension EmployeeBinder: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.didShowSearch?(self.txtSearch?.text ?? "", self.departmentID ?? "")
    }
}

//MARK: TableView Methods
extension EmployeeBinder: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if employeeListing?.data?.employees == nil {
            return 10
        } else if employeeListing?.data?.employees?.count == 0 {
            return 1
        } else {
            return employeeListing?.data?.employees?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if employeeListing?.data?.employees?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTVCell.className, for: indexPath) as! EmptyTVCell
            cell.setup(type: .employeeListing)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesTableViewCell.className, for: indexPath) as! EmployeesTableViewCell
            if employeeListing?.data?.employees != nil {
                cell.hideSkeletonForViews(tableView: self.tableView!)
                if let data = employeeListing?.data?.employees {
                    cell.configure(data: data[indexPath.row])
                }
            } else {
                cell.showSkeletonForViews(tableView: self.tableView!)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = employeeListing?.data?.employees, !data.isEmpty {
            self.didTapProfileAt?(data[indexPath.row]._id ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 9 {
            if self.currentPage < self.employeeListing?.data?.totalPages ?? 0 {
                currentPage += 1
                self.showPagination?(currentPage)
            }
        }
    }
}

//MARK: CollectionView Methods
extension EmployeeBinder: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + (departments?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.className, for: indexPath) as! FilterCollectionViewCell
        if indexPath.row == 0 {
            cell.filterLabel.text = "All"
        } else {
            cell.filterLabel.text = departments?[indexPath.row - 1].title
        }
        
        if indexPath == selectedIndex {
            cell.backgroundViewColor.backgroundColor = UIColor.appColor
            cell.filterLabel.textColor = .white
        } else {
            cell.backgroundViewColor.backgroundColor = UIColor.blueF2F5FF
            cell.filterLabel.textColor = .black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if collectionView.numberOfItems(inSection: section) == 1 {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return UIEdgeInsets(top: 0, left: -40, bottom: 0, right: collectionView.frame.width - flowLayout.itemSize.width)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        self.currentPage = 1
        if indexPath.row == 0 {
            self.departmentID = ""
            self.didTapFilterAt?("", currentPage, txtSearch?.text ?? "")
        } else {
            self.departmentID = self.departments?[indexPath.row - 1]._id
            self.didTapFilterAt?(self.departments?[indexPath.row - 1]._id ?? "", currentPage, txtSearch?.text ?? "")
        }
        self.hideFilter()
        self.employeeListing = nil
        self.collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
