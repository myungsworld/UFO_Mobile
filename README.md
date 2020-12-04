# UFO_Mobile

[1. 개발 환경](#개발-환경)    
[2. 개발 내용](#개발-내용)    
[3. 개발 과정](#개발-과정)       
[4. 개발 계획](#개발-계획) 

## 개발 환경
* XCode
* Swift     
SwiftUI를 이용한 구현

## 개발 내용
* TabView 기반의 모바일 어플리케이션
* **SplashView**, **Home**, **Festival**, **MyPage** 페이지 구성
* QR코드를 이용한 결제(송금) 시스템
* 카카오 로그인을 활용한 사용자 식별
* 축제를 선택함으로 해당 축제 정보 확인

## 개발 과정
* SplashView
    * 처음 실행시, 기본 축제를 선택. 이를 **Cache**와 **FileDisk**에 저장하여 다음 실행시 자동으로 해당 축제의 정보를 로드
    * HTTP 통신으로 해당 축제의 부스, 메뉴 정보 및 이미지 로드 테스트 완료

    ![ezgif com-gif-maker](https://user-images.githubusercontent.com/27637757/97952774-db5bb680-1de1-11eb-9cd6-3c4ee1219e94.gif) ![ezgif com-gif-maker (1)](https://user-images.githubusercontent.com/27637757/97952991-80768f00-1de2-11eb-8def-cb2558273425.gif)
* Home
    * 배경(?)으로 카메라를 띄워놓고 QR코드 인식
    * SlideOver를 이용하여 유저의 QR코드 이미지 공간 

    ![ezgif com-gif-maker (3)](https://user-images.githubusercontent.com/27637757/97953215-2aeeb200-1de3-11eb-9ca6-7b0d39713fb9.gif)

* Festival
    * 선택한 축제의 부스(스토어) 리스트
    * 각 부스 선택시 그 부스의 메뉴(아이템) 리스트
    * 해당 축제의 지역 지도를 띄워 부스의 위치 정보 
    
    ![ezgif com-gif-maker (2)](https://user-images.githubusercontent.com/27637757/97953098-e2cf8f80-1de2-11eb-9c3e-054ab881c3f1.gif)
* MyPage
    * 회원관리를 위해 회원가입 및 로그인 기능 추가
    * 카카오 로그인으로 대체

    ![ezgif com-gif-maker](https://user-images.githubusercontent.com/27637757/97953361-920c6680-1de3-11eb-9653-ed6d0821cf95.png)

## 개발 계획
* SplashView
    * ~~처음 실행시 Pop Up 메뉴를 통해 기본 축제 설정~~
    * 부스 및 메뉴 정보 이미지 로드
* Home
    * ~~QR코드 스캐너 구현~~
    * ~~SlideOver 구현~~
    * ~~QR코드를 인식하여 HTTP 통신~~
    * ~~유저정보를 바탕으로 QR코드 생성~~
    * ~~충전기능~~
    * ~~SlideOverMenu~~
    * ~~최초 결제 비밀번호~~
    * ~~결제시 결제 비밀번호~~
* Festival
    * ~~부스 이미지, 이름을 ScrollView 이용해 Button으로 띄우기~~
    * ~~부스 이미지 클릭시, 해당 부스의 정보 및 메뉴 띄우기~~
    * 서버로부터 받은 해당 부스 및 메뉴 정보 및 이미지 가져와 띄우기
    * 맵에 핀으로 해당 부스 위치 표시
* MyPage
    * ~~회원가입, 로그인 폼 제작~~
    * 미로그인시 UI 화면 제작
    * 로그인시 유저 정보 띄우기
      - 충전 내역  
      - 결제 내역  
      - 결제 비밀번호 (설정)  
