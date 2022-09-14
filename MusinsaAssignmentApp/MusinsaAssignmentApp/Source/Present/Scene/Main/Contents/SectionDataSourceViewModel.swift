//
//  SectionDataSourceViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/28.
//

import Foundation

protocol SectionDataSourceViewModel {
    var sectionEntity: SectionEntity { get }
    func bindCellViewModel<T: View>(for cellView: T, at index: Int)
}
