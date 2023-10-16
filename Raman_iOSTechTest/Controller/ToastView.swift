//
//  ToastView.swift
//  Raman_iOSTechTest
//
//  Created by Genie Talk on 16/10/23.
//

import Foundation
import UIKit
class ToastView: UIView {
    init(message: String) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = message
        label.numberOfLines = 0
        label.textAlignment = .center
        
        addSubview(label)
        
        // Customize the label and layout here
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
