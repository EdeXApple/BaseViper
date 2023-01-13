//
//  ServerStatusModel.swift
//  BaseVIPER
//
//  Created on 24/3/22.
//

import Foundation

struct ServerStatusModel: BaseServerModel {
    let status: String?
    let detail: String?
    
    init(status: String, detail: String) {
        self.status = status
        self.detail = detail
    }
    
    init(model: ServerStatusGenericErrorModel) {
        self.status = model.status
        self.detail = model.detail
    }
}
