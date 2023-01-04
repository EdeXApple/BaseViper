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

// FIX: ¿NSError y no Error?
open class BaseErrorModel: NSError {
	
    public var type: String = "Backend"
	public var internalCode: String = ""
	public var presentationMessage = ""
    
    public var originalObject: Any?
    
    public var httpClientError = HTTPClientError(code: -1)
    public var backendError = BackendError(code: "", serverMessage: "")
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(httpClientError: HTTPClientError.ErrorType, backendError: BackendError.ErrorType) {

        self.httpClientError = HTTPClientError(code: httpClientError.rawValue)
        self.backendError = BackendError(code: backendError.rawValue, serverMessage: "")
        let defaultDomain = "error_generic"
        self.presentationMessage = self.backendError.errorText

        super.init(domain: defaultDomain, code: self.httpClientError.type.rawValue, userInfo: nil)
    }
    
    public init(data: Data?, httpCode: Int?) {
        
        self.httpClientError = HTTPClientError(code: httpCode ?? -1)
        
        let defaultDomain = "error_generic"
        let defaultCode = self.httpClientError.type.rawValue
        
        guard let data = data else {
            super.init(domain: defaultDomain, code: defaultCode, userInfo: nil)
            self.presentationMessage = defaultDomain
            return
        }
        
        if  let errorServerModel = try? JSONDecoder().decode(ErrorServerModel.self, from: data) {
            
            let errorModel = ErrorModel(serverModel: errorServerModel)
            let domain = defaultDomain
            super.init(domain: domain,
                       code: defaultCode,
                       userInfo: nil)
            self.presentationMessage = defaultDomain
            self.originalObject = errorModel
            self.internalCode = errorModel.errorCode ?? ""
            
            self.backendError = BackendError(code: errorModel.errorCode ?? "",
                                             serverMessage: domain)
            
            return
        }
        
        super.init(domain: defaultDomain, code: defaultCode, userInfo: nil)
        self.presentationMessage = self.backendError.errorText
    }
    
    public init(error: Error?) {
        
        guard let error = error as NSError? else {
        
            self.httpClientError = HTTPClientError(code: HTTPClientError.ErrorType.unknownError.rawValue)
            self.backendError = BackendError(code: BackendError.ErrorType.unknownError.rawValue,
                                             serverMessage: "unknown")
            let defaultDomain = ""
            self.presentationMessage = self.backendError.errorText

            super.init(domain: defaultDomain, code: self.httpClientError.type.rawValue, userInfo: nil)
            
            return
        }
    
        self.httpClientError = HTTPClientError(code: error.code)
        self.backendError = BackendError(code: BackendError.ErrorType.unknownError.rawValue,
                                         serverMessage: "unknown")
        let defaultDomain = ""
        self.presentationMessage = self.backendError.errorText

        super.init(domain: defaultDomain, code: self.httpClientError.type.rawValue, userInfo: nil)
    }
    
    public convenience init(_ type: HTTPClientError.ErrorType) {
        self.init(httpClientError: type, backendError: BackendError.ErrorType.unknownError)
    }
}
