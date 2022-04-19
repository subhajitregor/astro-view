//
//  NoInternetView.swift
//  astro-view
//
//  Created by Subhajit on 18/04/22.
//

import UIKit

protocol NoInternetViewDelegate: AnyObject {
    func tappedOnTryAgain()
}

final class NoInternetView: UIView {
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var noInternetLabel: UILabel = {
        let label = UILabel()
        label.text = "We are not connected to the internet, showing you the last image we have."
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .red
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try Again", for: .normal)
        button.setTitleColor(.magenta, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.addTarget(self, action: #selector(NoInternetView.didTapTryAgain), for: .touchUpInside)
        button.sizeToFit()
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    weak var delegate: NoInternetViewDelegate?
    
    @objc func didTapTryAgain() {
        delegate?.tappedOnTryAgain()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        stackView.addArrangedSubview(noInternetLabel)
        stackView.addArrangedSubview(retryButton)
        
        self.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
