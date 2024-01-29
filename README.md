# Five

<img width="120" height="120" src="https://github.com/989ksy/Five/assets/122261047/a1da73db-c862-4fa0-8ccb-8a3d3d56c74d">

</br>
</br>

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


### 2. Token 갱신

#### [문제사항]

Access Token이 만료 되면 자동 로그아웃 되어 서비스를 장기적으로 이용할 수 없었다. 사용자가 서비스를 이용하다가 강제 종료되는 상황을 피하기 위해서 Access Token의 유효성을 확인 하고, 만료 시 Refresh Token으로 갱신 하는 로직이 필요했다.

#### [문제해결]

Access Token 만료를 나타내는 상태코드 418을 감지한 경우, keychain에 저장한 Refresh Token으로 새 Access Token을 요청하는 retry 로직을 구현했다. 이 retry 메서드 내에서 Access Token을 성공적으로 받아오면 저장된 토큰을 교체하고, 갱신에 실패하면 사용자를 로그인 화면으로 안내하여 다시 로그인을 할 수 있도록 했다.

``` swift

  //response의 statusCode가 418인 경우 토큰을 갱신하는 API 호출
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입")
        
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 418
        else {
            print("retry Error")
            print(error)
            completion(.doNotRetryWithError(error))
            return
        }
        
        print("refresh token 진입")
        
        APIManager.shared.RefreshToken()
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let response):
                    print("Retry-토큰 재발급 성공, 토큰 교체")
                    KeychainStorage.shared.userToken = response.token
                    
                    completion(.retry)
                    
                case .failure(let error):
                    //토큰 갱신 실패, 로그인 화면 전환

                    completion(.doNotRetryWithError(error))
                    
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    
                    let vc = LoginViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    
                    sceneDelegate?.window?.rootViewController = nav
                    sceneDelegate?.window?.makeKeyAndVisible()
                }
            }
            .disposed(by: disposeBag)
    }
            
```

Moya의 provider에 해당 로직을 추가하여, 원래 헤더에 개별로 추가해야하는 로직이었으나 provider에 추가하여 코드를 간소화 시켰다.

``` swift

    private let provider = MoyaProvider<FiveAPI>(session: Session(interceptor: AuthInterceptor.shared))

```

 </br>

 ## 회고

 - RxSwift로 모든 로직을 구현하고 싶었다.
