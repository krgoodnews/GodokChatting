//
//  ZzalCollectionAPI.swift
//  GodokChatting
//
//  Created by 여정승 on 01/09/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa
import SwiftyJSON

enum ZzalCollectionAPI {
    case collection(type: CategoryListViewModel.ItemTypes)
}

extension ZzalCollectionAPI: Networkerable {
    var route: (method: HTTPMethod, url: URL) {
        return (.post, GodokChattingService.shared.apiURL
            .appendingPathComponent("Amathon")
            .appendingPathComponent("picture"))
    }

    var params: Parameters? {
        var params = Parameters()
        switch self {
        case .collection(let type):
//            params["type"] = "surprise"
            params["type"] = type.parameterString
            return params
        }
    }
}


class ZzalCollectionNetworer {
    static func request(type: CategoryListViewModel.ItemTypes) -> Single<JSON> {
        let api = ZzalCollectionAPI.collection(type: type)
        return Networker.request(api: api)
    }
}
