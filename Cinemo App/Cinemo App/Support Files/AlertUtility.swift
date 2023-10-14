//
//  AlertUtility.swift
//  Cinemo App
//
//  Created by Tanatip Denduangchai on 10/14/23.
//

import UIKit

class AlertUtility {

    // MARK: - Alert with OK Button

    static func showAlert(on viewController: UIViewController, title: String?, message: String?, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Alert with OK and Cancel Buttons

    static func showConfirmationAlert(on viewController: UIViewController, title: String?, message: String?, okButtonTitle: String = "OK", cancelButtonTitle: String = "Cancel", okCompletion: (() -> Void)? = nil, cancelCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
            okCompletion?()
        }
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            cancelCompletion?()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Action Sheet

    static func showActionSheet(on viewController: UIViewController, title: String?, message: String?, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            alertController.addAction(action)
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension Constants {
    enum Alert {
        static let okButtonTitle = "OK"
        static let cancelButtonTitle = "Cancel"
    }
}
