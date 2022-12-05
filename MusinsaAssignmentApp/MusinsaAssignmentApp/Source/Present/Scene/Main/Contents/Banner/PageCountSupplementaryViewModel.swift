//
//  PageCountSupplementaryViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import Foundation

final class PageCountSupplementaryViewModel: ViewModel {
    
    struct Action {
        
    }
    struct State {
        let maxPageCount = PublishRelay<Int>()
        let currentPageCount = PublishRelay<Int>()
    }
    
    let action = Action()
    let state = State()
    
    init() {
        
    }
}
