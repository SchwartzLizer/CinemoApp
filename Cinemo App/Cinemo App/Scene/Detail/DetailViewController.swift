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

    private lazy var themeManager = ThemeManager.currentTheme()

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
        self.genreLabel.applyThemeLabel(font: .systemFont(ofSize: 14), color: self.themeManager.subtitleTextColor)
        self.nameLabel.applyThemeLabel(font: .systemFont(ofSize: 14), color: self.themeManager.titleTextColor)
        self.descriptionLabel.applyThemeLabel(font: .systemFont(ofSize: 14), color: self.themeManager.titleTextColor)
    }

    func applyThemeButton() {
        if self.viewModel.isAlreadyFav == true {
            self.addFavouriteButton.applyThemeButton(
                text: "Remove favourite",
                font: .systemFont(ofSize: 14),
                color: .white,
                round: self.addFavouriteButton.frame.height / 2.00,
                backgroundColor: UIColor().hex("Ff0000"),
                borderColor: UIColor().hex("Ff0000"))
        } else {
            self.addFavouriteButton.applyThemeButton(
                text: "Add to favourite",
                font: .systemFont(ofSize: 14),
                color: .white,
                round: self.addFavouriteButton.frame.height / 2.00,
                backgroundColor: UIColor().hex("f31e8b"),
                borderColor: UIColor().hex("f31e8b"))
        }
    }

    func applyThemeImageView() {
        self.imageMovie.applyTheme(
            background: self.themeManager.cardBackgroundColor,
            border: self.themeManager.cardBackgroundColor,
            radius: Constants.Radius.cornerRadiusCard)
    }

    func applyThemeView() {
        self.view.backgroundColor = .white
    }

    func applyThemeNavigationBar() {
        self.title = "Cinemo"
    }

}
