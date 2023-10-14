//
//  LoadingManager.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import UIKit
import Lottie

// MARK: - LoadingManager

class LoadingManager {

    // MARK: Lifecycle

    private init() { } // Private initializer to ensure only one instance is created.

    // MARK: Internal

    static let shared = LoadingManager()

    func showLoading() {
        guard let window = keyWindow else { return }

        if loadingView == nil {
            loadingView = LoadingView(frame: window.bounds)
        }

        if let loadingView = loadingView {
            window.addSubview(loadingView)
            loadingView.startAnimating()
        }
    }

    func hideLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView?.alpha = 0
        }) { _ in
            self.loadingView?.stopAnimating()
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        }
    }

    // MARK: Private

    private var loadingView: LoadingView?

    private var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }.first
    }

}

// MARK: - LoadingView

class LoadingView: UIView {

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }

    // MARK: Internal

    func startAnimating() {
        self.animationView?.play()
    }

    func stopAnimating() {
        self.animationView?.stop()
    }

    // MARK: Private

    private var animationView: LottieAnimationView?

    private func setupView() {
        self.animationView = LottieAnimationView()
        self.animationView?.animation = LottieAnimation.named(Constants.Lottie.loading)
        self.animationView?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.animationView?.center = center
        self.animationView?.loopMode = .loop
        self.animationView?.animationSpeed = 0.5

        if let animationView = animationView {
            addSubview(animationView)
        }
    }

}
