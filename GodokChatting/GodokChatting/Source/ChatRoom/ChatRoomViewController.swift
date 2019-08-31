//
//  ChatRoomViewController.swift
//  GodokChatting
//
//  Created by 국윤수 on 27/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

import SnapKit
import Then

private let myMessageCellID = "myMessageCellID"
private let receivedMessageCellID = "receivedMessageCellID"

final class ChatRoomViewController: BaseViewController {

  // MARK: - View Model

  let viewModel = ChatRoomViewModel()

  // MARK: - View

  lazy var tableView = UITableView(frame: .zero).then {
    $0.delegate = self
    $0.dataSource = self
    $0.register(MyMessageCell.self, forCellReuseIdentifier: myMessageCellID)
    $0.backgroundColor = .groupTableViewBackground
    $0.separatorStyle = .none
  }

  lazy var chatBar = UIButton().then {
    $0.backgroundColor = .brown
    
    $0.addTarget(self, action: #selector(didTapChatBar), for: .touchUpInside)
  }

  // MARK: - View Logic

  @objc private func didTapChatBar() {
    print("didtapchatbar")
    handleSelectPhoto()
  }

  @objc private func handleSelectPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true)
  }

  // MARK: - Methods

  override func setup() {
    super.setup()

    view.addSubviews(tableView, chatBar)

    tableView.snp.makeConstraints {
      $0.top.left.right.equalToSuperview()
      $0.bottom.equalTo(chatBar.snp.top)
    }

    chatBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-48)
      $0.left.right.bottom.equalToSuperview()
    }
  }

  override func bind() {
    super.bind()

    viewModel.bindableMessages.bind { [unowned self] messages in
      self.tableView.reloadData()
    }
  }

}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: myMessageCellID) as! MyMessageCell
    cell.backgroundColor = .yellow

    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.bindableMessages.value?.count ?? 0
  }
}

extension ChatRoomViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    let image = (info[.originalImage] as? UIImage)
    viewModel.uploadImage(image)
    dismiss(animated: true)
  }

  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
}
