// SchedulingDay.swift
// laundry-app
// Created by Antonio Costa on 20/06/25.

import UIKit

class SchedulingDay: UIButton {
    
    
    private let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 12
        v.isUserInteractionEnabled = false
        return v
    }()
    
    private let dayLabel: UILabel = {
        let l = UILabel()
        l.font = Fonts.title2
        l.textAlignment = .center
        return l
    }()
    
    private let weekLabel: UILabel = {
        let l = UILabel()
        l.font = Fonts.caption1
        l.textAlignment = .center
        return l
    }()
    
    private lazy var stack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [dayLabel, weekLabel])
        s.axis = .vertical
        s.alignment = .center
        s.spacing = 2
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setTitle(nil, for: .normal)
        addSubview(containerView)
        containerView.addSubview(stack)
    }
    
    private func updateAppearance() {
        if isSelected {
            containerView.backgroundColor = .systemIndigo
            dayLabel.textColor = .white
            weekLabel.textColor = .white
        } else {
            containerView.backgroundColor = .systemGray6
            dayLabel.textColor = .label
            weekLabel.textColor = .secondaryLabel
        }
    }
    
    override var isSelected: Bool {
        didSet { updateAppearance() }
    }
    
    var date: Date?

    func configure(day: String, week: String, date: Date, selected: Bool = false) {
        dayLabel.text = day
        weekLabel.text = week
        self.date = date
        isSelected = selected
    }
}

extension SchedulingDay: ViewCodeProtocol {
    func addSubViews() {
        addSubview(containerView)
        containerView.addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])

    }
    
}


