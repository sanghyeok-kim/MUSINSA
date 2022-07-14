//
//  Observable.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import Foundation

final class Observable<T> {
    typealias BindElement = (T) -> Void
    
    private var binders: [BindElement] = []
    
    func bind(onNext: @escaping BindElement) {
        binders.append(onNext)
    }
    
    func accept(_ value: T) {
        binders.forEach {
            $0(value)
        }
    }
    
    func clearBinds() {
        binders.removeAll(keepingCapacity: true)
    }
}
