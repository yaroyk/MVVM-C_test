//
//  SplashScreenViewController.swift
//  architecture
//
//  Created by photoyk on 08.06.2023.
//

import UIKit

class SplashScreenViewController<T: SplashScreenViewModel>: UIViewController,
                                                            Controller {
    
    // MARK: - Typealias
    typealias ViewModel = T
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    private let viewModel: ViewModel
    
    // MARK: - Initializations and Deallocation
    deinit {
        print("Controller deinit: \(type(of: self))")
    }
    
    required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: classNameForXib(Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.viewModel.input.onAction.send(.viewWillAppear)
    }
    
    // MARK: - Configure
    func configure(with viewModel: ViewModel) {}
    
    // MARK: - Private
    private func setupUI() {
        backgroundImageView.image = AppImages.SplashScreen.background
        titleLabel.text = AppTexts.SplashScreen.title
    }
}
