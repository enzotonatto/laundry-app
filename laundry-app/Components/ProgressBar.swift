//
//  ProgressBar.swift
//  laundry-app
//
//  Created by Gustavo Melleu on 25/06/25.
//

import Foundation
import UIKit

class ProgressBar: UIView {
    
    var numberOfSteps: Int = 4 {
        didSet { updateFill() }
    }
    var currentStep: Int = 1 {
        didSet { updateFill() }
    }
    
    // MARK: – Privates
    private let fillView: UIView = {
        let view = UIView()
        view.backgroundColor = .progress
        view.clipsToBounds = true
        view.layer.cornerRadius = 16 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var fillWidthConstraint: NSLayoutConstraint?
    private let fillGradient = CAGradientLayer()
    
    private let trackView: UIView = {
        let view = UIView()
        view.backgroundColor = .progress
        view.layer.cornerRadius = 16 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let segmentHeight: CGFloat = 14
    
    // MARK: – Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        // 1) Adiciona track de fundo
        addSubview(trackView)
        NSLayoutConstraint.activate([
            trackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackView.topAnchor.constraint(equalTo: topAnchor),
            trackView.heightAnchor.constraint(equalToConstant: segmentHeight),
        ])
        
        // 2) Adiciona fillView por cima do track
        addSubview(fillView)
        // Insere o gradiente
        fillView.layer.insertSublayer(fillGradient, at: 0)
        fillGradient.colors = [UIColor.startGradient.cgColor, UIColor.endGradient.cgColor]
        fillGradient.startPoint = CGPoint(x: 0, y: 0.5)
        fillGradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        fillWidthConstraint = fillView.widthAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            fillView.leadingAnchor.constraint(equalTo: trackView.leadingAnchor),
            fillView.topAnchor.constraint(equalTo: trackView.topAnchor),
            fillView.heightAnchor.constraint(equalTo: trackView.heightAnchor),
            fillWidthConstraint!
        ])
    }
    
    // MARK: – Update Fill
    private func updateFill() {
        // Ajusta apenas a constant da constraint
        let ratio = CGFloat(currentStep) / CGFloat(numberOfSteps)
        let totalWidth = bounds.width
        fillWidthConstraint?.constant = totalWidth * ratio
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Aplica a largura e os corner radii
        updateFill()
        trackView.layer.cornerRadius = segmentHeight / 2
        fillView.layer.cornerRadius  = segmentHeight / 2
        
        // Ajusta o frame do gradiente
        fillGradient.frame = fillView.bounds
    }
    
    func setStep(_ step: Int, animated: Bool) {
        let newStep = max(1, min(step, numberOfSteps))
        currentStep = newStep
        
        if animated {
            let targetRatio = CGFloat(currentStep) / CGFloat(numberOfSteps)
            UIView.animate(withDuration: 0.3) {
                self.fillWidthConstraint?.constant = self.bounds.width * targetRatio
                self.layoutIfNeeded()
            }
        } else {
            setNeedsLayout()
        }
    }
}
