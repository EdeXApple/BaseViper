//
//  BaseViewController+Extension.swift
//  BaseVIPER
//
//  Created by Jose Antonio Romero Dueñas on 12/5/22.
//

import ComponentUIKit
import Foundation
import MCVIPER
import UIKit

extension BaseViewProtocol {
    func showToast(viewModel: ToastViewModel) {
        guard let toast = ToastView.initFromNib() else {
            return
        }
        toast.configure(viewModel: viewModel)
        UIApplication.shared.currentUIWindow()?.addSubviewWithConstraintsWithoutBottom(
            UIEdgeInsets(top: 40, left: 24, bottom: 0, right: -24),
            subView: toast)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            toast.removeFromSuperview()
        }
    }
}

extension BaseViewController {
}
