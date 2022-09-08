//
//  UIVew+Extension.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/09/07.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}
