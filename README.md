# Five

![120](https://github.com/989ksy/Five/assets/122261047/208a9179-802a-463f-99d7-da79090197a7)

**📸 타인과 공유하고 싶은 순간을 이미지와 텍스트 기반으로 공유하고 공감 받을 수 있는 SNS 어플리케이션**


## Preview

**[회원가입 + 로그인 UI]**

![Five_Before](https://github.com/989ksy/Five/assets/122261047/497d3679-874d-45d7-901f-38ce3fb6f112)

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

- 회원가입 및 로그인
- 설정에서 내 프로필 이미지 또는 이름을 변경할 수 있으며, 로그아웃 및 회원탈퇴 가능
- 이미지, 텍스트를 포함한 포스트 등록 및 삭제
- 모든 유저의 포스트 조회 및 개별 프로필 조회
- 모든 포스트에 좋아요 및 취소, 댓글 작성 및 삭제 가능
- 해시태그 검색

</br>

## 스택

- `UIKit`, `RxSWift`, `RxCocoa`
- `CodeBaseUI`, `SnapKit`
- `Moya`, `Kingfisher`
- `SwiftKeychainWrapper`, `YPImagePicker`
- `MVVM`, `Singleton`, `Input/Output`, `DiffableDatasource`, `Repository Pattern`


</br>

## 구현기능

- **회원가입 및 로그인**
  
  - 이메일 중복 API를 활용하여 이메일 중복을 피함.
  - 이메일 및 비밀번호 `정규표현식`을 통해 유효성 검증

- **AccessToken 갱신**
  
  - `Alamofire Intercepter`를 통해 AccessToken 만료 시 Refresh Token으로 갱신하는 `JWT` 인증 로직 구현

- **포스트 작성 및 조회**
  
  - YPImagePicker 라이브러리를 사용하여 5장 이하의 이미지를 선택할 수 있음.
  - `Offset-Based Pagination` 방식을 이용하여 최대 10개의 포스트를 실시간으로 조회
 
- **해시태그 검색**
  
  - 이미지 사이즈에 따라 동적으로 셀 크기 조절을 위해 `DiffableDatasource`으로 collectionView 구현
 
  
</br>

 ## 트러블 슈팅

### 1. multipartForData?

#### [문제사항]

#### [해결방안]

### 2. 

#### [문제사항]

#### [해결방안]

 </br>

 ## 회고
