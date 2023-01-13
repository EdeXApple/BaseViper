/*
Copyright, EDEXApple
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

// swiftlint:disable missing_docs
/// <#Description#>
open class BaseAssembly {

    @discardableResult
    /// <#Description#>
    /// - Returns: <#description#>
    public static func assembly < V: BaseViewControllerProtocol,
                                  P: BasePresenter,
                                  R: BaseRouter,
                                  I: BaseInteractor > (baseView: V,
                                                       presenter: P.Type,
                                                       router: R.Type,
                                                       interactor: I.Type) -> (view: V,
                                                                               presenter: P,
                                                                               interactor: I,
                                                                               router: R) {
        
        let basePresenter = P()
        let baseRouter = R()
        let baseInteractor = I()
        
        baseView.basePresenter = basePresenter as? BasePresenterProtocol
        
        basePresenter.baseView = baseView as? BaseViewProtocol
        basePresenter.baseRouter = baseRouter as? BaseRouterProtocol
        basePresenter.baseInteractor = baseInteractor as? BaseInteractorInputProtocol

        baseRouter.baseView = baseView as? UIViewController
        baseRouter.delegate = basePresenter

        baseInteractor.basePresenter = basePresenter as? BaseInteractorOutputProtocol

        return (baseView, basePresenter, baseInteractor, baseRouter)
    }
}
