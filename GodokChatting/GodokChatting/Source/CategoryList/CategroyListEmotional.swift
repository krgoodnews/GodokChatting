//
//  CategroyListHeader.swift
//  GodokChatting
//
//  Created by 여정승 on 01/09/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

class CategroyListEmotional: UICollectionReusableView {

    static let reigsterID = "\(CategroyListEmotional.self)"

    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "<감정별>"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setup() {
        addSubviews(title)


    }

    private func setupUI() {
        title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(42)
        }
    }
}
