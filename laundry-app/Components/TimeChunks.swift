//
//  TimeChunks.swift
//  laundry-app
//
//  Created by Antonio Costa on 20/06/25.
//

import Foundation
import UIKit

class TimeChunks: UIButton{
    
    private var chunkStart: Date = Date.now
    private var chunkEnd: Date = Date.now
    
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
        self.chunkEnd = chunkEnd
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
