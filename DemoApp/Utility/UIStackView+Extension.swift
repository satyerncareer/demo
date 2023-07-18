//
//  UIStackView+Extension.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubViews(_ views: UIView...) {
        views.forEach { view in
            self.addArrangedSubview(view)
        }
    }
}
