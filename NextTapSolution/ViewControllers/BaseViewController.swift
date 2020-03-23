//
//  BaseViewController.swift
//  NextTapSolution
//
//  Created by Hyubyn on 3/22/20.
//  Copyright © 2020 Curly Bracers. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    func processError(error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
