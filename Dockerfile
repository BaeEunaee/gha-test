# 베이스 이미지로 Ubuntu를 사용합니다.
FROM ubuntu:20.04

LABEL "maintainer"="seydyd0406@naver.com"

# 비인터렉티브 모드로 설정하여 설치 중에 질문을 방지합니다.
ENV DEBIAN_FRONTEND=noninteractive

# 필요한 패키지를 설치합니다.
RUN apt-get update && \
    apt-get install -y nginx tzdata gawk && \
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Nginx 설정 파일을 추가합니다.
COPY nginx.conf /etc/nginx/nginx.conf

# 로그 분석 스크립트를 추가합니다.
COPY analyze_logs.sh /usr/local/bin/analyze_logs.sh
RUN chmod +x /usr/local/bin/analyze_logs.sh

# Nginx의 기본 웹 페이지를 추가합니다.
COPY index.html /var/www/html/index.html

# Nginx의 80 포트를 노출합니다.
EXPOSE 80

# Nginx를 시작합니다.
CMD ["nginx", "-g", "daemon off;"]

# 아래는 analyze_logs.sh 스크립트의 예시입니다.
