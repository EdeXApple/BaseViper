//
//  UIApplication+Extension.swift
//  BaseVIPERSample
//
//  Created by Jose Antonio Romero Dueñas on 12/5/22.
//

import Foundation
import UIKit

extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter({ element in
                element.activationState == .foregroundActive})
            .compactMap({ $0 as? UIWindowScene })
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
    }
}
