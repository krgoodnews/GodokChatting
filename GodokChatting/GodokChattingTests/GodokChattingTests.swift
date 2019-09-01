//
//  GodokChattingTests.swift
//  GodokChattingTests
//
//  Created by 여정승 on 01/09/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import XCTest
@testable import RxSwift
@testable import RxCocoa
@testable import GodokChatting
@testable import SwiftyJSON
@testable import RxBlocking
@testable import RxTest
@testable import ObjectMapper

class GodokChattingTests: XCTestCase {

    var api: ZzalCollectionAPI!
    var model: ZzalCollectionModel?

    override func setUp() {
        api = ZzalCollectionAPI.collection(type: .angry)
    }

    func testGetCollection() {

        XCTAssertEqual(api.route.url.absoluteURL, GodokChattingService.shared.apiURL
            .appendingPathComponent("Amathon")
            .appendingPathComponent("picture"))
        XCTAssertEqual(api.route.method, .post)

        do {
            let requester: Single<JSON> = ZzalCollectionNetworer.request(type: .angry)
            let response = try requester.toBlocking().first()

            guard let json = response?.dictionaryObject else {
                XCTFail()
                return
            }
            model = Mapper<ZzalCollectionModel>().map(JSON: json)
            XCTAssertNotNil(model)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

}
