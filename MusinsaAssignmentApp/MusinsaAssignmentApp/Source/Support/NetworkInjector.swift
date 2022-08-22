//
//  NetworkInjector.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/15.
//

import Foundation

@propertyWrapper
struct NetworkInjector<T> {
    var wrappedValue: T
    
    init(keypath: KeyPath<NetworkContainer, T>) {
        let container = NetworkContainer.shared
        wrappedValue = container[keyPath: keypath]
    }
}
