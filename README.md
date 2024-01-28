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

이미지는 바이너리 데이터로 이루어져 있어서, 서버에 업로드하기 위해서는 HTTP POST 요청을 multipart/form-data 형식으로 보내야 했다. 이를 위해 요청 헤더에 "Content-Type"을 "multipart/form-data"로 설정했다. 서버에 이미지를 전송할 때 게시글을 포스팅 할 때 필수조건인 텍스트와 이후 UI를 구성할 때 필요한 비율을 함께 보내야했다. 이미지 파일 외에도 텍스트 데이터와 비율 데이터를 함께 보내기 위해 multipartFormData에 해당 데이터를 추가했다. 게시글을 포스트하기 위해 필요한 데이터들은 Moya의 라우터 패턴을 사용하여 서버에 전송했다.

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

#### [문제사항 1-2]

서버에서 get으로 받은 이미지를 kingfisher를 통해 로드하려고 하였으나, 이미지 로드에 실패했을 때 대응하려고 설정한 placeholder 이미지로 대체 되고 있었다.

#### [문제해결 1-2]

서버에 이미지를 전송할 때 필요한 token과 API 키를 추가했으므로, 이미지를 로드할 때도 동일한 작업이 필요했다. 이를 처리하기 위해 AnyModifier를 활용하여 Kingfisher로 이미지를 로드하는 로직을 수정했다. AnyModifier를 사용하여 인증 토큰과 API 키를 요청에 추가함으로써, 서버로부터 이미지를 불러올 수 없었던 문제를 해결했다.

``` swift

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(from url: URL, placeHolderImage: UIImage? = nil) {
        let modifier = AnyModifier { request in
            var r = request
            if let token = KeychainStorage.shared.userToken {
                r.setValue(token, forHTTPHeaderField: "Authorization")
                r.setValue(APIKey.sesacKey, forHTTPHeaderField: "SesacKey")
            }
            return r
        }
        self.kf.setImage(with: url, placeholder: placeHolderImage, options: [.requestModifier(modifier), .forceRefresh])
    }
}

            
```


### 2. RefreshToken?

#### [문제사항]


#### [해결방안]


 </br>

 ## 회고

 - RxSwift로 모든 로직을 구현하고 싶었다.
