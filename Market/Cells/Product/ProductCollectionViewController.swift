//
//  ProductCollectionViewController.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        oldPriceLabel.text = nil
        newPriceLabel.text = nil
        typeLabel.text = nil
        imageView.setImage(urlString: nil)
        
    }
    
    func configure(with product: Product) {
        
        nameLabel.text = product.productName
        oldPriceLabel.text = product.oldPrice?.toStringWithCurrency
        newPriceLabel.text = product.newPrice?.toStringWithCurrency
        typeLabel.text = product.type
        imageView.setImage(urlString: product.productImage)
    }
}
