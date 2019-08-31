//
//  ZzalCollectionModel.swift
//  GodokChatting
//
//  Created by 여정승 on 01/09/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import ObjectMapper

class ZzalCollectionModel: Mappable {

    public private(set) var imageUrls: [String]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.imageUrls <- map["data"]
    }
}
