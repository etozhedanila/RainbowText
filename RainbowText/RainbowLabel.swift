//
//  RainbowLabel.swift
//  RainbowTextTest
//
//  Created by Виталий Субботин on 29.05.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

public class RainbowLabel: UIView {

    public var text: String? {
        didSet {
            maskLabel.text = text
        }
    }
    
    public var numberOfLines: Int = 1 {
        didSet {
            maskLabel.numberOfLines = numberOfLines
        }
    }
    
    public var font: UIFont = .systemFont(ofSize: 17) {
        didSet {
            maskLabel.font = font
        }
    }
    
    public var textAlignment: NSTextAlignment = .natural {
        didSet {
            maskLabel.textAlignment = textAlignment
        }
    }

    public var textHeight: CGFloat {
        let height = text?.height(withConstrainedWidth: self.bounds.width, font: maskLabel.font)
        return height ?? 0
    }

    private let maskLabel = UILabel()
    private let rainbowView = UIView()
    
    private let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let hueColors = stride(from: 0, to: 1, by: 0.01).map {
            UIColor(hue: $0, saturation: 1, brightness: 1, alpha: 1).cgColor
        }
        gradient.colors = hueColors + hueColors
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rainbowView)
        addSubview(maskLabel)
        makeConstarints()
    }

    public required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        configureGradient()
    }
}

// MARK: - Animation
public extension RainbowLabel {
    
    func startAnimate() {
        UIView.animate(
            withDuration: 1.0,
            delay: 0,
            options: [.repeat, .curveLinear],
            animations: { [weak self] in
                guard let self = self else { return }
                self.rainbowView.transform = CGAffineTransform(translationX: -self.rainbowView.bounds.width, y: 0)
            },
            completion: { [weak self] _ in
                guard let self = self else { return }
                self.rainbowView.transform = .identity
            })
    }
    
    func stopAnimate() {
        rainbowView.layer.removeAllAnimations()
    }
}

// MARK: - Private
private extension RainbowLabel {
    
    func configureGradient() {
        let size = CGSize(width: rainbowView.bounds.width * 2, height: rainbowView.bounds.height)
        gradient.frame = CGRect(origin: rainbowView.bounds.origin, size: size)

        if !(rainbowView.layer.sublayers?.contains(where: { $0 === gradient }) ?? false) {
            rainbowView.layer.insertSublayer(gradient, at: 0)
        }
        self.mask = maskLabel
    }

    func makeConstarints() {
        rainbowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        maskLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: -Height
fileprivate extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }
}
