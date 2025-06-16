//
//  Untitled.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 15/06/25.
//

import UIKit

class InfoRow: UIView {
    
  private let iconImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.tintColor = .white
    iv.backgroundColor = .systemPurple
    iv.layer.cornerRadius = 24
    iv.clipsToBounds = true
    return iv
  }()

  private let titleLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = .systemFont(ofSize: 14, weight: .bold)
    lbl.textColor = .black
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()

  private let contentContainer: UIView
    
  private let mainStack: UIStackView = {
    let st = UIStackView()
    st.axis = .horizontal
    st.alignment = .center
    st.spacing = 12
    st.translatesAutoresizingMaskIntoConstraints = false
    return st
  }()
  
  init(icon: UIImage, title: String, contentView: UIView) {
    self.contentContainer = contentView
    super.init(frame: .zero)
    iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
    titleLabel.text = title
    setupView()
    setup()
  }

  convenience init(icon: UIImage, title: String, text: String) {
    let lbl = UILabel()
    lbl.font = .systemFont(ofSize: 16)
    lbl.textColor = .darkText
    lbl.numberOfLines = 0
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = text
    self.init(icon: icon, title: title, contentView: lbl)
  }

  convenience init(icon: UIImage, title: String, images: [UIImage]) {
    let imgs = images.map { img -> UIImageView in
      let iv = UIImageView(image: img)
      iv.contentMode = .scaleAspectFit
      iv.translatesAutoresizingMaskIntoConstraints = false
      iv.layer.cornerRadius = 8
      iv.layer.borderWidth = 1
      iv.layer.borderColor = UIColor.systemGray4.cgColor
      iv.clipsToBounds = true
      NSLayoutConstraint.activate([
        iv.widthAnchor.constraint(equalToConstant: 48),
        iv.heightAnchor.constraint(equalToConstant: 32)
      ])
      return iv
    }
    let stack = UIStackView(arrangedSubviews: imgs)
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    stack.translatesAutoresizingMaskIntoConstraints = false
    self.init(icon: icon, title: title, contentView: stack)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) { fatalError() }

  private func setupView() {
    backgroundColor = .gray
    layer.cornerRadius = 16
    translatesAutoresizingMaskIntoConstraints = false
  }
}

extension InfoRow: ViewCodeProtocol {
    func addSubViews() {
        let textStack = UIStackView(arrangedSubviews: [titleLabel, contentContainer])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.alignment = .leading
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        mainStack.addArrangedSubview(iconImageView)
        mainStack.addArrangedSubview(textStack)
        addSubview(mainStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
          iconImageView.widthAnchor.constraint(equalToConstant: 48),
          iconImageView.heightAnchor.constraint(equalToConstant: 48),

          mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
          mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
          mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
          mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
}
