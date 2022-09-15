//
//  Extension+UIAction_Identifier.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/09/07.
//

import UIKit

extension UIAction.Identifier {
    static var cellTapped: UIAction.Identifier {
        return UIAction.Identifier("\(String(describing: self))")
    }
    
    static var seeMoreButtonTapped: UIAction.Identifier {
        return UIAction.Identifier("\(String(describing: self))")
    }
}
