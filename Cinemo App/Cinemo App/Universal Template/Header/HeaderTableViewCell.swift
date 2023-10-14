//
//  HeaderTableViewCell.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import UIKit

// MARK: - HeaderTableViewCell

class HeaderTableViewCell: UITableViewHeaderFooterView {

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

  // MARK: Internal

  @IBOutlet weak var headerLabel: UILabel!

  // MARK: Private

  private lazy var themeManager = ThemeManager.currentTheme()

}

// MARK: ApplyTheme

extension HeaderTableViewCell: ApplyTheme {
  func applyTheme() {
    self.applyLabel()
    self.applyBackground()
  }

  func applyLabel() {
    self.headerLabel.applyTheme(font: .systemFont(ofSize: 14), color: self.themeManager.subtitleTextColor)
  }

  func applyBackground() {
    self.contentView.backgroundColor = .white
  }

}
