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

- **정규표현식**을 통해 이메일 및 비밀번호 입력값에 대한 유효성 검증
- **Alamofire Intercepter**를 통해 AccessToken 만료 시 keychain에 저장된 Refresh Token으로 갱신하는 **JWT 인증 로직** 구현
- **Kingfisher**의 **AnyModifier**로 이미지 캐싱 및 다운로드 구현
- 게시글 작성 시 **YPImagePicker** 라이브러리를 사용하여 이미지 커스텀 지원, 최대 5장까지 이미지 선택 및 해제 가능
- **Cursor-based pagination**을 활용하여 게시글 중복을 방지한 피드 목록 구현  
- **Compositional Layout**을 사용해서 각 이미지 비율에 대응하는 UICollectionView 구현 및 메모리 사용량 개선

- **Moya**의 **Router Pattern**으로 네트워크 통신을 구현하여 유지보수에 용이한 로직 추상화
- **enum**으로 네트워크 에러 세분화 및 대응
- **RxSwift**와 **MVVM Input/Output 패턴**을 사용하여 비즈니스 로직 분리 및 코드 구조 일관성 유지
- **Access Control**의 **private**과 **final** 키워드를 통해 Swift 성능 최적화
  
</br>

 ## 트러블 슈팅

### 1. 피드 업데이트

#### [문제사항]



#### [해결방안]


``` swift

      
            
```


### 2. Token 갱신

#### [문제사항]



#### [문제해결]



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
                let imageSize = image.size
                let ratio = imageSize.width / imageSize.height
                
                return (images: datas, text: text, ratio: ratio)
            }
            .flatMap {
                APIManager.shared.createPost(
                    content: $0.text,
                    file: $0.images,
                    productID: "Five_Feed",
                    content1: "\($0.ratio)"
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

 </br>

 ## 회고

 - RxSwift를 중점으로 사용하며 MVVM과 In/Out Pattern을 처음 적용시켜 본 프로젝트였던 만큼 최대한 RxSwift로 로직을 구현하고자 했습니다.
