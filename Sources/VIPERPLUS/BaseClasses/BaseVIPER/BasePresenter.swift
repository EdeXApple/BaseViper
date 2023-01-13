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

import UIKit

/// <#Description#>
open class BasePresenter {
    
    ///
    public weak var baseView: BaseViewProtocol?
    ///
    public var baseRouter: BaseRouterProtocol?
    ///
	public var baseInteractor: BaseInteractorInputProtocol?
    
    /// <#Description#>
	public required init() {}
}

// MARK: BaseInteractorOutputProtocol
extension BasePresenter {
    /// Method to convert businessModel in viewModel
    public static func parseToViewModel<Model: BaseViewModel, BusinessModel: BaseBusinessModel>(parserModel: Model.Type,
                                                                                                businessModel: BusinessModel?) -> Model? {
        guard let businessModel = businessModel else {
            return nil
        }
        
        return Model(businessModel: businessModel)
    }
    
    /// Method to convert an array of businessModel in array of viewModel
    public static func parseArrayToViewModel<Model: BaseViewModel, BusinessModel: BaseBusinessModel>(parserModel: [Model].Type,
                                                                                                     businessModel: [BusinessModel]?) -> [Model]? {
        guard let arrayBusinessModels = businessModel else {
            return nil
        }
        
        return arrayBusinessModels.map { businessModel -> Model in
            Model(businessModel: businessModel)
        }
    }
    /// <#Description#>
    public func asyncTaskStarted() {
        self.baseView?.showLoading(fullScreen: true)
    }
    
    /// <#Description#>
    public func asyncTaskFinished() {
        self.baseView?.hideLoading()
    }
}

extension BasePresenter: BaseRouterDelegate {
    public func navigationDone() {}
}
