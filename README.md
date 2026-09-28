<h1 align="center">
  <a href="https://github.com/j3s30p/openfront_ko/releases/download/v0.1.0-rc1/OpenFront_KoreanPatch_0.1.0-rc1.zip">⬇️ OpenFront 한국어 패치 다운로드</a>
</h1>

<p align="center">
  <strong>v0.1.0-rc1 · Steam판 셸 0.2.0 전용 사전 배포판</strong><br>
  <sub>설치용 ZIP 파일 하나만 받으면 됩니다.</sub>
</p>

> [!IMPORTANT]
> GitHub의 초록색 **Code** 버튼에서 받는 **Source code**는 설치 파일이 아닙니다. 위의 **한국어 패치 다운로드** 링크에서 ZIP을 받으세요. 게임 업데이트 후 버전이 달라졌다면 설치 스크립트가 적용을 중단합니다.

## 설치 방법

1. OpenFront를 종료하고 작업 관리자에서 남은 `OpenFront.exe` 프로세스가 없는지 확인합니다.
2. [설치용 ZIP](https://github.com/j3s30p/openfront_ko/releases/download/v0.1.0-rc1/OpenFront_KoreanPatch_0.1.0-rc1.zip)을 내려받아 압축을 풉니다.
3. 압축을 푼 폴더에서 PowerShell을 열고 다음 명령을 실행합니다.

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1
   ```

   OpenFront가 기본 Steam 폴더 밖에 있다면 명령 뒤에 `-GamePath "게임 설치 폴더"`를 추가합니다.
4. `설치 완료`가 표시되면 게임을 **한 번** 실행하고 설정에서 한국어를 선택합니다.

설치 스크립트는 게임 버전과 파일 해시를 검사하고, 원본을 게임 설치 폴더의 `OpenFront-KO-backup-날짜` 폴더에 보관합니다. **ZIP의 `payload` 폴더를 수동으로 게임 폴더에 복사하지 마세요.** OpenFront는 Steam 설치 파일 외에 사용자 데이터 폴더의 업데이트 오버레이도 읽기 때문에 설치 스크립트가 두 경로를 처리합니다.

---

## 원상복구

1. 게임과 남은 프로세스를 종료합니다.
2. Steam 라이브러리에서 OpenFront를 우클릭하고 **속성 → 설치된 파일 → 게임 파일 무결성 검사**를 실행합니다.
3. 설치 스크립트가 만든 백업 폴더의 `active.css`를 `%APPDATA%\OpenFront\update\overlay\assets\index-CK_1A2Do.css`에 복사합니다.

저장 데이터는 설치 파일과 별도로 `%APPDATA%\OpenFront`에 있습니다. 이 패치는 저장 데이터·계정 정보를 변경하지 않습니다.

---

## 패치 정보

| 항목 | 내용 |
| --- | --- |
| 배포 버전 | `v0.1.0-rc1` 사전 배포판 |
| 대상 게임 | Steam판 셸 `0.2.0`, 활성 클라이언트 `feba4a51c33475a184d9c42e35cc5e55829ee3ca` |
| 번역 범위 | 활성 영어 원문 2,178개 항목의 한국어 값 반영 |
| 한국어 글꼴 | Galmuri9 Regular |
| 적용 위치 | 설치 폴더의 번역·글꼴·CSS와 사용자 데이터의 활성 CSS 오버레이 |
| 저장 데이터 | 수정하지 않음 |

메뉴, 설정, 계정, 로비, 도움말 등의 번역을 보완했습니다. **게임 화면의 WebGL 지도 이름은 별도의 글꼴 아틀라스를 사용**하므로 갈무리9 UI 글꼴의 적용 범위에 포함되지 않습니다. 실제 화면의 글자 잘림과 지도 이름은 추가 검수 중입니다.

<details>
<summary><strong>번역 원칙과 소스</strong></summary>

- 원문이 풀네임이면 한국어 풀네임, 약어이면 원문의 약어와 대소문자를 유지합니다.
- 명령어, 내부 ID, 저장 형식, JSON 키, 변수 자리표시자는 바꾸지 않습니다.
- 번역 소스, 적용 CSS와 [진행 기록](https://github.com/j3s30p/openfront_ko/blob/source/docs/TRANSLATION_PROGRESS.md)은 [`source` 브랜치](https://github.com/j3s30p/openfront_ko/tree/source)에서 관리합니다. 이 브랜치의 파일을 게임에 직접 복사하지 마세요.

</details>

## 라이선스 및 출처

- 원작과 기본 번역: [OpenFrontIO](https://github.com/openfrontio/OpenFrontIO) 및 기여자, [GNU AGPL 3.0](licenses/OpenFront-AGPL-3.0.txt). 한국어 번역은 [공식 한국어 파일](https://github.com/openfrontio/OpenFrontIO/blob/93a136a1e2915ec7bb83e34980ba5836a91f63ee/resources/lang/ko.json)을 바탕으로 보완했습니다.
- 한국어 글꼴: [quiple의 Galmuri9](https://github.com/quiple/galmuri), SIL Open Font License 1.1. [라이선스 전문](licenses/Galmuri-OFL-1.1.txt)을 동봉했습니다.

이 패치는 비공식 팬 번역이며 OpenFrontIO 제작진의 공식 배포판이 아닙니다.
