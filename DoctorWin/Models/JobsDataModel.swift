//
//  JobsDataModel.swift
//  DoctorWin
//
//  Created by N517325 on 29/10/21.
//

import Foundation

struct JobCategoryModel: Codable {
    let category : String?
    let image : String?
    let id : Int?
}
struct JobCategoryResponseModel: Codable {
    let is_active: Bool?
    let jobResponse: [JobCategoryModel]?
    
}
