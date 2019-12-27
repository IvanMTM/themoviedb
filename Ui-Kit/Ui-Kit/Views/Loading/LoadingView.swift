//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import UIKit

public extension UIView {
    func showLoadingView(_ indicatorStyle: UIActivityIndicatorView.Style = .medium, alpha: CGFloat = 0.8) {
        guard !subviews.contains(where: { $0 is LoadingView }) else {
            return
        }
        let loadingView = LoadingView(indicatorStyle, alpha: alpha)
        addSubview(loadingView)
    }
    
    func hideLoadingView() {
        subviews.forEach { ($0 as? LoadingView)?.removeFromSuperview() }
    }
}

private class LoadingView: UIView {
    private var backgroundAlpha: CGFloat
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(_ indicatorStyle: UIActivityIndicatorView.Style, alpha: CGFloat) {
        self.backgroundAlpha = alpha
        super.init(frame: .zero)
        activityIndicator.style = indicatorStyle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupView()
    }
}

// MARK: Private
private extension LoadingView {
    func setupView() {
        guard superview != nil else {
            return
        }
        backgroundColor = UIColor.white.withAlphaComponent(backgroundAlpha)
        setConstraints()
    }
    
    func setConstraints() {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        super.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
