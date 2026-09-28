<h1 align="center">
  <a href="https://github.com/j3s30p/openfront_ko/releases/download/v0.1.0-rc2/OpenFront_KoreanPatch_0.1.0-rc2.zip">⬇️ OpenFront 한국어 패치 다운로드</a>
</h1>

<p align="center">
  <strong>v0.1.0-rc2 · Steam판 셸 0.2.0 전용 사전 배포판</strong><br>
  <sub>ZIP을 풀고 파일 하나만 덮어쓰면 됩니다. 명령어 실행은 필요하지 않습니다.</sub>
</p>

> [!IMPORTANT]
> GitHub의 초록색 **Code** 버튼에서 받는 **Source code**는 설치 파일이 아닙니다. 위의 **한국어 패치 다운로드** 링크에서 ZIP을 받으세요.

## 설치 방법

1. OpenFront와 백그라운드에 남은 `OpenFront.exe` 프로세스를 모두 종료합니다.
2. [설치용 ZIP](https://github.com/j3s30p/openfront_ko/releases/download/v0.1.0-rc2/OpenFront_KoreanPatch_0.1.0-rc2.zip)을 내려받아 압축을 풉니다.
3. Steam 라이브러리에서 OpenFront를 우클릭해 **관리 → 로컬 파일 보기**를 누릅니다.
4. ZIP 안의 `resources` 폴더를 게임 설치 폴더에 끌어다 놓고, `ko.a294bb02d6c3.json` 파일 덮어쓰기를 선택합니다.
5. 게임을 **한 번** 실행하고 설정에서 한국어를 선택합니다.

적용되는 게임 파일은 `resources/renderer/_assets/lang/ko.a294bb02d6c3.json` **하나뿐**입니다. 이 버전은 글꼴과 CSS를 변경하지 않습니다.

---

## 원상복구

Steam 라이브러리에서 OpenFront를 우클릭하고 **속성 → 설치된 파일 → 게임 파일 무결성 검사**를 실행하면 원본 번역 파일로 돌아갑니다. 저장 데이터는 게임 설치 폴더와 별도인 `%APPDATA%\OpenFront`에 있으며, 이 패치는 해당 폴더를 수정하지 않습니다.

---

## 패치 정보

| 항목 | 내용 |
| --- | --- |
| 배포 버전 | `v0.1.0-rc2` 사전 배포판 |
| 대상 게임 | Steam판 셸 `0.2.0`, 활성 클라이언트 `feba4a51c33475a184d9c42e35cc5e55829ee3ca` |
| 번역 범위 | 활성 영어 원문 2,178개 항목의 한국어 값 반영 |
| 적용 파일 | `resources/renderer/_assets/lang/ko.a294bb02d6c3.json` |
| 글꼴 | 원본 게임 글꼴 유지 |
| 저장 데이터 | 수정하지 않음 |

메뉴, 설정, 계정, 로비, 도움말 등의 한국어 문구를 보완했습니다. 현재 버전의 활성 업데이트는 위 한국어 파일을 그대로 참조하는 것을 확인했습니다. Steam 또는 게임 자체 업데이트로 한국어 파일 이름이나 적용 경로가 바뀌면 이 패치를 그대로 덮어쓰지 마세요.

<details>
<summary><strong>번역 원칙과 소스</strong></summary>

- 원문이 풀네임이면 한국어 풀네임, 약어이면 원문의 약어와 대소문자를 유지합니다.
- 명령어, 내부 ID, 저장 형식, JSON 키, 변수 자리표시자는 바꾸지 않습니다.
- 번역 소스와 [진행 기록](https://github.com/j3s30p/openfront_ko/blob/source/docs/TRANSLATION_PROGRESS.md)은 [`source` 브랜치](https://github.com/j3s30p/openfront_ko/tree/source)에서 관리합니다. 소스 파일을 게임에 직접 복사하지 마세요.

</details>

## 라이선스 및 출처

- 원작과 기본 번역: [OpenFrontIO](https://github.com/openfrontio/OpenFrontIO) 및 기여자, [GNU AGPL 3.0](licenses/OpenFront-AGPL-3.0.txt). 한국어 번역은 [공식 한국어 파일](https://github.com/openfrontio/OpenFrontIO/blob/93a136a1e2915ec7bb83e34980ba5836a91f63ee/resources/lang/ko.json)을 바탕으로 보완했습니다.

이 패치는 비공식 팬 번역이며 OpenFrontIO 제작진의 공식 배포판이 아닙니다.
