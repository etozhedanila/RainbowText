//
//  ViewController.swift
//  RainbowTextTest
//
//  Created by Виталий Субботин on 29.05.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let rl = RainbowLabel()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(rl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstarints()
        rl.text = "Колян пидор".uppercased()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rl.startAnimate()
    }
    
    private func makeConstarints() {
        rl.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(100)
        }
    }
    
    private func animate() {
        rl.alpha = 0.0
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat], animations: {
            self.rl.alpha = 1.0
            self.rl.transform = .init(scaleX: 2, y: 2)
        }, completion: { _ in
            self.rl.transform = .identity
        })
    }

}

