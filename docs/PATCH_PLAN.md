# OpenFront Steam판 조사와 적용 계획

## 확인한 구조

- Electron 실행 파일과 셸은 `OpenFront.exe`, `resources/app.asar`에 있음. `app.asar` 안의 `package.json`은 `openfront-desktop` 0.2.0을 표시함.
- 게임 클라이언트는 `resources/renderer`에 별도 보관됨. 원문은 `resources/renderer/_assets/lang/en.6ee498e11ff5.json`, 한국어는 같은 폴더의 `ko.a294bb02d6c3.json`에 있음.
- `resources/renderer/asset-manifest.json`의 `lang/ko.json` 항목이 해시 이름의 실제 파일로 연결됨. `asset-hashes.json`에는 파일 SHA-256과 크기가 기록됨. 현재 활성 업데이트의 manifest도 같은 `ko.a294bb02d6c3.json`을 지정함.
- Electron의 `app://openfront` 프로토콜은 사용자 데이터 폴더의 `update/overlay`에 파일이 있으면 설치본보다 먼저 제공함. 활성 업데이트는 별도 manifest를 사용할 수 있음.
- 셸은 `app.getPath("userData")`에 디스플레이 설정(`preferences.json`)과 업데이트 데이터를 저장함. 이 PC에서 실제 경로는 `%APPDATA%\OpenFront`로 확인됨. `Local Storage`, `Session Storage`, `update` 폴더가 있으며, 번역 파일을 다룰 때 이 데이터를 수정하지 않음. 계정과 게임 기록이 서버에도 저장되는지 여부는 추가 확인 필요.
- 게임 화면의 `msdf-atlas`에는 글리프 319개 중 한글 0개이며, 렌더러 코드의 이름 렌더링 경로에는 384개 코드 포인트 크기의 배열이 보임. 지도 위 한글 이름 표시는 별도 소스 변경 없이는 지원되지 않을 가능성이 큼.

## 다음 단계

1. 게임과 백그라운드 프로세스가 모두 종료된 상태에서 현재 설치본과 활성 업데이트 manifest를 확인한다. 현재는 OpenFront 프로세스 0개와 활성 manifest 경로 확인을 마침.
2. 업데이트가 활성화된 경우 실제 제공되는 한국어 JSON 경로와 원문 버전을 비교한다. 현재 활성 영어 원문 2,178개 키를 번역본에 반영했으며, 다음 업데이트 때 다시 비교한다.
3. HTML UI와 게임 화면의 글꼴 경로를 분리해 검증한다. 지도 위 번역 표시가 필요하면 클라이언트 소스에서 글꼴 아틀라스·렌더링 방식을 수정하고 빌드한다.
4. JSON 구문, 원문 키 누락, 변수·약어·내부 식별자 보존, 해시를 검사한다. 변경 때마다 빌드 대상이 있다면 빌드도 검사한다.
5. 테스트본을 적용할 때 프로세스 0개를 확인하고 **한 번만** 실행한다. 이번 테스트본은 이 절차로 실행했고 프로세스 6개가 살아 있음. 사용자가 실제 화면과 글자 잘림을 확인한다.
6. 검증한 게임 버전용 설치 파일만 `release`에 넣는다. README 첫 화면에 다운로드와 설치·원상복구 절차를 적고 개발 소스는 배포물에서 제외한다.

Steam 업데이트나 OpenFront 클라이언트의 자체 업데이트로 경로·해시가 바뀌면 현재 번역 파일을 그대로 덮어쓰지 않는다.
