//
//  MovieTableViewCell.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/13/23.
//

import UIKit

// MARK: - MovieTableViewCellDelegate

protocol MovieTableViewCellDelegate: AnyObject {
  func didSelectViewMore(data: Movie)
}

// MARK: - MovieTableViewCell

class MovieTableViewCell: UITableViewCell {

  // MARK: Lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    self.applyTheme()
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
    }
  }

  // MARK: Internal

  @IBOutlet weak var genreLabel: UILabel!

  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var imageMovie: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var seeMoreButton: UIButton!

  // MARK: Private

  private lazy var themeManager = ThemeManager.currentTheme()

}

// MARK: Updated

extension MovieTableViewCell: Updated {
  internal func onInitialized() {
    guard let model = self.viewModel?.movies else { return }
    self.nameLabel.text = model.titleEn
    self.genreLabel.text = model.genre
    self.dateLabel.text = DateFormatterUtility.convert(
      string: model.releaseDate ?? "",
      from: Constants.DateFormat.serverDateFormat,
      to: Constants.DateFormat.showDateFormat,
      timeZone: .utc)
    self.imageMovie.setImageFromURL(url: URL(string: model.posterURL ?? ""))
  }
}


// MARK: Action

extension MovieTableViewCell: Action {
  @IBAction
  func didSelectViewMore(_: UIButton) {
    guard let data = self.viewModel?.movies else { return }
    self.delegate?.didSelectViewMore(data: data)
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
  }

  // MARK: Private

  private func applyThemeLabel() {
    self.nameLabel.applyTheme(font: .boldSystemFont(ofSize: 16), color: self.themeManager.titleTextColor)
    self.genreLabel.applyTheme(font: .systemFont(ofSize: 14), color: self.themeManager.subtitleTextColor)
    self.dateLabel.applyTheme(font: .systemFont(ofSize: 14), color: self.themeManager.subtitleTextColor)
  }

  private func applyThemeButton() {
    self.seeMoreButton.applyTheme(
      text: Constants.Keys.seeMoreBTN.localized(),
      font: .systemFont(ofSize: 14),
      color: self.themeManager.buttonTextColor,
      round: Constants.Radius.cornerRadiusCard)
  }

  private func applyThemeCardView() {
    self.cardView.applyTheme(
      background: self.themeManager.cardBackgroundColor,
      border: self.themeManager.cardBackgroundColor,
      radius: Constants.Radius.cornerRadiusCard)
  }

  private func applyThemeImageView() {
    self.imageMovie.applyTheme(
      background: self.themeManager.cardBackgroundColor,
      border: self.themeManager.cardBackgroundColor,
      radius: Constants.Radius.cornerRadiusCard)
  }

}
