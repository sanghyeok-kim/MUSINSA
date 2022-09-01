//
//  SectionDataSourceViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/28.
//

import Foundation

protocol SectionDataSourceViewModel {
    var sectionData: Entity.SectionData { get }
    func bindCellViewModel<T: View>(for cellView: T, at index: Int)
}
