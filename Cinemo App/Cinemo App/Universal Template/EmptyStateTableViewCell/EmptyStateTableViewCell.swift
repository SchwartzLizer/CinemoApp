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
        setupUI()
        applyTheme()
    }

    // MARK: Public

    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    public static var identifier: String {
        return String(describing: self)
    }

    // MARK: Internal

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!

    var viewModel: EmptyStateViewModel? {
        didSet {
            onUpdated()
        }
    }

    // MARK: Private

    private lazy var themeManager = ThemeManager.currentTheme()

}

// MARK: Updated

extension EmptyStateTableViewCell: Updated {
    func onUpdated() {
        self.updateLabel()
    }

    func updateLabel() {
        guard let viewModel = viewModel else { return }
        self.descriptionLabel.text = self.viewModel?.type.rawValue.localized()
    }


}

// MARK: UserInterfaceSetup

extension EmptyStateTableViewCell: UserInterfaceSetup {
    func setupUI() {
        self.setupLottie()
    }

    func setupLottie() {
        self.lottieAnimationView.animation = LottieAnimation.named(Constants.Lottie.notFound)
        self.lottieAnimationView.loopMode = .loop
        self.lottieAnimationView.play()
    }

}

// MARK: ApplyTheme

extension EmptyStateTableViewCell:ApplyTheme {
    func applyTheme() {
        self.applyThemeLabel()
    }

    func applyThemeLabel() {
        self.descriptionLabel.applyTheme(font: .systemFont(ofSize: 14), color: self.themeManager.titleTextColor)
    }

}
