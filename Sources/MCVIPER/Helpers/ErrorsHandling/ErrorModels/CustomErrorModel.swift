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

import Foundation

public class CustomErrorModel: NSError {
    
    public var type: String = "Backend"
    var internalCode: String = ""
    var presentationMessage = ""
    var originalObject: Any?
    
    var httpClientError = HTTPClientError(code: HTTPClientError.ErrorType.unknownError.rawValue)
    var backendError = BackendError(code: "", serverMessage: "")
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(httpClientError: HTTPClientError.ErrorType, backendError: BackendError.ErrorType) {

        self.httpClientError = HTTPClientError(code: httpClientError.rawValue)
        self.backendError = BackendError(code: backendError.rawValue, serverMessage: "")
        let defaultDomain = "generic"
        self.presentationMessage = self.backendError.errorText

        super.init(domain: defaultDomain, code: self.httpClientError.type.rawValue, userInfo: nil)
    }
    
    init(data: Data?, httpCode: Int?) {

        self.httpClientError = HTTPClientError(
            code: httpCode ?? HTTPClientError
                .ErrorType
                .unknownError
                .rawValue)
        
        let defaultDomain = "generic"
        let defaultCode = self.httpClientError.type.rawValue
        
        guard let data = data else {
            super.init(domain: defaultDomain, code: defaultCode, userInfo: nil)
            self.presentationMessage = defaultDomain
            return
        }
        
        if  let errorLoginModelModel = try? JSONDecoder().decode(ErrorServerModel.self, from: data) {
            
            let errorLoginModel = ErrorModel(serverModel: errorLoginModelModel)
            let domain = errorLoginModel.state?.detail ?? defaultDomain
            super.init(domain: domain,
                       code: defaultCode,
                       userInfo: nil)
            self.backendError = BackendError(code: errorLoginModel.state?.status ?? "",
                                             serverMessage: errorLoginModel.state?.detail ?? "")
            self.presentationMessage = backendError.serverMessage
            self.originalObject = errorLoginModel
            self.internalCode = errorLoginModel.state?.status ?? ""
            
            self.backendError = BackendError(code: errorLoginModel.state?.status ?? "",
                                             serverMessage: errorLoginModel.state?.detail ?? "")
            if presentationMessage.isEmpty {
                presentationMessage = "unknown"
            }
            return
        }
        
        super.init(domain: defaultDomain, code: defaultCode, userInfo: nil)
        self.presentationMessage = self.backendError.serverMessage
    }
    
    public init(withCustomMessage message: String,
                code: Int = HTTPClientError
                    .ErrorType
                    .unknownError
                    .rawValue) {
        super.init(domain: "", code: code, userInfo: nil)
        self.presentationMessage = message
    }
}
