# Five

![120](https://github.com/989ksy/Five/assets/122261047/208a9179-802a-463f-99d7-da79090197a7)

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


</br>

## 스택

- `UIKit`, `RxSWift`, `RxCocoa`
- `CodeBaseUI`, `SnapKit`
- `Moya`, `Kingfisher`
- `SwiftKeychainWrapper`, `YPImagePicker`
- `MVVM`, `Singleton`, `Input/Output`, `DiffableDatasource`

</br>

## 주요기능

- 회원가입을 통해 Five의 회원이 되면 로그인 가능
- 설정에서 내 프로필 이미지 또는 이름을 변경할 수 있으며, 로그아웃 및 회원탈퇴 가능
- 이미지, 텍스트를 포함한 포스트 등록 및 삭제
- 모든 유저의 포스트 조회 및 개별 프로필, 포스트 조회
- 좋아요 및 취소
- 댓글 작성 및 삭제
- 해시태그 검색

</br>

## 구현기능

- **회원가입 및 로그인**
  - 이메일 중복 API를 사용하여 이메일 중복을 피함.
  - 이메일 및 비밀번호를 입력할 때 정규화를 통해 유저가 특정 조건을 만족해야만 회원이 될 수 있음.

- **AccessToken 갱신**

- **포스트 작성**
  - YPImagePicker 라이브러리를 사용하여 복수의 이미지를 선택할 수 있음.
  - 5개 이하의 이미지 선택과 텍스트 내용이 비어있지 않을 때 RxSwift를 활용하여 업로드 버튼 활성화
- **게시글 조회**
  - 입력 시 조건이 필요한 경우 RxSwift를 사용하여 버튼을 동기화 처리 함.......>?
  - 중복되는 UI는 CustomView로 모듈화하여 중복 코드 최소화
  
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
