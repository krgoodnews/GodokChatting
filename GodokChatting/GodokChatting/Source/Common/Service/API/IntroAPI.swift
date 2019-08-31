//
//  IntroAPI.swift
//  GodokChatting
//
//  Created by 여정승 on 29/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Alamofire
import RxCocoa
import RxSwift
import SwiftyJSON

enum IntroAPI {
    case versionCheck(String)
    case imageEx(image: UIImage, imageName: String, imageType: ImageType)
}

extension IntroAPI: Networkerable {
    var route: (method: HTTPMethod, url: URL) {
        switch self {
        case .versionCheck:
            // http:apiURL/1/2
            return (.get, GodokChattingService.shared.apiURL
                .appendingPathExtension("1")
                .appendingPathExtension("2"))
        case .imageEx:
            // http:apiURL/1/2
            return (.post, GodokChattingService.shared.apiURL
                .appendingPathExtension("3")
                .appendingPathExtension("4"))
        }
    }

    var params: Parameters? {
        var params = Parameters()
        switch self {
        case .versionCheck(let userID):
            params[""] = userID
        case .imageEx(_, let imageName, _):
            params["imageName"] = imageName
        }
        return params
    }
}

class IntroNetworker: NSObject {
    static func request() -> Single<JSON> {
        let api = IntroAPI.versionCheck("TestID")
        return Networker.request(api: api)
    }

    static func imageExRequest(image: UIImage, name: String, imageType: ImageType) -> Single<JSON> {
        let api = IntroAPI.imageEx(image: image,
                                   imageName: name,
                                   imageType: imageType)

        return Networker.uploadImage(api: api,
                                     image: image,
                                     imageName: name,
                                     imageType: imageType)
    }
}
