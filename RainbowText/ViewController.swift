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
    private let rainbowLabel = RainbowLabel()
    private var rainbowHeight: Constraint?

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(rainbowLabel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstarints()
        rainbowLabel.text = "Rainbow very very beautiful teeeeeeext!!!!!!!".uppercased()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rainbowHeight?.update(offset: rainbowLabel.textHeight)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rainbowLabel.startAnimate()
    }

    private func makeConstarints() {
        rainbowLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview().inset(50)
            rainbowHeight = make.height.equalTo(0).constraint
        }
    }
}
