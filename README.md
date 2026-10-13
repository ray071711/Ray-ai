# Ray AI

Windows PC의 Ollama 모델을 연결해 쓰는 개인용 AI 채팅 앱입니다. 답변은 PC에서 로컬 모델로 생성합니다. 웹 검색과 날씨는 필요할 때만 외부 서비스에 요청합니다. 이미지 생성은 ComfyUI가 준비되면 같은 화면에서 실행됩니다.

## 지금 PC에서 실행하기

1. Ollama가 실행 중인지 확인합니다. 사용 중인 모델은 `qwen3:4b`입니다. 아직 모델을 받지 않았다면 명령 프롬프트에서 `ollama pull qwen3:4b`를 한 번 실행합니다.
2. 이 폴더에서 `실행하기.bat`을 더블 클릭합니다. 열린 검은 창을 켜 둔 채 브라우저에서 Ray AI를 사용합니다.
3. 입력 칸을 클릭해 메시지를 입력하고 Enter를 누릅니다. Shift+Enter는 줄바꿈입니다.

첫 질문은 모델이 메모리에 올라오느라 조금 늦을 수 있습니다. 이후 응답은 토큰이 만들어지는 대로 표시됩니다. RTX 3050 노트북 4GB VRAM 기준으로 문맥/최대 답변 길이를 낮춰 두었습니다. 앱 설정에서 Ollama에 설치된 다른 모델을 선택할 수 있습니다.

## 기능

- 주제별 시스템 지침은 `system_prompt.txt`와 앱의 정책 설정에서 편집할 수 있습니다. 불필요한 거절을 줄이도록 요청하지만, 모델 자체의 성향이나 모든 답변을 보장하지는 않습니다.
- 대화 기록은 `chat_history.json`에 저장됩니다.
- 웹 검색은 DuckDuckGo, 날씨는 Open-Meteo를 사용합니다. 일반 대화는 외부 검색으로 보내지 않습니다.
- 이미지 생성은 ComfyUI를 PC에서 실행하고 SD 1.5 체크포인트를 설치한 뒤 사용할 수 있습니다.

## 이미지 생성 준비 (Windows / RTX 3050 4GB)

ComfyUI의 NVIDIA 휴대용 폴더는 `ComfyUI_windows_portable`에 압축 해제되어 있습니다. `이미지모델_다운로드.bat`을 더블 클릭하면 공식 Hugging Face에서 모델을 내려받아 `ComfyUI_windows_portable\ComfyUI\models\checkpoints`에 넣고 ComfyUI를 시작합니다. 약 2.13GB 다운로드이므로 끝날 때까지 창을 열어 두세요. 중간에 끊겨도 같은 파일을 다시 실행하면 이어받기를 시도합니다.

- 파일명: `v1-5-pruned-emaonly-fp16.safetensors`
- 크기: 약 2.13GB
- 공식 다운로드: [Comfy-Org SD 1.5 모델 파일](https://huggingface.co/Comfy-Org/stable-diffusion-v1-5-archive/resolve/main/v1-5-pruned-emaonly-fp16.safetensors)

ComfyUI 창을 열어 둔 채 Ray AI 화면을 새로고침하면 연결 상태를 확인할 수 있습니다. 입력창의 이미지 기능을 선택해 설명을 넣으면 512×512, 15단계로 생성합니다. 첫 생성은 모델 로딩 때문에 오래 걸릴 수 있습니다. GPU 메모리 부족이 나면 다른 GPU 사용 앱을 닫고 ComfyUI를 재시작하세요.

모델은 GitHub에 올리지 마세요. 용량이 크고 배포 라이선스도 별도로 확인해야 합니다.

## iPhone에서 사용하기 / IPA

이 프로젝트에는 iPhone용 웹앱 외피(Capacitor)와 GitHub Actions 빌드 설정이 포함되어 있습니다. iPhone은 Ollama/ComfyUI를 직접 실행하지 않고 PC의 Ray AI 서버에 연결합니다. PC와 iPhone이 같은 Wi-Fi에 있어야 하며, PC에서는 `실행하기_iOS서버.bat`을 실행합니다. Ray AI 설정에서 iPhone이 접속할 PC 주소와 `config.json`의 `api_token`을 넣습니다. 토큰은 개인 비밀번호처럼 취급하고 공개하지 마세요.

IPA 빌드에는 GitHub 저장소가 필요합니다. 이 폴더를 사용자가 소유한 GitHub 저장소에 올린 다음 **Actions → Build Ray AI iOS IPA (unsigned) → Run workflow**를 실행하면 빌드 산출물을 받을 수 있도록 구성했습니다. 현재 생성되는 IPA는 서명되지 않은 빌드로, iPhone에 바로 설치할 수 없습니다. 실제 설치에는 Apple 개발자 서명과 배포 방식(TestFlight/개발용 서명 등)이 필요합니다. Windows에는 Xcode가 없어 이 PC에서 직접 서명된 IPA를 만들 수 없습니다.

## 개인정보와 연결

기본 실행은 이 PC에서만 접속됩니다. iPhone 연결을 위해 LAN 모드로 실행하면 같은 네트워크에서 PC 서버에 접근할 수 있고, API에는 임의 생성 토큰을 요구합니다. Windows 방화벽이 연결을 막으면 사용자에게 네트워크 허용 창이 표시될 수 있습니다. 신뢰하는 개인 Wi-Fi에서만 사용하세요. `config.json`, 채팅 기록, 생성 이미지, 모델 파일은 저장소에 올리지 않도록 설정되어 있습니다.

## 문제 해결

- `Ollama에 연결할 수 없어요`: Ollama 앱이 실행 중인지 확인합니다.
- 모델을 찾을 수 없다는 메시지: `ollama list`에 `qwen3:4b`가 있는지 확인하고 앱 설정의 모델 이름을 일치시킵니다.
- 이미지 모델이 없다는 메시지: 체크포인트 파일이 위 폴더에 있는지, 파일 크기가 2GB 이상인지 확인합니다.
- ComfyUI 연결 실패: `run_nvidia_gpu.bat` 창이 열려 있는지 확인합니다. 주소 기본값은 `http://127.0.0.1:8188`입니다.
- iPhone 연결 실패: PC와 휴대폰이 같은 Wi-Fi인지 확인하고 PC에서 `실행하기_iOS서버.bat`을 실행했는지 확인합니다. PC의 사설 IPv4 주소와 API 토큰을 앱 설정에 입력해야 합니다.

## 출처

- [Ollama for Windows](https://ollama.com/download/windows), [Qwen3 4B](https://ollama.com/library/qwen3%3A4b)
- [ComfyUI Windows portable](https://github.com/Comfy-Org/ComfyUI), [SD 1.5 체크포인트](https://huggingface.co/Comfy-Org/stable-diffusion-v1-5-archive)
- [Capacitor iOS 안내](https://capacitorjs.com/docs/ios)
