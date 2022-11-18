//
//  BaseView.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import UIKit

 class BaseView: UIView {
    /// Frame Initializer
       override public init(frame: CGRect) {
           super.init(frame: frame)
           create()
       }
       
       /// Coder initializer
       required public init?(coder: NSCoder) {
           super.init(coder: coder)
           create()
       }
       
       /// base function to create the subviews
       /// This function is override by different views to create their own subviews
       open func create() {
           self.backgroundColor = .white
       }
     
     /// Achive the rect of view
        override open func draw(_ rect: CGRect) {
            super.draw(rect)
        }
}
