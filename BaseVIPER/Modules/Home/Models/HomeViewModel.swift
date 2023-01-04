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

class HomeViewModel: BaseViewModel {
    
    var dataSource: [OptionCellViewModel]? = []
    var collectionDataSource: [OptionCollectionCellViewModel]? = []
    
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: String?
    var phone: String?
    var website: String?
    var company: String?
    
    override init() { super.init() }
    
    required init(businessModel: BaseBusinessModel?) {
        super.init(businessModel: businessModel)
        
        guard let businessModel = businessModel as? HomeBusinessModel else {
            return
        }
        self.id = businessModel.id
        self.name = businessModel.name
        self.username = businessModel.username
        self.email = businessModel.email
        self.address = "\(businessModel.address?.street ?? ""), \(businessModel.address?.suite ?? ""); \(businessModel.address?.city ?? "")"
        self.phone = businessModel.phone
        self.website = businessModel.website
        self.company = businessModel.company?.name
        
        for _ in 0...5 {
            let cellModel = OptionCellViewModel(labelName: self.username ?? "test")
            dataSource?.append(cellModel)
        }
        
        for _ in 0...5 {
            let cellModel = OptionCollectionCellViewModel(labelName: self.username ?? "test")
            collectionDataSource?.append(cellModel)
        }
    }
}
