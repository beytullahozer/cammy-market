//
//  BaseViewController.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "black")
        
        let cartButton = UIBarButtonItem(image: UIImage(named: "basket"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.showCartPage))
        cartButton.tintColor = UIColor(named: "black")
        navigationItem.rightBarButtonItem = cartButton
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "lightGreen")
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func showCartPage() {
        Logger.log(text: "sepet sayfası açılacak")
        let cart = CartViewController()
        navigationController?.pushViewController(cart, animated: true)
    }
}
