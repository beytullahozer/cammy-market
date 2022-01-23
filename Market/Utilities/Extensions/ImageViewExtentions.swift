//
//  ImageViewExtentions.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(urlString: String?) {
        guard let urlString = urlString else {
            self.image = nil
            return
        }
        self.kf.setImage(with: URL(string: urlString))
    }
}
