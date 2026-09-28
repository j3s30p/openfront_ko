# OpenFront Steam판 적용 방식

## 확인한 구조

- 게임 실행 파일과 Electron 셸은 `OpenFront.exe`와 `resources/app.asar`에 있습니다. 번역 파일은 ASAR 밖의 `resources/renderer/_assets/lang`에 있습니다.
- 기본 설치본의 영어 파일은 `en.6ee498e11ff5.json`, 한국어 파일은 `ko.a294bb02d6c3.json`입니다. 활성 업데이트 영어 파일은 별도 오버레이에 있습니다.
- `resources/renderer/asset-manifest.json`과 현재 활성 업데이트 manifest의 `lang/ko.json` 항목 모두 설치본의 `ko.a294bb02d6c3.json`을 지정합니다. 이 PC의 한국어 오버레이 파일은 없습니다.
- Electron의 `app://openfront` 프로토콜은 오버레이 파일이 있으면 먼저 제공하고, 없으면 설치 폴더의 파일을 제공합니다. 현재 버전에서는 번역 JSON 하나를 덮어쓰는 방식이 작동합니다.
- 게임 저장·설정 데이터는 설치 폴더와 별개인 `%APPDATA%\OpenFront`에 있습니다. `v0.1.0-rc2`는 이 폴더를 수정하지 않습니다.
- WebGL 지도 이름의 글꼴 아틀라스에는 한글 글리프가 없습니다. `rc2`는 글꼴을 바꾸지 않습니다.

## 업데이트 때 확인할 것

1. 게임과 백그라운드 프로세스를 완전히 종료합니다.
2. 새 Steam 설치본과 활성 업데이트 manifest가 같은 한국어 파일 이름을 쓰는지 확인합니다.
3. 활성 영어 원문과 한국어 JSON의 키·변수·약어를 다시 대조합니다.
4. JSON과 ZIP 경로·해시를 검증한 후 테스트본을 한 번 실행합니다.
5. 사용자 화면 QA에서 글자 잘림과 미번역 문구를 확인합니다.

새 클라이언트가 다른 한국어 파일 이름이나 한국어 오버레이를 쓰면 이 사전 배포 ZIP을 그대로 적용하지 않습니다.
