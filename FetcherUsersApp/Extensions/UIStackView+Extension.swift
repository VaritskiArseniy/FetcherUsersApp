//
//  UIStackView+Extension.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 20.09.24.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
