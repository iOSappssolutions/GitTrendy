//
//  UIViewController+Alerts.swift
//  GitTrendyUIKit
//
//  Created by Miroslav Djukic on 20/09/2020.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    class func displaySpinner() -> UIView {
        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = spinnerView.bounds
        var ai: UIActivityIndicatorView
    
        ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(blurredEffectView)
            spinnerView.addSubview(ai)
            
            guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
            keyWindow.addSubview(spinnerView)
            keyWindow.bringSubviewToFront(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
