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
import MCVIPER

class CompanyBusinessModel: BaseBusinessModel {
    var name: String?
    var catchPhrase: String?
}

class AddressBusinessModel: BaseBusinessModel {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
}

class HomeBusinessModel: BaseBusinessModel {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: AddressBusinessModel?
    var phone: String?
    var website: String?
    var company: CompanyBusinessModel?
    
    override init() { super.init() }
    
    required init(serverModel: BaseServerModel?) {
        super.init(serverModel: serverModel)
        guard let serverModel = serverModel as? HomeServerModel else {
            return
        }
        self.id = serverModel.id
        self.name = serverModel.name
        self.username = serverModel.username
        self.email = serverModel.email
        self.address = BaseInteractor.parseToBusinessModel(parserModel: AddressBusinessModel.self, serverModel: serverModel.address)
        self.phone = serverModel.phone
        self.website = serverModel.website
        self.company = BaseInteractor.parseToBusinessModel(parserModel: CompanyBusinessModel.self, serverModel: serverModel.company)
    }
}
