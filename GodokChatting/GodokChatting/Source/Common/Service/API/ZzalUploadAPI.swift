//
//  ZzalUploadAPI.swift
//  GodokChatting
//
//  Created by 국윤수 on 01/09/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift
import SwiftyJSON

enum ZzalUploadAPI {
  case upload(CategoryListViewModel.ItemTypes)
}

extension ZzalUploadAPI: Networkerable {
  var route: (method: HTTPMethod, url: URL) {
    return (.post, URL(string: "http://52.78.61.25:3000")!
      .appendingPathComponent("upload"))
  }

  var params: Parameters? {
    var params = Parameters()
    switch self {
    case .upload(let type):
      params["category"] = type.parameterString
      return params
    }
  }
}


class ZzalUploadNetworker {
  static func upload(type: CategoryListViewModel.ItemTypes, image: UIImage) -> Single<JSON> {
      let api = ZzalUploadAPI.upload(type)
    return Networker.uploadImage(api: api,
                                 image: image,
                                 imageName: "tempZZAL",
                                 imageType: .jpeg)
  }
}

