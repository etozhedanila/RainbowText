//
//  RainbowLabel.swift
//  RainbowTextTest
//
//  Created by Виталий Субботин on 29.05.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

class RainbowLabel: UIView {
    private let rainbowLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    private let rainbowView = UIView()
    private let gradient = CAGradientLayer()
    var text: String? {
        didSet {
            rainbowLabel.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rainbowView)
        addSubview(rainbowLabel)
        makeConstarints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimate() {
        configureGradient()
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.rainbowView.transform = CGAffineTransform(translationX: -self.rainbowView.bounds.width, y: 0)
        }, completion: { _ in
            self.rainbowView.transform = .identity
        })
        
    }
    
    private func configureGradient() {
        let size = CGSize(width: rainbowView.bounds.width * 2, height: rainbowView.bounds.height)
        gradient.frame = CGRect(origin: rainbowView.bounds.origin, size: size)

        let hueColors = stride(from: 0, to: 1, by: 0.01).map {
            UIColor(hue: $0, saturation: 1, brightness: 1, alpha: 1).cgColor
        }
        gradient.colors = hueColors + hueColors
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:0)
        rainbowView.layer.insertSublayer(gradient, at: 0)
        self.mask = rainbowLabel
    }
    
    private func makeConstarints() {
        rainbowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rainbowLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
