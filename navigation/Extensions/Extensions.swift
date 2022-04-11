//
//  Extensions.swift
//  navigation
//
//  Created by Max Egorov on 3/31/22.
//

import UIKit

extension UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.repeatCount = 3
        animation.duration = 0.07
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}

extension String {
    
    var isValidEmail: Bool {
         let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
         let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
         return testEmail.evaluate(with: self)
      }
}

extension UIViewController {
    
    func openAlert(title: String,
                          message: String,
                          alertStyle: UIAlertController.Style,
                          actionTitles: [String],
                          actionStyles: [UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for (index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}
