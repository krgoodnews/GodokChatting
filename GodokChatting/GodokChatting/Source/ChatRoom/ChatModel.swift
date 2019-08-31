//
//  ChatModel.swift
//  GodokChatting
//
//  Created by 국윤수 on 27/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import Foundation

class ChatModel: Codable {

  class Message: Codable {
    var userID: String?
    var imageURL: String?
  }

}
