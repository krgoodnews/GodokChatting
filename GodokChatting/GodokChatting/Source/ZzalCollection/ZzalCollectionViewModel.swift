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
import ObjectMapper
import SwiftyJSON

enum UploadAPIState {
  case request
  case complete
  case error(Error?)
}

enum ZzalAPIState {
    case request
    case complete
    case error(Error?)
}

final class ZzalCollectionViewModel: ReactiveViewModelType {

    typealias InputType = Input
    typealias OutputType = Output

    private var delay: Int = 0

    struct Input {
        public let request = PublishRelay<Void>()
        public let selectedImg = PublishRelay<Int>()

        public let uploadRequest = PublishRelay<UIImage>()
    }

    struct Output {
        public let moveDetailPageObservable: Observable<ZzalDetailViewController>
        public let apiState = BehaviorRelay<ZzalAPIState>(value: .request)
      public let uploadImageState = BehaviorRelay<UploadAPIState>(value: .request)
    }

    public private(set) var model: ZzalCollectionModel?

    public lazy var input: InputType = Input()
    public lazy var output: OutputType = {
        let selectedImgObservable = input.selectedImg
            .map { index -> ZzalDetailViewController in
                let imgURL = self.model?.imageUrls?[index]
                let viewModel = ZzalDetailViewModel(imgURL)
                return ZzalDetailViewController(viewModel)
        }
        return Output(moveDetailPageObservable: selectedImgObservable)
    }()

    let categoryType: CategoryListViewModel.ItemTypes!
    private let bag = DisposeBag()


    func uploadImage(_ image: UIImage?) {
        // TODO: Upload Image
        
    }


    init(categoryType: CategoryListViewModel.ItemTypes) {
        self.categoryType = categoryType

        input.request
            .debounce(RxTimeInterval.seconds(delay), scheduler: MainScheduler.instance)
            .flatMap { _ -> Observable<JSON> in
                self.output.apiState.accept(.request)
                return ZzalCollectionNetworer.request(type: categoryType).asObservable() }
            .subscribe(onNext: { (json) in
                guard let json = json.dictionaryObject else { return }
                self.model = Mapper<ZzalCollectionModel>().map(JSON: json)
                self.delay = 3
                self.output.apiState.accept(.complete)
            }, onError: { (error) in
                print("error")
            }).disposed(by: bag)

      input.uploadRequest
        .map { image -> UIImage in
          return image
        }.flatMap { (image) -> Observable<JSON> in
          self.output.uploadImageState.accept(.request)
          return ZzalUploadNetworker.upload(type: self.categoryType, image: image).asObservable()
        }.subscribe(onNext: { [weak self] (json) in
          guard let self = self else { return }
          print("성공")
          self.output.uploadImageState.accept(.complete)
          }, onError: { [weak self] (error) in
            guard let self = self else { return }
            print("error : \(error.localizedDescription)")
            self.output.uploadImageState.accept(.error(error))
        }).disposed(by: bag)
    }

  private func upload(image: UIImage) {

  }
}
