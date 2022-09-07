//
//  RoundButton.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/31.
//

import UIKit

final class RoundPaddingButton: UIButton {
    private var padding = UIEdgeInsets.zero
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        if contentSize == .zero { return contentSize }
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
//        self.titleEdgeInsets = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
    }
}
