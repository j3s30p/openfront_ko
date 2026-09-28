param(
  [string]$GamePath = 'C:\Program Files (x86)\Steam\steamapps\common\OpenFront'
)

$ErrorActionPreference = 'Stop'
$GamePath = [IO.Path]::GetFullPath($GamePath)
$expectedClient = 'feba4a51c33475a184d9c42e35cc5e55829ee3ca'
$userData = Join-Path $env:APPDATA 'OpenFront'
$payload = Join-Path $PSScriptRoot 'payload'

if (-not (Test-Path -LiteralPath (Join-Path $GamePath 'OpenFront.exe'))) {
  throw "OpenFront.exe를 찾을 수 없습니다: $GamePath"
}
if (Get-CimInstance Win32_Process -Filter "Name = 'OpenFront.exe'") {
  throw '게임과 백그라운드 OpenFront 프로세스를 모두 종료한 뒤 다시 실행하세요.'
}
$activePath = Join-Path $userData 'update/active.json'
if (-not (Test-Path -LiteralPath $activePath)) {
  throw '활성 업데이트 정보를 찾을 수 없습니다. 게임을 온라인으로 한 번 실행한 뒤 종료하세요.'
}
$active = Get-Content -LiteralPath $activePath -Raw | ConvertFrom-Json
if ($active.clientVersion -ne $expectedClient) {
  throw "지원하지 않는 클라이언트 버전: $($active.clientVersion)"
}
$descriptorPath = Join-Path $userData "update/descriptors/$expectedClient.json"
$descriptor = Get-Content -LiteralPath $descriptorPath -Raw | ConvertFrom-Json
if ($descriptor.assetManifest.'lang/ko.json' -ne '/_assets/lang/ko.a294bb02d6c3.json') {
  throw '한국어 번역 파일 경로가 변경되었습니다. 이 패치를 적용하지 마세요.'
}

function Get-Sha256([string]$file) {
  return (Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToUpperInvariant()
}

$routes = @(
  [pscustomobject]@{
    Name = 'ko.json'; Source = 'resources/renderer/_assets/lang/ko.a294bb02d6c3.json'
    Target = (Join-Path $GamePath 'resources/renderer/_assets/lang/ko.a294bb02d6c3.json')
    Allowed = @('BAF33F41D4386A75A58351B6D365A27AADEFD847A7571A8BD8696EB69EA8BA34','5163C9F278E0A79AED07CD3EE8D0976B1B4796976D6F285F7016AEE2BE2DD9BC')
    Expected = '5163C9F278E0A79AED07CD3EE8D0976B1B4796976D6F285F7016AEE2BE2DD9BC'
  },
  [pscustomobject]@{
    Name = 'Galmuri9.woff2'; Source = 'resources/renderer/_assets/fonts/Galmuri9.woff2'
    Target = (Join-Path $GamePath 'resources/renderer/_assets/fonts/Galmuri9.woff2')
    Allowed = @('275D995906625EAAA5D2D9BAA0A80F90A5C033C381C0DC2108A8729D371041A6')
    Expected = '275D995906625EAAA5D2D9BAA0A80F90A5C033C381C0DC2108A8729D371041A6'
  },
  [pscustomobject]@{
    Name = 'baseline.css'; Source = 'resources/renderer/assets/index-DkV4Tufm.css'
    Target = (Join-Path $GamePath 'resources/renderer/assets/index-DkV4Tufm.css')
    Allowed = @('5FBF59457F984A0E796DFF9CBE25BA53A690E2169DBD814ADC1AC8AB9CCF02DE','D85CD1CAFA43DC25384165C5A8C29D3D1855C9BF6171391A8EFDD236301D5346')
    Expected = 'D85CD1CAFA43DC25384165C5A8C29D3D1855C9BF6171391A8EFDD236301D5346'
  },
  [pscustomobject]@{
    Name = 'active.css'; Source = 'user-data/update/overlay/assets/index-CK_1A2Do.css'
    Target = (Join-Path $userData 'update/overlay/assets/index-CK_1A2Do.css')
    Allowed = @('4F737A9075776C0CF199D05C1A3D118194ECF3C0574770C616383C82C056AC4D','9C8300481195A328B6B4369923DF9A68F97A9E5BC2FE0F994E8A40FDF36B9D66')
    Expected = '9C8300481195A328B6B4369923DF9A68F97A9E5BC2FE0F994E8A40FDF36B9D66'
  },
  [pscustomobject]@{
    Name = 'asset-hashes.json'; Source = 'resources/renderer/asset-hashes.json'
    Target = (Join-Path $GamePath 'resources/renderer/asset-hashes.json')
    Allowed = @('136E8DF984301FCD06F576DE8E1207558405D086ADDC2540C4DE192FCAA5C23F','3D8F8C4BB05765292D6C6A85B1A440F49C8036525EA3141A01B011A7B7D86B9F','65036F583AFEF066402F9EE8066F998753F79F27A43BEC37838FC92ADF4CF74C')
    Expected = '65036F583AFEF066402F9EE8066F998753F79F27A43BEC37838FC92ADF4CF74C'
  }
)

foreach ($route in $routes) {
  $source = Join-Path $payload $route.Source
  if ((Get-Sha256 $source) -ne $route.Expected) {
    throw "배포 파일 해시가 맞지 않습니다: $($route.Name)"
  }
  if (Test-Path -LiteralPath $route.Target) {
    $current = Get-Sha256 $route.Target
    if ($current -notin $route.Allowed) {
      throw "설치된 게임 파일이 이 테스트본과 다릅니다: $($route.Name)"
    }
  } elseif ($route.Name -ne 'Galmuri9.woff2') {
    throw "게임 파일을 찾을 수 없습니다: $($route.Name)"
  }
}

$backupDir = Join-Path $GamePath ('OpenFront-KO-backup-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
foreach ($route in $routes) {
  if (Test-Path -LiteralPath $route.Target) {
    Copy-Item -LiteralPath $route.Target -Destination (Join-Path $backupDir $route.Name)
  }
  Copy-Item -LiteralPath (Join-Path $payload $route.Source) -Destination $route.Target -Force
  if ((Get-Sha256 $route.Target) -ne $route.Expected) {
    throw "설치 후 해시 확인에 실패했습니다: $($route.Name)"
  }
}
Write-Host "설치 완료. 원본 백업: $backupDir"
Write-Host '게임을 한 번 실행하고 한국어를 선택하세요.'
