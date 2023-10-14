//
//  DetailViewController.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import UIKit

// MARK: - DetailViewController

final class DetailViewController: UIViewController {

    // MARK: Lifecycle

    required init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: DetailViewController.identifier, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        onInitialized()
        onUpdated()
    }

    // MARK: Public

    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    public static var identifier: String {
        return String(describing: self)
    }

    // MARK: Internal

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var addFavouriteButton: UIButton!

    // MARK: Private

    private lazy var theme = StyleSheetManager.currentTheme()
    private lazy var font = StyleSheetManager.currentFontTheme()

    private var viewModel: DetailViewModel

}

// MARK: Updated

extension DetailViewController: Updated {
    func onInitialized() {
        self.nameLabel.text = self.viewModel.data.titleEn
        self.genreLabel.text = self.viewModel.data.genre
        self.descriptionLabel.text = self.viewModel.data.synopsisEn
        self.imageMovie.setImageFromURL(url: URL(string: self.viewModel.data.posterURL ?? ""))
    }

    func onUpdated() {
        self.viewModel.onUpdated = { [weak self] in
            self?.applyThemeButton()
        }
    }
}

// MARK: Action

extension DetailViewController: Action {
    @IBAction
    func didSelectButton(_: UIButton) {
        HapticFeedback.mediumImpact()
        self.viewModel.updateFavourite()
    }
}

// MARK: ApplyTheme

extension DetailViewController: ApplyTheme {
    func applyTheme() {
        self.applyThemeLabel()
        self.applyThemeButton()
        self.applyThemeImageView()
        self.applyThemeView()
        self.applyThemeNavigationBar()
    }

    func applyThemeLabel() {
        self.genreLabel.applyThemeLabel(font: self.font.subtitleFont, color: self.theme.subtitleTextColor)
        self.nameLabel.applyThemeLabel(font: self.font.titleFont, color: self.theme.titleTextColor)
        self.descriptionLabel.applyThemeLabel(font: self.font.titleFont, color: self.theme.titleTextColor)
    }

    func applyThemeButton() {
        if self.viewModel.isAlreadyFav == true {
            self.addFavouriteButton.applyThemeButton(
                text: Constants.Keys.removeFavBTN.localized(),
                font: self.font.favoriteButtonFont,
                color: .white,
                round: self.addFavouriteButton.frame.height / 2.00,
                backgroundColor: UIColor().hex("Ff0000"),
                borderColor: UIColor().hex("Ff0000"))
        } else {
            self.addFavouriteButton.applyThemeButton(
                text: Constants.Keys.addFavBTN.localized(),
                font: self.font.favoriteButtonFont,
                color: .white,
                round: self.addFavouriteButton.frame.height / 2.00,
                backgroundColor: theme.heartColor,
                borderColor: theme.heartColor)
        }
    }

    func applyThemeImageView() {
        self.imageMovie.applyTheme(
            background: self.theme.cardBackgroundColor,
            border: self.theme.cardBackgroundColor,
            radius: Constants.Radius.cornerRadiusCard)
    }

    func applyThemeView() {
        self.view.backgroundColor = self.theme.backgroundColor
    }

    func applyThemeNavigationBar() {
        self.title = Constants.Keys.appName.localized()
    }

}
