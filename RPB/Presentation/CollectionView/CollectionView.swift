//
//  CollectionView.swift
//  RPB
//
//  Created by Bilal Nisar on 27/12/2022.
//

import UIKit

extension UICollectionView {
    func register(_ name: String) {
        self.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
}
