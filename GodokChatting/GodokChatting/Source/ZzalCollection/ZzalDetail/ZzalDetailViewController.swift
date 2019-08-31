//
//  ZzalDetailViewController.swift
//  GodokChatting
//
//  Created by 여정승 on 01/09/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class ZzalDetailViewController: BaseViewController {

    lazy var zzalDetailView: ZzalDetailView = ZzalDetailView(frame: view.bounds)

    private var viewModel: ZzalDetailViewModel!

    convenience init( _ viewModel: ZzalDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        view = zzalDetailView

      zzalDetailView.imageView.kf.setImage(with: URL(string: viewModel.imageURL ?? ""))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
    }

    @objc private func didTapSave() {
      guard let image = zzalDetailView.imageView.image else { return }
      UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    } else {
      UIAlertController.alert(message: "사진을 저장했습니다", defaultString: "확인").show(self)
    }
  }

    override func bind() {
        super.bind()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
