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
    }

    override func bind() {
        super.bind()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
