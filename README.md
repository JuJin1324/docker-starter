# Docker-starter
도커 기초 정리   

## 설치
### Docker Desktop CE: macOS
설치 후 버전 확인
```shell
brew cask install docker
docker version
```

## 이미지
### 이미지 가져오기
* 명령어: `docker pull [image명]`
``` shell
# 예시 1
docker pull ubuntu:latest
# 예시 2: 태그명 생략하면 자동으로 latest로 pulling
docker pull ubuntu
```

### 이미지 목록보기
* 명령어: `docker images`

### 이미지 삭제
* 명령어: `docker rmi [이미지이름]:[이미지태그]`
``` shell
# 예시 1: 특정 이미지 삭제
docker rmi ubuntu
# 예시 2: 모든 이미지 삭제
docker rmi `docker images`
# 예시 3: 모든 이미지 강제 삭제(-f)
docker rmi -f `docker images`
```

### Digest
도커 이미지 파일의 해시 값

### DCT(Docker Content Trust)
도커 이미지 생성자의 개인키를 통해 서명한 이미지에 대해서 해당 개인키에 대한 공개키로 위변조 검증하는 기능   
다음 명령어를 통해서 enable 시키면 `docker image pull`로 이미지를 다운로드 시에 공개키로 위변조를 검증한다.
``` shell
export DOCKER_CONTENT_TRUST=1
```

### 이미지 상세 정보 표시
* 상세 정보 모두 표시: `docker image inspect [이미지명]`   
``` shell
# 예시
docker image inspect nginx
# 결과
[
    {
        "Id": "sha256:2622e6cca7ebbb6e310743abce3fc47335393e79171b9d76ba9d4f446ce7b163",
        "RepoTags": [
            "nginx:latest"
        ],
        "RepoDigests": [
            "nginx@sha256:21f32f6c08406306d822a0e6e8b7dc81f53f336570e852e25fbe1e3e3d0d0133"
        ],
        "Parent": "",
        "Comment": "",
        "Created": "2020-06-09T16:57:42.632836191Z",
        "Container": "53e54c20f21e263548ac09475373e20dfef58dd38aebc6caec258b4ff6c2446c",
        "ContainerConfig": {
        ...
```

* 위의 명령어 중 특정 원소 정보의 값만 표시: `docker images inspect --format="{{.키}} [이미지명]"
``` shell
# 예시
docker image inspect --format="{{.Os}} nginx
# 결과
linux
```

### 이미지 태깅
* 명령어: `docker image tag [컨테이너 태그명] [Docker Hub 사용자명]/[이미지명]:[태그명]`
``` shell
# 예시
docker image tag nginx jujin/webserver:1.0
# 확인
docker iamges
```

### 이미지 찾기
Docker Hub에서 이미지 검색
* 명령어: `docker search [이미지 명]`
``` shell
# 예시
docker search redmine
# 결과
NAME                           DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
redmine                        Redmine is a flexible project management web…   893                 [OK]                
sameersbn/redmine                                                              316                                     [OK]
bitnami/redmine                Bitnami Docker Image for Redmine                54                                      [OK]
...
```
* STAR: 즐겨찾기 수
* OFFICIAL: 공식 이미지
* AUTOMATED: Dockerfile을 바탕으로 자동 생성된 이미지   

필터링하기
* 1000개 이상 즐겨찾기인 이미지만 탐색: `docker search --filter stars=1000 [이미지명]`
* 공식 이미지만 탐색: `docker search --filter is-official=true [이미지명]`

## 컨테이너 실행
이미지를 삽입하여 도커 위에서 실행하는 프로세스

### 기본 명령어
* 컨테이너 생성 및 실행: `docker run [OPTIONS] [image명] [COMMAND] [ARGS...]`  
자주 사용하는 옵션(OPTIONS): `docker run --help` 로 확인가능
    
옵션 | 설명
----|----
-d |	detached mode 흔히 말하는 백그라운드 모드
-p |	호스트와 컨테이너의 포트를 연결 (포워딩)
-v |	호스트와 컨테이너의 디렉토리를 연결 (마운트)
-e |	컨테이너 내에서 사용할 환경변수 설정
–name |	컨테이너 이름 설정
–rm |	프로세스 종료시 컨테이너 자동 제거
-i | interactive 모드 : Keep STDIN open even if not attached
-t | tty : pseudo-TTY 할당 (tty : 일반 CLI 콘솔 / CLI : Command Line Interface)
-it |	-i와 -t를 동시에 사용한 것으로 터미널 입력을 위한 옵션
–link |	컨테이너 연결 [컨테이너명:별칭]

참조 사이트 : [초보를 위한 도커 안내서 - 설치하고 컨테이너 실행하기](https://subicura.com/2017/01/19/docker-guide-for-beginners-2.html)

* 컨테이너 중지: `docker stop [컨테이너 이름 or ID]`
* 컨테이너 시작: `docker start [컨테이너 이름 or ID]`
* 컨테이너 재시작: `docker restart [컨테이너 이름 or ID]`
* 컨테이너 종료: `docker kill [컨테이너 이름 or ID]`
* 컨테이너 삭제하기: `docker rm [컨테이너 이름 or ID]`
* 실행 중인 컨테이너의 가동 상태 확인(CPU/Mem 점유율, Network IO 등): `docker stats [컨테이너 이름 or ID]`

### 자주 사용
* 실행 중인 컨테이너만 보기: `docker ps`
* 종료된 컨테이너도 포함해서 보기: `docker ps -a`
* 모든 컨테이너 삭제:
``` shell
docker rm `docker ps -a`
```

## System Info
### 명령어
* Docker 자체 버전 및 정보 확인: `docker version`
* Docker 실행 환경 확인: `docker info`
* Docker 디스크 이용 상황 확인: `docker system df`

