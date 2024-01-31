# Five

<img width="120" height="120" src="https://github.com/989ksy/Five/assets/122261047/a1da73db-c862-4fa0-8ccb-8a3d3d56c74d">

</br>
</br>

**📸 타인과 공유하고 싶은 순간을 이미지와 텍스트 기반으로 공유하는 SNS 어플리케이션**


## Preview

**[회원가입 + 로그인 UI]**

![Five_Before_Last](https://github.com/989ksy/Five/assets/122261047/971a27e9-ceb8-4e62-92eb-7882da962694)


**[서비스 UI]**

![Five_After](https://github.com/989ksy/Five/assets/122261047/b27d956d-837d-42fc-b853-4b9fa653fbe2)

</br>

## 프로젝트

**개발기간** : 2023년 11월 17일 ~ 2023년 12월 17일

**개발인원**: 1인

**iOS 최소 지원버전**: 16.0 이상

**Package Dependency Manager**: Swift Package Manager


</br>

## 특징

- 회원가입, 로그인, 로그아웃, 회원탈퇴 기능
- 이미지, 텍스트를 포함한 포스트 등록 및 삭제
- 다른 유저의 포스트 조회 및 프로필 조회 가능
- 모든 포스트에 좋아요 표시 및 취소, 댓글 작성 및 삭제 기능
- 내 프로필 이미지 또는 이름 변경
- 해시태그 검색


</br>

## 스택

- `UIKit`, `CodeBaseUI`
- `Moya`, `Kingfisher`, `RxSWift`, `RxCocoa`, `SnapKit`
- `SwiftKeychainWrapper`, `YPImagePicker`, `IQKeyboardManager`
- `DiffableDatasource`, `CompositionalLayout`, `UISheetPresentation`
- `MVVM`, `Singleton`, `Input/Output`, `Repository Pattern`

</br>

## 구현기능

[**서비스**]

- **정규표현식**을 통해 이메일 및 비밀번호 입력값에 대한 유효성 검증
- **Alamofire Intercepter**를 통해 AccessToken 만료 시 keychain에 저장된 Refresh Token으로 갱신하는 **JWT 인증 로직** 구현
- 게시글 작성 시 **YPImagePicker** 라이브러리를 사용하여 이미지 커스텀 지원, 최대 5장까지 이미지 선택 및 해제 가능
- **Cursor-based pagination**을 활용하여 게시글 중복을 방지한 피드 목록 구현  
- **Compositional Layout**을 사용해서 각 이미지 비율에 대응하는 UICollectionView 구현 및 메모리 사용량 개선

[**그외**]

- **Moya**의 **Router Pattern**으로 네트워크 통신을 구현하여 유지보수에 용이한 로직 추상화
- **RxSwift**와 **MVVM Input/Output 패턴**을 사용하여 비즈니스 로직 분리 및 코드 구조 일관성 유지
  
</br>

 ## 트러블 슈팅

### 1. RxSwift로 구현한 컬렉션뷰 cell 이벤트 구독

#### [문제사항]

피드 화면에서 유저의 닉네임을 탭하여 프로필 화면으로 전환하고자 할 때, 버튼 탭 이벤트가 여러 번 발생하며 화면 전환이 연속해서 일어남


#### [해결방안]

i. subcribe으로 발생하는 이벤트를 viewController에 구현한 disposeBag으로 해당 stream을 해제하려고 함

ii. 이벤트가 중복으로 구독되어 해당 문제가 발생했기 때문에 각 셀에 대해 이벤트를 구독할 때, 해당 셀이 재사용되기 전에 이전에 생성된 구독을 해제하고자 함

iii. 각 셀의 prepareForReuse 메소드 내에서 disposeBag을 새로 할당함으로써 이전 구독을 모두 해제하고, 셀이 재사용될 때마다 이벤트를 새로 구독 할 수 있도록 구현함


``` swift

override func prepareForReuse() {
      super.prepareForReuse()
      disposeBag = DisposeBag()
  }
      
            
```


``` swift

cell.nicknameButton
    .rx
    .tap
    .subscribe(with: self) { owner, _ in

        let vc = ProfileViewController()
                      
        vc.FeedUserId = element.creator.id
        vc.FeedUserProfile = element.creator.profile
        vc.type = .selectedUser
                      
        self.navigationController?.pushViewController(vc, animated: true)

}
.disposed(by: cell.disposeBag)
            
```


### 2. 이미지 비율로 dynamic collectionView 구현

#### [문제사항]

해시태그 검색 화면을 Compositional Layout을 활용하여 이미지 비율에 기반한 UI로 기획

i. kingfisher는 이미지를 비동기로 로딩하기 때문에 이미지가 로드되기 전에는 정확한 셀의 크기를 결정할 수 없음
ii. Compositional Layout이 레이아웃을 결정하는 시점과 이미지가 완전히 다운로드되는 시점 불일치로 인해 다운로드 된 이미지의 비율로 레이아웃을 잡을 수 없었음

#### [문제해결]

게시글 등록 시 이미지의 비율을 서버로 보내서 Compositional Layout이 레이아웃을 잡을 때 해당 비율을 사용하여 시점 문제 없이 셀의 크기를 잡을 수 있도록 로직 구현

i. 서버에 이미지 비율 보내기

``` swift

let value = Observable.combineLatest (
            input.images,
            text
        )

input.uploadTap
        .throttle(.seconds(1), scheduler: MainScheduler.instance)
        .withLatestFrom(value, resultSelector: { _, value in
            return value
        })
        .map { value in
            let datas = value.0
            let text = value.1
            
            let preview = datas.first ?? Data()
            let image = UIImage(data: preview) ?? UIImage()
            let imageSize = image.size //이미지 사이즈 정의
            let ratio = imageSize.width / imageSize.height //이미지의 비율을 구함
            
            return (images: datas, text: text, ratio: ratio)
        }
        .flatMap {
            APIManager.shared.createPost(
                content: $0.text,
                file: $0.images,
                productID: "Five_Feed",
                content1: "\($0.ratio)" //게시글 등록 시 비율을 서버에 보냄
            )
        }
        .subscribe(with: self) { owner, result in
            
            switch result {
            case .success(let response):
                isSucceeded.onNext(true)
                
            case .failure(let failure):
                isSucceeded.onNext(false)
            }
        }
        .disposed(by: disposeBag)
```

ii. Compositional Layout 잡을 때 서버에 보낸 비율을 활용하여 Dynamic collectionView 형태의 레이아웃을 잡음

``` swift

func fetchAllData() {
        
        viewModel.fetchReadData { response in
            
            switch response {
                
            case .success(let success):
                self.fetchData = success.data
                
                let ratios = success.data.map{
                    Ratio(ratio: Double($0.ratio ?? "") ?? 1.0)
                } // 서버에 보낸 비율
                
                let layout = PinterestLayout(
                    columnsCount: 2,
                    itemRatios: ratios, // 서버에 보낸 이미지 비율로 레이아웃 잡음
                    spacing: 10,
                    contentWidth: self.view.frame.width
                )
                
                self.exploreCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                
                self.snapshot()
                                
            case .failure(let failure):
                print("fetchAllData failed",failure.rawValue)
                print(failure.errorDescription!)
            }
        }
        
    }

```


 </br>

 ## 회고

- RxSwift을 사용하며 MVVM과 Input/Output Pattern을 모두 적용시켜 본 프로젝트였습니다. 
