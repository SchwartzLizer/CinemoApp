//
//  MovieTableViewCell.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import UIKit
import Lottie

// MARK: - MovieTableViewCellDelegate

protocol MovieTableViewCellDelegate: AnyObject {
    func didSelectViewMore(data: Movie)
    func didSelectFavourite()
}

// MARK: - MovieTableViewCell

class MovieTableViewCell: UITableViewCell {

    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyTheme()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // Reset UILabels
        self.genreLabel.text = nil
        self.dateLabel.text = nil
        self.nameLabel.text = nil

        // Reset UIImageViews
        self.favouriteImageView.image = nil
        self.imageMovie.image = nil

        // Reset Lottie Animation
        self.favouriteLottieAnimationView.stop()
        self.favouriteLottieAnimationView.isHidden = true
    }

    // MARK: Public

    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    public static var identifier: String {
        return String(describing: self)
    }

    public weak var delegate: MovieTableViewCellDelegate?

    public var viewModel: MovieTableViewModel? {
        didSet {
            onInitialized()
            onUpdated()
        }
    }

    // MARK: Internal

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var favouriteLottieAnimationView: LottieAnimationView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    // MARK: Private

    private lazy var theme = StyleSheetManager.currentTheme()
    private lazy var font = StyleSheetManager.currentFontTheme()

}

// MARK: Updated

extension MovieTableViewCell: Updated {
    internal func onInitialized() {
        guard let model = self.viewModel?.data else { return }
        self.nameLabel.text = model.titleEn
        self.genreLabel.text = model.genre
        self.dateLabel.text = DateFormatterUtility.convert(
            string: model.releaseDate ?? "",
            from: Constants.DateFormat.serverDateFormat,
            to: Constants.DateFormat.showDateFormat,
            timeZone: .utc)
        self.imageMovie.setImageFromURL(url: URL(string: model.posterURL ?? ""))
        applyThemeFavouriteImageView()
    }

    private func onUpdated() {
        self.viewModel?.onUpdated = { [weak self] in
            self?.applyThemeFavouriteImageView()
        }
    }
}


// MARK: Action

extension MovieTableViewCell: Action {
    @IBAction
    internal func didSelectViewMore(_: UIButton) {
        guard let data = self.viewModel?.data else { return }
        self.delegate?.didSelectViewMore(data: data)
    }

    @IBAction
    internal func didSelectFavourite(_: Any) {
        self.viewModel?.updateFavourite()
        if self.viewModel?.isAlreadyFav == true {
            self.favouriteLottieAnimationView.isHidden = false
            self.favouriteLottieAnimationView.play()
        } else {
            self.favouriteLottieAnimationView.isHidden = true
            self.favouriteLottieAnimationView.stop()
        }
        self.delegate?.didSelectFavourite()
    }
}

// MARK: ApplyTheme

extension MovieTableViewCell: ApplyTheme {

    // MARK: Internal

    internal func applyTheme() {
        self.applyThemeLabel()
        self.applyThemeButton()
        self.applyThemeCardView()
        self.applyThemeImageView()
        self.applyThemeLottieAnimationView()
        self.applyThemeFavouriteImageView()
    }

    // MARK: Private

    private func applyThemeLabel() {
        self.nameLabel.applyThemeLabel(font: self.font.titleFont, color: self.theme.titleTextColor)
        self.genreLabel.applyThemeLabel(font: self.font.subtitleFont, color: self.theme.subtitleTextColor)
        self.dateLabel.applyThemeLabel(font: self.font.subtitleFont, color: self.theme.subtitleTextColor)

        self.nameLabel.accessibilityIdentifier = Constants.AccessibilityIdentifier.MovieTableViewCell.movieTitleLabel
        self.genreLabel.accessibilityIdentifier = Constants.AccessibilityIdentifier.MovieTableViewCell.moviegenreLabel
        self.dateLabel.accessibilityIdentifier = Constants.AccessibilityIdentifier.MovieTableViewCell.movieReleaseDateLabel
    }

    private func applyThemeButton() {
        self.seeMoreButton.applyThemeButton(
            text: Constants.Keys.seeMoreBTN.localized(),
            font: self.font.seeMoreButtonFont,
            color: self.theme.buttonTextColor,
            round: Constants.Radius.cornerRadiusCard)
        self.seeMoreButton.accessibilityIdentifier = Constants.AccessibilityIdentifier.MovieTableViewCell.movieSeeMoreButton

        favouriteButton.accessibilityIdentifier = Constants.AccessibilityIdentifier.MovieTableViewCell.movieFavoriteButton

    }

    private func applyThemeCardView() {
        self.cardView.applyTheme(
            background: self.theme.cardBackgroundColor,
            radius: Constants.Radius.cornerRadiusCard)
        self.cardView.accessibilityIdentifier = Constants.AccessibilityIdentifier.MovieTableViewCell.movieCardView
    }

    private func applyThemeImageView() {
        self.imageMovie.applyTheme(
            background: self.theme.cardBackgroundColor,
            radius: Constants.Radius.cornerRadiusCard)
        self.imageMovie.accessibilityIdentifier = Constants.AccessibilityIdentifier.MovieTableViewCell.movieImageView
    }

    private func applyThemeLottieAnimationView() {
        self.favouriteLottieAnimationView.animation = LottieAnimation.named(Constants.Lottie.like)
        self.favouriteLottieAnimationView.loopMode = .playOnce
        self.favouriteLottieAnimationView.animationSpeed = 1
        self.favouriteLottieAnimationView.isHidden = true
        self.favouriteLottieAnimationView.accessibilityIdentifier = Constants.AccessibilityIdentifier.MovieTableViewCell.movieLottieFavoriteButton

    }

    private func applyThemeFavouriteImageView() {
        guard let fav = self.viewModel?.isAlreadyFav else { return }
        if fav {
          self.favouriteImageView.image = UIImage(systemName: Constants.SystemImage.heartFill)
        } else {
          self.favouriteImageView.image = UIImage(systemName: Constants.SystemImage.heart)
        }
        self.favouriteImageView.tintColor = self.theme.heartColor
    }

}
