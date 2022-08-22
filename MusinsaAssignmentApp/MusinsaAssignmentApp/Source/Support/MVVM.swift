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
    func bind(to viewModel: ViewModel) //view가 bind 함수 구현
}

extension View {
    var identifier: String {
        return String(describing: self)
    }
    
    var viewModel: ViewModel? {
        get { //View가 자신에게 bind된 ViewModel 찾을 때 사용
            guard let viewModel = ViewModelTable.viewModelMap[identifier] as? ViewModel else { //"제 이름으로 된 ViewModel 주세요"
                return nil
            }
            return viewModel
        } set { //View에게 ViewModel 넣어줄 때 사용
            if let viewModel = newValue {
                bind(to: viewModel) //viewModel 넣어주면 자동으로 bind도 걸어줌
            }
            ViewModelTable.viewModelMap[identifier] = newValue as? AnyObject //View가 받아갈 ViewModel 맵핑시켜둠
        }
    }
}
