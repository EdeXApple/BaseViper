/*
Copyright, EdexApple
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation
import UIKit

public protocol LoaderProtocol: AnyObject {
    func start()
    func stop()
}

open class BaseViewController: UIViewController {
    
    public static var loader: LoaderProtocol?
    public var basePresenter: BasePresenterProtocol?
    public var isFirstPresentation: Bool = true
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.basePresenter?.viewDidLoad()
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.basePresenter?.viewWillAppear(isFirstPresentation: self.isFirstPresentation)
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isFirstPresentation = false
        
        self.basePresenter?.viewDidAppear(isFirstPresentation: self.isFirstPresentation)
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Loader
    public func showLoading(fullScreen: Bool) {
       self.showLoader()
    }
    public func hideLoading() {
       self.hideLoader()
    }
    private func showLoader() {
        guard let viewController = Self.loader as? UIViewController else {
            return
        }

        DispatchQueue.main.async {
            if !viewController.isBeingPresented {
                viewController.modalPresentationStyle = .overFullScreen
                viewController.modalTransitionStyle = .crossDissolve
                (viewController as? LoaderProtocol)?.start()
                self.present(viewController, animated: false, completion: nil)
            }
        }
    }
    
    private func hideLoader() {
        guard let viewController = Self.loader as? UIViewController else {
            return
        }
        DispatchQueue.main.async {
            (viewController as? LoaderProtocol)?.stop()
            viewController.dismiss(animated: false, completion: nil)
        }
    }
}

// MARK: BaseViewControllerProtocol
extension BaseViewController: BaseViewControllerProtocol {}
