//
//  PopupViewController.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private let text: String
    private let buttonTitle: String
    private let buttonAction: () -> Void
    
    init(text: String, buttonTitle: String, buttonAction: @escaping () -> Void) {
        self.text = text
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = text
        button.setTitle(buttonTitle, for: .normal)
    }

    @IBAction func actionButton(_ sender: Any) {
        Logger.log(text: "button tıklandı")
        self.dismiss(animated: true, completion: buttonAction)
    }
}
