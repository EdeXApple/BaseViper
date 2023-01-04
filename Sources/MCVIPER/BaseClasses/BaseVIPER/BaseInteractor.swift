/*
Copyright, everisSL
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
open class BaseInteractor {
    ///
    public weak var basePresenter: BaseInteractorOutputProtocol?
    ///
    public required init() {}
}

// MARK: Parser
// FIX: ¿Por qué no lo metemos directamente en la clase?
extension BaseInteractor {
    
    /// <#Description#>
    public static func parseToBusinessModel<M: BaseBusinessModel, S: BaseServerModel>(parserModel: M.Type, serverModel: S?) -> M? {
        guard let serverModel = serverModel else {
            return nil
        }
        
        return M(serverModel: serverModel)
    }
    /// <#Description#>
    public static func parseArrayToBusinessModel < M: BaseBusinessModel,
                                          S: BaseServerModel > (parserModel: [M].Type, arrayServerModels: [S]?) -> [M]? {
        guard let arrayServerModels = arrayServerModels else {
            return nil
        }
        
        return arrayServerModels.map({ serverModel -> M in
            M(serverModel: serverModel)
        })
    }
}

// MARK: Web Service
extension BaseInteractor: BaseProviderDelegate {
    public func requestDone() {
        self.basePresenter?.asyncTaskStarted()
    }
    public func responseGet() {
        self.basePresenter?.asyncTaskFinished()
    }
    public func networkNotReachable() {
        self.basePresenter?.networkErrorHappened()
    }
}
