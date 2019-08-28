//
//  Networker.swift
//  GodokChatting
//
//  Created by 여정승 on 27/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import UIKit

protocol Networkerable {
    var route: (method: HTTPMethod, url: URL) { get }
    var params: Parameters? { get }
}

public enum NetworkerError: Int, Swift.Error {
    // 서버에서 내려주는 Error Code

    // 마이너스 에러 - 네이티브 에러 - 내가 만든 Error Code
    case imageFormatError = -995 // 이미지 data 변환 실패
    case dataParsingError = -996 // 데이타 set 실패
    case jsonParsingError = -997 // JSON 파싱 실패
    case urlParsingError = -998 // url 파싱 실패
    case unknownError = -999 // 알 수 없는 에러
}

public enum APIResult {
    case success(JSON)
    case failure(Error)
}

enum ImageType {
    case jpg
    case png
    case jpeg

    var type: String {
        switch self {
        case .jpg:
            return "jpg"
        case .png:
            return "png"
        case .jpeg:
            return "jpeg"
        }
    }
}

class Networker: NSObject {

    // json 타입 reuqest
    static func request(api: Networkerable, _ parameterEncoding: ParameterEncoding? = nil) -> Single<JSON> {
        return sendRequest(api: api, parameterEncoding: parameterEncoding)
    }

    private static func sendRequest(api: Networkerable, parameterEncoding: ParameterEncoding?) -> Single<JSON> {
        let request = Single<JSON>.create { (single) -> Disposable in
            sendRequestDefault(url: api.route.url.absoluteString,
                               method: api.route.method,
                               params: api.params,
                               parameterEncoding: parameterEncoding,
                               header: nil,
                               callback: { (HTTPStatus, result) in
                                print("Http StatusCode : { \(HTTPStatus?.statusCode ?? -999) }")
                                switch result {
                                case .success(let json):
                                    print("JSON : { \(json) }")
                                    single(.success(json))
                                case .failure(let error):
                                    print("ERROR: { \(error.localizedDescription) }")
                                    single(.error(error))
                                }
            })
            return Disposables.create()
        }
        return request
    }

    private static func sendRequestDefault(url: String, method: HTTPMethod, params: Parameters?, parameterEncoding: ParameterEncoding?, header: HTTPHeaders?, callback: ((HTTPURLResponse?, APIResult) -> Void)?) {

        let url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

        var encoding = parameterEncoding

        if method == .post {
            encoding = JSONEncoding.default
        } else if encoding == nil {
            encoding = URLEncoding.default
        }

        var requestHeader = header
        if requestHeader == nil {
            requestHeader = GodokChattingService.shared.commonHeader
        }

        guard let urlString = url, let requestURL = URL(string: urlString) else {
            callback?(nil, .failure(NetworkerError.urlParsingError))
            return
        }
        

        AF.request(requestURL,
                   method: method,
                   parameters: params,
                   encoding: encoding!,
                   headers: requestHeader)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    if let dictionary = data as? [String: Any] {
                        let json = JSON(dictionary)
                        callback?(response.response, .success(json))
                    } else if let dictionnarys = data as? [[String: Any]] {
                        let jsonArray = JSON(dictionnarys)
                        callback?(response.response, .success(jsonArray))
                    } else {
                        if let statusCode = response.response?.statusCode, let reason = NetworkerError(rawValue: statusCode) {
                            callback?(response.response, .failure(reason))
                        } else {
                            callback?(response.response, .failure(NetworkerError.jsonParsingError))
                        }
                    }
                case .failure(let error):
                    if let statusCode = response.response?.statusCode,
                        let reason = NetworkerError(rawValue: statusCode) {
                        callback?(response.response, .failure(reason))
                    } else {
                        callback?(response.response, .failure(error))
                    }
                }
        }
    }

    // image request
    static func uploadImage(api: Networkerable,  _ parameterEncoding: ParameterEncoding? = nil, image: UIImage, imageName: String, imageType: ImageType) -> Single<JSON> {
        return sendRequestImage(api: api,
                                image: image,
                                imageName: imageName,
                                imageType: imageType)
    }

    static func sendRequestImage(api: Networkerable,  _ parameterEncoding: ParameterEncoding? = nil, image: UIImage, imageName: String, imageType: ImageType) -> Single<JSON> {
        let request = Single<JSON>.create { (single) -> Disposable in
            uploadPhoto(api.route.url.absoluteString,
                        image: image,
                        imageName: imageName,
                        imageType: imageType,
                        params: api.params,
                        callback: { (HTTPStatus, result) in
                        print("Http StatusCode : { \(HTTPStatus?.statusCode ?? -999) }")
                            switch result {
                            case .success(let json):
                                print("JSON : { \(json) }")
                                single(.success(json))
                            case .failure(let error):
                                print("ERROR: { \(error.localizedDescription) }")
                                single(.error(error))
                            }
            })

            return Disposables.create()
        }
        return request
    }

    static func uploadPhoto(_ url: String, image: UIImage, imageName: String, imageType: ImageType, params: [String : Any]?, callback: ((HTTPURLResponse?, APIResult) -> Void)?) {

        let httpHeaders = GodokChattingService.shared.commonHeader
        let url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

        guard let urlString = url, let requestURL = URL(string: urlString) else {
            callback?(nil, .failure(NetworkerError.urlParsingError))
            return
        }

        AF.upload(multipartFormData: { multiPart in
            guard let params = params else { return }
            for p in params {
                guard let multiPartdata = "\(p.value)".data(using: String.Encoding.utf8) else {
                    callback?(nil, .failure(NetworkerError.dataParsingError))
                    return
                }
                multiPart.append(multiPartdata, withName: p.key)
            }
            guard let imageFormat = imageType == .png ? image.pngData() : image.jpegData(compressionQuality: 0.4) else {
                callback?(nil, .failure(NetworkerError.imageFormatError))
                return
            }
            multiPart.append(imageFormat,
                             withName: imageName,
                             fileName: "\(imageName).\(imageType.type)",
                mimeType: "image/\(imageType.type)")

        }, to: requestURL, method: .post, headers: httpHeaders)
            .uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }).validate(statusCode: 200 ..< 300)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    if let dictionary = data as? [String: Any] {
                        let json = JSON(dictionary)
                        callback?(response.response, .success(json))
                    } else if let dictionnarys = data as? [[String: Any]] {
                        let jsonArray = JSON(dictionnarys)
                        callback?(response.response, .success(jsonArray))
                    } else {
                        if let statusCode = response.response?.statusCode, let reason = NetworkerError(rawValue: statusCode) {
                            callback?(response.response, .failure(reason))
                        } else {
                            callback?(response.response, .failure(NetworkerError.jsonParsingError))
                        }
                    }
                case .failure(let error):
                    if let statusCode = response.response?.statusCode,
                        let reason = NetworkerError(rawValue: statusCode) {
                        callback?(response.response, .failure(reason))
                    } else {
                        callback?(response.response, .failure(error))
                    }
                }
            })
    }
}

public class GodokChattingService: NSObject {

    public struct RequestInfo {
        let url: String
        let method: HTTPMethod
        let params: Parameters?
        let paramsEncoding: ParameterEncoding?
    }

    let appBuildVersion: String? = Bundle.main.object(forInfoDictionaryKey: (kCFBundleVersionKey as String)) as? String
    let appShortVersion: String? = Bundle.main.object(forInfoDictionaryKey: ("CFBundleShortVersionString")) as? String

    public var commonHeader: HTTPHeaders {
        var headers = HTTPHeaders()
        return headers
    }

    private var apiHost: String {
        return ""
    }

    public var apiURL: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiHost
        return components.url!
    }

    public static let shared = GodokChattingService()

    private override init() {
        super.init()
    }
}
