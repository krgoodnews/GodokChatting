//
//  ChatRoomViewModel.swift
//  GodokChatting
//
//  Created by 국윤수 on 27/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

final class ChatRoomViewModel {

  // MARK: - Bindable

  var bindableMessages = Bindable<[ChatModel.Message]>()

  // MARK: - Methods

  func uploadImage(_ image: UIImage?) {
    guard let image = image else { return }
    bindableMessages.value?.append(ChatModel.Message())
  }

  init() {
    bindableMessages.value = []
  }
}
