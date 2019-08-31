//
// Created by 국윤수 on 31/08/2019.
// Copyright (c) 2019 국윤수. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class CategoryListViewModel: ReactiveViewModelType {

    typealias InputType = Input
    typealias OutputType = Output

    struct Input {
        public let didSelectedItem = PublishRelay<(Int, Int)>()
    }

    struct Output {
        public let moveChatRoom = PublishRelay<ZzalCollectionViewController>()
    }

    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()

    private let bag = DisposeBag()

    enum SectionType: Int {
        case emotional = 0
        case person

        var itmes: [ItemTypes] {
            switch self {
            case .emotional:
                return [.joy, .angry, .love, .pain, .sad, .surprise]
            case .person:
                return []
            }
        }
    }

    enum ItemTypes: Int {
        case joy = 0
        case angry
        case love
        case pain
        case sad
        case surprise

        var title: String {
            switch self {
            case .joy:
                return "즐거움"
            case .angry:
                return "노여움"
            case .love:
                return "사랑"
            case .pain:
                return "고통"
            case .sad:
                return "슬픔"
            case .surprise:
                return "놀람"
            }
        }

        var parameterString: String {
            switch self {
            case .joy: return "funny"
            case .angry: return "angry"
            case .love: return "love"
            case .pain: return "pain"
            case .sad: return "sad"
            case .surprise: return "surprise"
            }
        }

        var image: UIImage? {
            switch self {
            case .joy:
                return UIImage(named: "joy")
            case .angry:
                return UIImage(named: "anger")
            case .love:
                return UIImage(named: "love")
            case .pain:
                return UIImage(named: "pain")
            case .sad:
                return UIImage(named: "sad")
            case .surprise:
                return UIImage(named: "surprise")
            }
        }
    }

    func header(_ section: Int) -> SectionType {
        return SectionType(rawValue: section)!
    }

//  categoryList

  func didSelectCategory(at indexPath: IndexPath) {

  }


    init() {

        input.didSelectedItem
            .subscribe(onNext: { [weak self] (section, index) in
                guard let self = self else { return }
                guard let section = SectionType(rawValue: section) else { return }
                let viewModel = ZzalCollectionViewModel(categoryType: section.itmes[index])
                self.output.moveChatRoom.accept(ZzalCollectionViewController(viewModel))
            }).disposed(by: bag)
    }
}
