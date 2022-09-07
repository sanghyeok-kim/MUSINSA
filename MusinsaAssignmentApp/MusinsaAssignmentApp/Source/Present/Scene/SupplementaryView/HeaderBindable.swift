//
//  HeaderBindable.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/31.
//

import Foundation

protocol HeaderBindable {
    func bindHeaderViewModel<T: View>(for headerView: T)
}
