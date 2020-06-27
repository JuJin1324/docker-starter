# Docker-starter
도커 기초 정리   

## 설치
### macOS
설치 후 버전 확인
```shell
brew cask install docker
docker version
```

## 이미지
### 기본 명령어
* 이미지 가져오기: `docker pull [image명]`
* 이미지 목록보기: `docker images`
* 이미지 삭제하기: `docker rmi [이미지이름]:[이미지태그]`

### 자주 사용
* 모든 이미지 삭제: 
``` shell
docker rmi `docker images`
```

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

* 컨테이너 종료: `docker kill [컨테이너 id]`
* 종료된 컨테이너 재실행: `docker restart [종료된 컨테이너id]`, 종료된 컨테이너의 아이디는 `docker ps -a`를 통해서 알아낸다. 
* 컨테이너 삭제하기: `docker rm [컨테이너id]`

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

