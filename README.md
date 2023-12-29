# Project-3
### Topic: Prod와 Dev환경의 쇼핑몰 인프라 구축 & 재해 시 DR 이용한 서비스 복구

Total Architecture
![image](https://github.com/HBsoon/Project-3/assets/137377117/380dae04-e848-47f7-932b-105880a84050)


##
Infra Architecture
![image](https://github.com/HBsoon/Project-3/assets/137377117/8a8f9add-a5c3-4ee7-9c57-836b6c653767)

**설정**

- 리전
    - 서울: Prod, Dev 환경
    - 오사카: DR 환경
- GLB(L7, global load balancer)
    - DNS, SSL 인증서 연결
    - Armor 설정: 중국을 대상으로 한 지역 거부 정책 설정(해킹 방지)
    - CDN: 정적 콘텐츠 캐시 설정
- DB
    - 고가용성: Secondary DB
    - 데이터 백업 설정: 구글에서 관리하는 오사카 리전의 스토리지에 저장

**관리**

- Terraform code 사용: Infra code 관리
- Git branch: 분리된 환경 관리
    - main: Prod, Dev 환경
    - dr: DR 환경
- Terraform Cloud
    - state 파일 관리 및 공유
    - 권한 설정: 관리자 권한의 사용자만이 apply 후 변경 사항 인프라에 배포
      
##
CI Architecture
![image](https://github.com/HBsoon/Project-3/assets/137377117/69739729-a35f-4bae-983f-4605117dcbd2)

- CI
    - 소스 코드를 변경하고 Git hub에 push 시, Cloud build에서 설정된 트리거로 이미지를 build하고,
      빌드된 이미지는 SHORT_SHA 변수로 랜덤 태그가 붙어 GAR에 저장

##
CD Architecture
![image](https://github.com/HBsoon/Project-3/assets/137377117/e2267849-95e3-4d1f-a5a0-e34376e593d4)

- CD
    - 정의된 kustomize의 변경이 있을 시, Argocd가 감지하고 GAR의 이미지를 가져와 자동으로 배포
    - Sync Policy
        - Prod 환경: Manual
        - Dev 환경: Automatic
            
            ※ 초기 배포 후, 자동화 과정에 있어서
            
            Dev는 Automatic으로 설정하여 개발자가 코드 변경 후 push하면, 빠른 테스트 진행을 위해 자동으로 배포
            
            그에 반해 Prod는 Manual로 설정하여 자동으로 배포되지 않고, 운영 관리자의 확인을 거친 후 수동으로 배포
          
##
Monitoring Architecture
![image](https://github.com/HBsoon/Project-3/assets/137377117/965eb7c0-7dbb-4c60-adc4-962e67948f23)

- Monitoring: Cloud Monitoring
    - 기능 별 대시 보드 구성: 시스템 및 성능, 오류 및 보안으로 분류
    - Error Reporting: 에러 발생 시 세부 정보 확인 가능
- Alert: Slack

##
DR

- 재해 상황 판단
    - G-mail: 해당 리전의 서비스 중단을 확인 (GCP→운영자)
    - GCP Service Health 확인: 리전별 GCP 서비스 상태를 볼 수 있는 사이트에 접속하여 확인
- 설정
    - RTO/RPO: 1H/24H
    - 리전: 오사카
    - 구축 방법: Terraform
    - Cloud SQL: 데이터 백업 본을 통한 복원
    - GKE: Prod와 동일한 환경으로 구성
