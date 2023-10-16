//
//  EmptyStateTableViewCell.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import UIKit
import Lottie

// MARK: - EmptyStateTableViewCell

class EmptyStateTableViewCell: UITableViewCell {

    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.applyTheme()
    }

    // MARK: Public

    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    public static var identifier: String {
        return String(describing: self)
    }

    // MARK: Internal

    @IBOutlet weak var constraintsHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!

    var viewModel: EmptyStateViewModel? {
        didSet {
            onInitialized()
        }
    }

    // MARK: Private

    private lazy var theme = StyleSheetManager.currentTheme()
    private lazy var font = StyleSheetManager.currentFontTheme()

}

// MARK: Updated

extension EmptyStateTableViewCell: Updated {

    // MARK: Internal

    internal func onInitialized() {
        self.updateLabel()
    }

    // MARK: Private

    private func updateLabel() {
        guard let viewModel = self.viewModel else { return }
        self.descriptionLabel.text = viewModel.type.rawValue.localized()
        self.constraintsHeight.constant = UIScreen.main.bounds.height * 0.7
        switch self.viewModel?.type {
        case .notFound,.serviceNotFound,.unknown:
            self.lottieAnimationView.animation = LottieAnimation.named(Constants.Lottie.notFound)
            self.lottieAnimationView.play()
        case .favouriteEmpty:
            self.lottieAnimationView.animation = LottieAnimation.named(Constants.Lottie.noFavourite)
            self.lottieAnimationView.play()
        case nil,.none?: break
        }
    }


}

// MARK: UserInterfaceSetup

extension EmptyStateTableViewCell: UserInterfaceSetup {

    // MARK: Internal

    internal func setupUI() {
        self.setupLottie()
    }

    // MARK: Private

    private func setupLottie() {
        self.lottieAnimationView.loopMode = .loop
    }

}

// MARK: ApplyTheme

extension EmptyStateTableViewCell:ApplyTheme {

    // MARK: Internal

    internal func applyTheme() {
        self.applyThemeLabel()
    }

    // MARK: Private

    private func applyThemeLabel() {
        self.descriptionLabel.applyThemeLabel(font: self.font.titleFont, color: self.theme.titleTextColor)
    }

}
