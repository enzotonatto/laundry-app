//
//  TimeChunks.swift
//  laundry-app
//
//  Created by Antonio Costa on 20/06/25.
//

import Foundation
import UIKit

protocol TimeChunksViewDelegate: AnyObject {
    func didSelect(option: TimeChunks)
}

class TimeChunks: UIButton{
    
    private(set) var chunkStart: Date
    private(set) var chunkEnd:   Date

    weak var delegate: TimeChunksViewDelegate?
    
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 27
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var timeChunk: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.timeZone = TimeZone.current
        
        let formattedStart = formatter.string(from: chunkStart)
        let formattedEnd = formatter.string(from: chunkEnd)
        
        label.text = "\(formattedStart) - \(formattedEnd)"
        label.font = Fonts.body
        return label
    }()
    
    private lazy var selectIcon: UIView = {
        let icon = UIView()
        icon.backgroundColor = .systemGray
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = 12
        return icon
    }()

    var time: String? {
        didSet{
            timeChunk.text = time
        }
    }
    
    init(chunkStart: Date, chunkEnd: Date) {
            self.chunkStart = chunkStart
            self.chunkEnd   = chunkEnd
            super.init(frame: .zero)
            setup()  // seu ViewCodeProtocol
            // 1) registra o tap
            addTarget(self, action: #selector(handleTap), for: .touchUpInside)
            // 2) configura o estado inicial
            configureRadioButton(selected: isSelected)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRadioButton(selected: Bool) {
        selectIcon.subviews.forEach { $0.removeFromSuperview() }
        selectIcon.layer.cornerRadius = 12
        selectIcon.layer.borderWidth = 2
        selectIcon.layer.borderColor = UIColor.systemIndigo.cgColor
        selectIcon.backgroundColor = selected ? UIColor.systemIndigo : .clear
        
        if selected {
            let innerCircle = UIView()
            innerCircle.backgroundColor = .secondarySystemBackground
            innerCircle.layer.cornerRadius = 6
            innerCircle.translatesAutoresizingMaskIntoConstraints = false
            selectIcon.addSubview(innerCircle)
            NSLayoutConstraint.activate([
                innerCircle.centerXAnchor.constraint(equalTo: selectIcon.centerXAnchor),
                innerCircle.centerYAnchor.constraint(equalTo: selectIcon.centerYAnchor),
                innerCircle.widthAnchor.constraint(equalToConstant: 12),
                innerCircle.heightAnchor.constraint(equalToConstant: 12)
            ])
        }
    }
    
    override var isSelected: Bool {
            didSet { configureRadioButton(selected: isSelected) }
    }
        
    @objc private func handleTap() {
            // alterna o estado visual
            isSelected.toggle()
            // dispara o delegate
            delegate?.didSelect(option: self)
        }
    
    func setSelected(_ selected: Bool) {
        configureRadioButton(selected: selected)
    }
    
    
    
}

extension TimeChunks: ViewCodeProtocol{
    func addSubViews() {
        addSubview(background)
        background.addSubview(timeChunk)
        background.addSubview(selectIcon)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            background.heightAnchor.constraint(equalToConstant: 54),
            
            timeChunk.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            timeChunk.topAnchor.constraint(equalTo: background.topAnchor, constant: 15),
            
            selectIcon.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            selectIcon.topAnchor.constraint(equalTo: background.topAnchor, constant: 15),
            selectIcon.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -15),
            selectIcon.heightAnchor.constraint(equalToConstant: 24),
            selectIcon.widthAnchor.constraint(equalToConstant: 24),
            
            
        ])
    }
}
