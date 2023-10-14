//
//  Kingfisher+Extension.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import Kingfisher
import UIKit

extension UIImageView {
  func setImageFromURL(url: URL?, placeholder: UIImage? = nil) {
    let processor = DownsamplingImageProcessor(size: self.bounds.size)
    self.contentMode = .scaleToFill
    self.kf.setImage(
      with: url,
      placeholder: placeholder,
      options: [
        .scaleFactor(UIScreen.main.scale),
        .cacheOriginalImage,
        .processor(processor),
        .transition(.fade(0.3)),
      ]) { result in
        switch result {
        case .success: break
        case .failure: break
        }
      }
  }

}
