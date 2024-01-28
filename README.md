# Five

![120](https://github.com/989ksy/Five/assets/122261047/208a9179-802a-463f-99d7-da79090197a7)

**📸 타인과 공유하고 싶은 순간을 이미지와 텍스트 기반으로 공유하고 공감 받을 수 있는 SNS 어플리케이션**


## Preview

**[회원가입 + 로그인 UI]**

![Five_Before_Last](https://github.com/989ksy/Five/assets/122261047/971a27e9-ceb8-4e62-92eb-7882da962694)


**[서비스 UI]**

![Five_After](https://github.com/989ksy/Five/assets/122261047/b27d956d-837d-42fc-b853-4b9fa653fbe2)

</br>

## 프로젝트

**개발기간** : 2023년 11월 17일 ~ 2023년 12월 17일

**개발인원**: 1인

**iOS 최소 지원버전**: 16 이상

**Package Dependency Manager**: Swift Package Manager


</br>

## 특징

- 회원가입, 로그인, 로그아웃, 회원탈퇴
- 이미지, 텍스트를 포함한 포스트 등록 및 삭제
- 모든 유저의 포스트 조회 및 프로필 조회
- 모든 포스트에 좋아요 표시 및 취소, 댓글 작성 및 삭제 기능
- 내 프로필 이미지 또는 이름 변경
- 해시태그 검색

</br>

## 스택

- `UIKit`, `RxSWift`, `RxCocoa`
- `CodeBaseUI`, `SnapKit`, `DiffableDatasource`, `CompositionalLayout`
- `Moya`, `Kingfisher`
- `SwiftKeychainWrapper`, `YPImagePicker`, `IQKeyboardManager`
- `MVVM`, `Singleton`, `Input/Output`, `Repository Pattern`

</br>

## 구현기능

- **회원가입 및 로그인**
  
  - 이메일 중복 API를 활용하여 이메일 중복 방지
  - 이메일 및 비밀번호 **정규표현식**을 통해 입력값에 대한 유효성 검증
  - Input-Output Pattern을 활용한 RxSwift 사용으로 일관된 코드 구조 아래 회원가입 및 로그인 로직 간소화

- **AccessToken 갱신**
  
  - `Alamofire Intercepter`를 통해 AccessToken 만료 시 Keychain에 저장된 Refresh Token으로 갱신하는 JWT 인증 로직 구현

- **포스트 작성 및 조회**
  
  - YPImagePicker 라이브러리를 사용하여 이미지 크기 조절 및 필터 등의 이미지 커스텀 지원, 최대 5장까지 이미지 선택 및 해제 가능
  - Cursor-based pagination를 통해 더보기 기능 없이 모든 유저의 게시글을 중복 없이 로드, 자연스러운 스크롤 경험 지원
  - RxSwift cellIdentifier로 collectionView 표현 및 modelSelected를 활용하여 데이터 전달
  - MVVM과 Input-Output Pattern으로 비즈니스 로직 구분
 
- **해시태그 검색**
  
  - 다양한 이미지 비율에 대응하는 레이아웃을 제공하기 위해 DiffableDatasource와 Compositional Layout을 활용하여 UICollectionView 구현
    -  Compositional Layout으로 하나의 컬렉션뷰에 여러 layout을 구성하여 관련 구조와 코드 간결화, 메모리 사용량 개선
 
  
</br>

 ## 트러블 슈팅

### 1. multipart/form-data으로 반환하여 서버에 이미지 전송 및 받기

#### [문제사항 1-1]

String 또는 Int 값처럼 단순한 데이터로 보냈을 때처럼 Data타입으로 encoding을 해야하는 이미지를 string값으로 서버에 전송할 수 없었다.

#### [해결방안 1-1]

이미지는 바이너리 데이터로 이루어져 있어서 서버에 post로 전송하기 위해서는 multipart/form-data 형식을 사용해야했다. 헤더에 "Content-Type" : "multipart/form-data"으로 요청 형식을 명시하고, Moya의 router 패턴인 task에
이미지와 함께 서버에 전송해야하는 텍스트 데이터와 비율 데이터를 multipartFormData에 추가하여 유저의 게시글 데이터를 서버에 전송할 수 있었다.

``` swift

 var multipartData: [MultipartFormData] = []
            
            if let file = data.file {
                for item in file {
                    let multi = MultipartFormData(
                        provider: .data(item),
                        name: "file",
                        fileName: "\(Date()).jpeg", //UUID().uuidString
                        mimeType: "image/jpeg"
                    )
                    multipartData.append(multi)
                }
            }
            
            let productIdData = MultipartFormData(provider: .data(data.product_id.data(using: .utf8)!), name: "product_id")
            multipartData.append(productIdData)
            
            if let contentData = data.content {
                let multi = MultipartFormData(provider: .data(contentData.data(using: .utf8)!), name: "content")
                multipartData.append(multi)
            }
            
            let content1Data = MultipartFormData(provider: .data(data.content1.data(using: .utf8)!), name: "content1")
                multipartData.append(content1Data)
            
            return .uploadMultipart(multipartData)
            
```

### 2. RefreshToken?

#### [문제사항]


#### [해결방안]


 </br>

 ## 회고

 - RxSwift로 모든 로직을 구현하고 싶었다.
