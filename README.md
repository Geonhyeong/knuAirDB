# knuAirDB

* 실행 및 사용 방법
1. 처음 application 실행 시 mainmenu가 나옴
   1. 프로그램 종료 시, 1과 2를 제외한 아무 숫자 입력.
2. 회원가입
   1. 회원가입 시 아이디, 패스워드, 이름, 나이, 성별, 주소, 전화번호, 이메일, 회원종류(admin or passenger) 등을 입력받는다.
   2.  primary key인 AccountNo는 DB에 존재하는 AccountNo 중 최대값 + 1을 해주어 key integrity constraint를 위반하지 않도록 해주었다.
3.  로그인
1. ID와 Password를 입력하여 로그인
2. 회원의 종류(admin, passenger)에 따라 보이는 뷰가 다름
4. Passenger view
* 조회, 예약, 내 정보, 로그아웃, 계정삭제의 메뉴가 존재한다.
   1. 조회
      1. 출발 도시와 도착 도시, 출발 날짜를 입력하여 조회한다.
      2. DB에서 해당 정보를 조회하여 조건에 맞는 모든 LEG를 출력한다.
      3. 예약을 위해 LegID를 외워둬야 한다.
   2. 예약
      1. 조회에서 원하는 LegID를 입력한다.
      2. 해당 LEG의 남은 비행기 좌석을 각 클래스 별로 보여준다.
      3. 사용자는 클래스별 좌석 수와 수하물의 유무를 입력한다.
      4. application은 티켓 가격 계산 과정을 보여주고 최종적으로 결제 유무를 물어본다.
      5. 결제를 하면 DB에서 예약한 티켓정보가 추가되고 LEG의 남은 좌석이 변경된다.
      6. 또한, 사용자의 여행횟수가 증가하며 조건에 따라 멤버쉽 등급 또한 변경된다.
   3. 내 정보
* 예약한 티켓 정보, 내 정보 조회, 내 정보 변경의 메뉴가 존재한다.
      1. 예약한 티켓 정보
         1. 사용자가 예약한 모든 티켓의 LegID, 승객번호, 티켓 금액, 예약한 좌석 수를 출력한다.
      2. 내 정보 조회
         1. 사용자의 ID, 이름, 성별, 주소, 전화번호 등의 정보를 출력한다.
      3. 내 정보 변경
         1. 사용자의 정보를 변경할 수 있는 메뉴가 존재한다.
         2. 각 메뉴를 통해 세부 정보를 변경할 수 있다.
   4. 로그아웃
* 로그아웃하여 메인메뉴로 돌아간다.
   1. 계정 삭제
      1. 해당 사용자의 계정을 DB에서 삭제한다.
      2. 해당 사용자가 참조된 관련 레코드도 foreign key delete constraints에 따라 cascade되어 함께 삭제된다.
5. Admin view
* 관리, 내 정보, 로그아웃, 계정삭제의 메뉴가 존재한다.
   1. 관리
      1. Admin가 관리하는 Airplane, Airline, Airport, Leg를 선택할 수 있는 뷰를 보여준다.
      2. 선택한 Table에 대해 Insert, Update, Delete를 할 수 있다.
         1. Insert시 Admin은 모든 정보를 입력 한다. 성공적으로 Insert되었을 경우 최종 Insert된 결과를 보여준다.
         2. Update시 먼저 Admin은 Update하려는 레코드의 Primary key값인 ID값을 입력한다. 해당하는 레코드에 대해 원하는 정보를 Update한다.
         3. Delete시 Admin은 Delete하려는 레코드를 식별할 수 있는 ID값을 입력한다. 해당 레코드는 삭제되며 참조된 관련 레코드 또한  foreign key delete constraints에 따라 cascade되어 함께 삭제된다.
   2. 내 정보
      1. ID, 이름, 성, 성별, 주소 등의 내 정보를 출력
      2. 내 정보를 수정할 수 있는 ChangeMode menu가 출력되고 숫자 입력시 해당 모드에 접속, 변경할 내용 입력 시 수정 완료
   3. 로그아웃
* 로그아웃하여 메인메뉴로 돌아간다.
   1. 계정 삭제
      1. 해당 사용자의 계정을 DB에서 삭제한다.
      2. 해당 사용자가 참조된 관련 레코드도 foreign key delete constraints에 따라 cascade되어 함께 삭제된다.


        
* 유의사항
1. delete 관련 query 진행 시 Phase2-1의 constraints가 잘 들어가있어야함.
   1. Foreign Key Delete Constraints가 CASCADE로 확실히 들어가있는지 확인 필수!!
2. 대소문자 구분 필수
3. 메뉴에 있는 커맨드는 숫자만 입력 받으며, 메뉴에 없는 숫자 입력시 프로그램 종료됨
4. 정보 입력 시 괄호 내의 조건 잘 지키기 ex) 성별 : ‘M’ or ‘F’, 주소 : 50글자 이하 등등 (대소문자 구분 필수)


* 제작 환경
1. JDK 8 
2. ojdbc8.jar


* 수정된 쿼리
1. Phase2-1의 foreign key constraints 1개 변경 (쿼리 별도 첨부 - “Team4-Phase2-1.sql”)
* 수정 전 : ALTER TABLE LEG ADD FOREIGN KEY (AdminNO) references ACCOUNT(AccountNo) ON DELETE SET NULL;
* 수정 후 : ALTER TABLE LEG ADD FOREIGN KEY (AdminNO) references ACCOUNT(AccountNo) ON DELETE CASCADE;