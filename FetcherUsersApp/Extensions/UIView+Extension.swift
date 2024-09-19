//
//  UIView+Extension.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 18.09.24.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
