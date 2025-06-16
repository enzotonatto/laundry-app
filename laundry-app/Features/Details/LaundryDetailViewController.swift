//
//  LaundryDetailViewController.swift
//  laundry-app
//
//  Created by Gustavo Melleu on 15/06/25.
//

import UIKit

class LaundryDetailViewController: UIViewController {
    private let laundry: Laundry
    
    init(laundry: Laundry) {
        self.laundry = laundry
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setup()
    }

}

extension LaundryDetailViewController: ViewCodeProtocol {
    func addSubViews() {
        
    }
    
    func setupConstraints() {

    }
    
    
}
