//
//  UIStackView+Extension.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/09/07.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
