//
//  FooterBindable.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/31.
//

import Foundation

protocol FooterBindable {
    func bindFooterViewModel<T: View>(for footerView: T)
}

