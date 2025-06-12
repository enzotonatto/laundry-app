//
//  UIImage+gradient.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 12/06/25.
//

import UIKit

extension UIImage {
  static func gradientImage(
    size: CGSize,
    colors: [UIColor],
    cornerRadius: CGFloat = 0,
    maskedCorners: CACornerMask = []
  ) -> UIImage {
    let layer = CAGradientLayer()
    layer.frame = CGRect(origin: .zero, size: size)
    layer.colors = colors.map { $0.cgColor }
    layer.startPoint = CGPoint(x: 0.5, y: 0)
    layer.endPoint   = CGPoint(x: 0.5, y: 1)
    if cornerRadius > 0 {
      layer.cornerRadius = cornerRadius
      layer.maskedCorners = maskedCorners
      layer.masksToBounds = true
    }
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, false, UIScreen.main.scale)
    defer { UIGraphicsEndImageContext() }
    guard let ctx = UIGraphicsGetCurrentContext() else { return UIImage() }
    layer.render(in: ctx)
    return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
  }
}
