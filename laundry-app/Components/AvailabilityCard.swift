//
//  AvailabilityCard.swift
//  laundry-app
//
//  Created by Gabriel Barbosa on 11/06/25.
//

import Foundation
import UIKit

class AvailabilityCard: UIView {
    lazy var circle: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "circle")
        
        
        
        return image
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    
   
    
    
    
}
