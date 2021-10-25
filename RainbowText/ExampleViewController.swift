//
//  ExampleViewController.swift
//  RainbowTextTest
//
//  Created by Виталий Субботин on 29.05.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit
import SnapKit

class ExampleViewController: UIViewController {
    
    private let rainbowLabel: RainbowLabel = {
        let label = RainbowLabel()
        label.text = "Rainbow very very beautiful teeeeeeext!!!!!!!".uppercased()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(rainbowLabel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstarints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rainbowLabel.startAnimate()
    }

    private func makeConstarints() {
        rainbowLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview().inset(50)
        }
    }
}
