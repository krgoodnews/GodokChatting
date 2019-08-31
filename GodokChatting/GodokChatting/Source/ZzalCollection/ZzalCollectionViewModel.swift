//
//  ZzalCollectionViewModel.swift
//  GodokChatting
//
//  Created by 국윤수 on 31/08/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class ZzalCollectionViewModel: ReactiveViewModelType {

    typealias InputType = Input
    typealias OutputType = Output

    struct Input {

        public let request = PublishRelay<Void>()
        public let selectedImg = PublishRelay<Int>()
    }

    struct Output {
        public let moveDetailPageObservable: Observable<ZzalDetailViewController>
    }

    public lazy var input: InputType = Input()
    public lazy var output: OutputType = {
        let selectedImgObservable = input.selectedImg
            .map { index -> ZzalDetailViewController in
                let viewModel = ZzalDetailViewModel()
                return ZzalDetailViewController(viewModel)
        }
        return Output(moveDetailPageObservable: selectedImgObservable)
    }()

    private let categoryType: CategoryListViewModel.ItemTypes!
    private let bag = DisposeBag()


    func uploadImage(_ image: UIImage?) {
        // TODO: Upload Image
        
    }


    init(categoryType: CategoryListViewModel.ItemTypes) {
        self.categoryType = categoryType

        input.request
            .flatMap { ZzalCollectionNetworer.request(type: categoryType) }
            .subscribe(onNext: { (json) in
                print("succ")
            }, onError: { (error) in
                print("error")
            }).disposed(by: bag)
    }
}
