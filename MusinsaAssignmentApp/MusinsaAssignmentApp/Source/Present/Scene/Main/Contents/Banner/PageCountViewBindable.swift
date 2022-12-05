//
//  PageCountViewBindable.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/31.
//

import Foundation

protocol PageCountViewBindable {
    func bindPageCountViewModel<T: View>(for pageCountView: T)
}
