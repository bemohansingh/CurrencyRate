//
//  BaseViewController.swift
//  CurrencyRate
//
//  Created by Mohan Singh Thagunna on 18/11/2022.
//

import UIKit

 class BaseViewController: UIViewController {
    /// The baseView of controller
        public private(set) var baseView: BaseView!
        
        /// The baseViewModel of controller
        public private(set) var baseViewModel: BaseViewModel!
        
        /// when view is loaded
        override open func viewDidLoad() {
            super.viewDidLoad()
            
            /// setup UI
            setupUI()
            
            /// observe events
            observeEvents()
        }
        
        /// Method that will set the viewmodel after initialization from storyboard
        /// - Parameter viewModel: the viewmodel for the controller
        func setViewModel(viewModel: BaseViewModel) {
            guard baseViewModel == nil else { return }
            baseViewModel = viewModel
        }
        
        /// Initializer for a controller
        /// - Parameters:
        ///   - baseView: the view associated with the controller
        ///   - baseViewModel: viewModel associated with the controller
        public init(baseView: BaseView, baseViewModel: BaseViewModel) {
            self.baseView = baseView
            self.baseViewModel = baseViewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        /// Not available
        required public init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        /// Load the base view as the view of controller
        override open func loadView() {
            super.loadView()
            view = baseView
        }
        
        /// setup trigger
        open func setupUI() {}
        
        /// Observer for events
        open func observeEvents() {}
}
