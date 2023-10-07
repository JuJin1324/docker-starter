# Docker-starter
## 설치
### Docker Desktop CE
> 리눅스를 제외한 Windows 및 macOS 는 일반 docker 가 아닌 docker desktop 을 사용한다.  
> 혹은 우분투를 사용하고 docker 를 GUI 창으로 설정 관리하고 싶은 경우에도 docker desktop 을 사용한다.  
> 
> macOS 에서 설치 후 버전 확인
> ```bash
> brew install --cask docker
> docker version
> ```

### Docker vs Docker Desktop
> Docker 는 GUI 가 없이 서비스로 실행되는 프로그램이다.  
> Docker Desktop 은 Docker 가상환경을 제공하는 GUI 프로그램이다.   
> Docker 는 리눅스 계열(우분투, centOS 등)에서는 실행할 수 있지만, macOS 및 Windows 에서는 Docker Desktop 을 통해서 실행해야한다.  
> Docker Desktop 은 점유하는 자원(CPU, Memory, Disk)를 설정해서 제한된 자원을 사용해야하지만 Docker 는 따로 점유하는 자원을 설정하지 않고 모든 자원을 풀로 사용할 수 있다.   

---

## 이미지
### 이미지 목록보기
> 명령어: `docker images`

### 이미지 가져오기
> 명령어: `docker pull [image명]`  
> ```bash
> # 예시 1
> docker pull ubuntu:latest
> 
> # 예시 2: 태그명 생략하면 자동으로 latest로 pulling
> docker pull ubuntu
> ```

### 이미지 삭제
> 명령어: `docker rmi [이미지이름]:[이미지태그]`  
> ```bash
> # 예시 1: 특정 이미지 삭제
> docker rmi ubuntu
> 
> # 예시 2: 모든 이미지 삭제
> docker rmi `docker images`
> 
> # 예시 3: 모든 이미지 강제 삭제(-f)
> docker rmi -f `docker images`
> ```

### Digest
> 도커 이미지 파일의 해시 값

### DCT(Docker Content Trust)
> 도커 이미지 생성자의 개인키를 통해 서명한 이미지에 대해서 해당 개인키에 대한 공개키로 위변조 검증하는 기능.     
> 다음 명령어를 통해서 enable 시키면 `docker image pull`로 이미지를 다운로드 시에 공개키로 위변조를 검증한다.  
> 주의: Docker 사용에 영향을 미치므로 잘 조사한 후에 사용한다.  
> ```bash
> export DOCKER_CONTENT_TRUST=1
> 
> # 혹은 영구로 사용할 거면 .zshrc 에 추가한다.
> echo 'export DOCKER_CONTENT_TRUST=1' >> ~/.zshrc
> source ~/.zshrc
> ```

### 이미지 상세 정보 표시
> 상세 정보 모두 표시: `docker image inspect [이미지명]`    
> ```bash
> # 예시
> docker image inspect nginx
> 
> # 결과
> [
>     {
>         "Id": "sha256:2622e6cca7ebbb6e310743abce3fc47335393e79171b9d76ba9d4f446ce7b163",
>         "RepoTags": [
>             "nginx:latest"
>         ],
>         "RepoDigests": [
>             "nginx@sha256:21f32f6c08406306d822a0e6e8b7dc81f53f336570e852e25fbe1e3e3d0d0133"
>         ],
>         "Parent": "",
>         "Comment": "",
>         "Created": "2020-06-09T16:57:42.632836191Z",
>         "Container": "53e54c20f21e263548ac09475373e20dfef58dd38aebc6caec258b4ff6c2446c",
>         "ContainerConfig": {
>         ...
> ```
>
> 위의 명령어 중 특정 원소 정보의 값만 표시: `docker images inspect --format={{.키}} [이미지명]`
> ```bash
> # 예시
> docker image inspect --format={{.Os}} nginx
> 
> # 결과
> linux
> ```

### 이미지 태깅
> 설명: 기존의 이미지를 기반으로 내가 지정한 이름으로 이미지를 복사한다.  
> 명령어: `docker image tag [컨테이너 태그명] [Docker Hub 사용자명]/[이미지명]:[태그명]`
> ```bash
> # 예시
> docker image tag nginx jujin/webserver:1.0
> 
> # 확인
> docker iamges
> ```

### 이미지 찾기
> 설명: Docker Hub에서 이미지 검색   
> 명령어: `docker search [이미지 명]`  
> ```bash
> # 예시
> docker search redmine
> 
> # 결과
> NAME                           DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
> redmine                        Redmine is a flexible project management web…   893                 [OK]                
> sameersbn/redmine                                                              316                                     [OK]
> bitnami/redmine                Bitnami Docker Image for Redmine                54                                      [OK]
> ...
> ```
> STAR: 즐겨찾기 수  
> OFFICIAL: 공식 이미지  
> AUTOMATED: Dockerfile을 바탕으로 자동 생성된 이미지     
>
> 필터링하기  
> 1000개 이상 즐겨찾기인 이미지만 탐색: `docker search --filter stars=1000 [이미지명]`  
> 공식 이미지만 탐색: `docker search --filter is-official=true [이미지명]`  

### 이미지 저장
> 저장: `docker image save -o export.tar [이미지명]`  
> 읽어들이기: `docker image load -i export.tar`  

---

## 컨테이너 실행
> 이미지를 삽입하여 도커 위에서 실행하는 프로세스

### 기본 명령어
> 컨테이너 생성 및 실행: `docker run [OPTIONS] [image명] [COMMAND] [ARGS...]`    
> 자주 사용하는 옵션(OPTIONS): `docker run --help` 로 확인가능  
>  
> 옵션 | 설명
> ----|----
> -e |	컨테이너 내에서 사용할 환경변수 설정
> -i | interactive 모드 : Keep STDIN open even if not attached
> -t | tty : pseudo-TTY 할당 (tty : 일반 CLI 콘솔 / CLI : Command Line Interface)
> -it |	-i와 -t를 동시에 사용한 것으로 터미널 입력을 위한 옵션
> –link |	컨테이너 연결 [컨테이너명:별칭]
> 
> 참조 사이트 : [초보를 위한 도커 안내서 - 설치하고 컨테이너 실행하기](https://subicura.com/2017/01/19/docker-guide-for-beginners-2.html)
>
> 컨테이너 중지: `docker stop [컨테이너 이름 or ID]`  
> 컨테이너 시작: `docker start [컨테이너 이름 or ID]`  
> 컨테이너 재시작: `docker restart [컨테이너 이름 or ID]`  
> 컨테이너 종료: `docker kill [컨테이너 이름 or ID]`  
> 컨테이너 삭제하기: `docker rm [컨테이너 이름 or ID]`  
> 실행 중인 컨테이너만 보기: `docker ps`  
> 종료된 컨테이너도 포함해서 보기: `docker ps -a`  

### 모든 컨테이너 삭제
> ```bash
> docker rm `docker ps -a`
> 
> # 혹은
> docker container prune -f
> ```

### 생성과 동시에 bash 접속
> "my-cent" 이름으로 centos 컨테이너 생성 후 bash 접속: `docker run -it --name "my-cent" centos /bin/bash`

### 한번 띄워서 테스트하고 종료하면 자동으로 삭제되는 컨테이너 생성
> `docker run -it --rm ubuntu /bin/bash`  

### 기존에 떠있는 Container에 bash 접속
> `docker exec -it [컨테이너 명] /bin/bash`  

### background 실행
> 컨테이너 background 실행: `docker run -d --name "my-cent" centos /bin/ping localhost`   
> ping localhost 실행 확인(-t 는 timestamp): `watch docker logs -t my-cent`

### 실행 후 자동 삭제
> stop이 아닌 삭제기 때문에 --name을 통해서 컨테이너에 이름을 줄 필요가 없음   
> `docker run -it --rm centos /bin/echo 'hello world'`

### 포트 맵핑
> Host OS와 컨테이너 포트 맵핑(Host OS Port:Container Port): `docker run -p 8080:80 nginx`
>
> 포트 맵핑된 포트 확인
> ```bash
> # 명령어
> docker port [컨테이너 명]
> # 결과
> # 내부 포트 -> Host OS 포트
> 80/tcp -> 0.0.0.0:8080
> ```

### 컨테이너 -> 이미지 만들기
> `docker commit -a "작성자" [컨테이너 명] [태그]:[이미지명]:[버전]`

### 컨테이너 tar export/import
> export: `docker container export [컨테이너 명] > sample.tar`  
> import: `cat sample.tar | docker image import - [임의지정 태그]/[임의지정 이미지명][임의지정 버전]`  

### 볼륨 마운트(디렉터리 맵핑)
> `-v [Host OS 디렉터리 경로]:[Container 디렉터리 경로]`  
> 설명: Host OS의 디렉터리 경로와 Container 디렉터리 경로를 맵핑한다.
> 
> 주의   
> Host OS에 해당 디렉터리 경로가 이미 존재하는 경우 Container 생성 시 기존 Host OS 디렉터리 경로에 있던 파일들이 그대로 유지된다.
> (마치 Host OS의 디렉터리를 Container의 디렉터리로 장착(마운트)하는 느낌)  
> Host OS에 해당 디렉터리 경로가 존재하지 않으면 해당 디렉터리를 생성한다. 
> 만약 볼륨으로 사용할 디렉터리가 비어 있는 디렉터리로 이미 존재하는 경우 해당 디렉터리가 Container에 장착(마운트) 됨으로 
> Container의 디렉터리에도 아무것도 존재하지 않는다.  

### 작업 디렉터리 지정
> 설명: --workdir 혹은 -w 사용하여 컨테이너 내부의 작업 디렉토리 지정하고 bash로 실행하면 해당 디렉터리에서 시작   
> 예제: `docker run -it -w=/home/workspace centos /bin/bash` 후 내부 쉘에서 `pwd` 시 /home/workspace가 나온다.

### 가동 상태 확인
> 실행 중인 컨테이너의 가동 상태 확인(CPU/Mem 점유율, Network IO 등): `docker stats [컨테이너 이름 or ID]`

### 실행 프로세스 확인
> 컨테이너 내부에서 실행 중인 프로세스 확인: `docker top [컨테이너 이름 or ID]`

### 컨테이너 종료
> `docker stop [컨테이너 명]`: 컨테이너 종료(하고 있는 작업을 마무리 하고 종료)  
> `docker kill [컨테이너 명]`: 컨테이너 강제 종료  

### 5초 후 종료
> `docker stop -t 5 [컨테이너 이름 or ID]`

---

## System
### 명령어
> Docker 자체 버전 및 정보 확인: `docker version`  
> Docker 실행 환경 확인: `docker info`  
> Docker 디스크 이용 상황 확인: `docker system df`  

## 도커 데이터 지우기
> 도커 데이터 용량 확인: `docker system df`    
> 도커 컨테이너 정리: `docker volume prune`  
> 도커 컨테이너 강제 삭제: `docker volume rm $(docker volume ls -q)`  

---

## Network
### 생성
> 기본: `docker network create [네트워크 명]`  
> driver 브릿지로 생성: `docker network create -d bridge web-network`    
> 서브넷 CIDR 지정: `docker network create --subnet=172.25.0.0/16 web-network`   

### 연결
> 기본: `docker network connect --net=[네트워크 명] [컨테이너 명]`  
> 컨테이너 생성과 동시에 연결: `docker run -itd --name=webap --net=web-network nginx`  

### 확인
> 목록 확인: `docker network ls`  
> 상세정보(네트워크의 gateway, subnet, 네트워크와 연결된 컨테이너 등) 확인: `docker network inspect [네트워크 명]`  

### 해제
> 기본: `docker network disconnect [네트워크 명] [컨테이너 명]`  

### 삭제
> 기본: `docker network rm [네트워크 명]`  

### 참조사이트
> [도커 네트워크 요약 (Docker Networking)](https://jonnung.dev/docker/2020/02/16/docker_network/)
