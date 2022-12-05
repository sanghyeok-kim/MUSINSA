//
//  MVVM.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import Foundation

enum ViewModelTable {
    static var viewModelMap = [String: AnyObject?]()
}

protocol ViewModel: AnyObject {
    associatedtype Action
    associatedtype State
    
    var action: Action { get }
    var state: State { get }
}

protocol View: AnyObject {
    associatedtype ViewModel
    func bind(to viewModel: ViewModel)
}

extension View {
    var identifier: String {
        return String(describing: self)
    }
    
    var viewModel: ViewModel? {
        get {
            guard let viewModel = ViewModelTable.viewModelMap[identifier] as? ViewModel else {
                return nil
            }
            return viewModel
        } set {
            if let viewModel = newValue {
                bind(to: viewModel)
            }
            ViewModelTable.viewModelMap[identifier] = newValue as? AnyObject
        }
    }
}

