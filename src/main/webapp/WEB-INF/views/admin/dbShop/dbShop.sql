show tables;

/* 대분류 */
create table categoryMain(
  categoryMainCode  char(1)  not null,		/* 대분류코드(A,B,C,...) => 영문 대문자 1자(중복불허) */
  categoryMainName  varchar(20) not null, /* 대분류명(회사명 => 삼성/현대/LG...(중복불허) */
  primary key(categoryMainCode),
  unique key(categoryMainName)
);

/* 중분류 */
create table categoryMiddle(
	categoryMainCode  char(1)  not null,			/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2)  not null,		/* 중분류코드(01,02,03,...) => 문자형 숫자 2자(중복불허) */
  categoryMiddleName  varchar(20) not null, /* 중분류명(제품분류명 => 전자제품/생활가전/차종/의류/신발류...(중복불허) */
  primary key(categoryMiddleCode),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode)
);

/* 소분류 */
create table categorySub(
	categoryMainCode  char(1)  not null,			/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2)  not null,		/* 중분류코드를 외래키로 지정 */
  categorySubCode  char(3)  not null,				/* 소분류코드(001,002,003,...) => 문자형 숫자 2자(중복불허) */
  categorySubName  varchar(20) not null, 		/* 소분류명(상품구분 => 중분류가 전자제품이라면? 냉장고/에어컨/오디오/TV */
  primary key(categorySubCode),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode),
  foreign key(categoryMiddleCode) references categoryMiddle(categoryMiddleCode)
);

/* 세분류(상품 테이블) */
create table dbProduct (
  idx  int not null, 				/* 상품 고유번호 */
	categoryMainCode  char(1)  not null,			/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2)  not null,		/* 중분류코드를 외래키로 지정 */
  categorySubCode  char(3)  not null,				/* 소분류코드를 외래키로 지정 */
  productCode   varchar(20) not null,				/* 상품고유코드(대분류코드+중분류코드+소분류코드+상품고유번호) 예 : A 01 002 5 */
  productName   varchar(50) not null,				/* 상품명(상품모델명) */
  detail				varchar(100) not null,			/* 상품의 간단설명(초기화면 메인창에 출력할 간단한 설명) */
  mainPrice     int not null,								/* 상품의 기본가격 */
  fSName				varchar(200) not null,			/* 상품의 기본사진(1장이상 처리시는 '/'로 구분한다. */
  content				text not null,							/* 상품의 상세설명 - ckeditor를 이용 */
  primary key(idx),
  unique key(productCode,prodectName),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode),
  foreign key(categoryMiddleCode) references categoryMiddle(categoryMiddleCode),
  foreign key(categorySubCode) references categorySub(categorySubCode)
);

/* 상품 옵션 */
create table dbOption (
  idx    int not null auto_increment, /* 옵션 고유번호 */
  productIdx int not null,						/* product테이블(상품)의 고유번호 - 외래키로 지정 */
  optionName varchar(50) not null, 		/* 옵션 이름 */
  optionPrice int not null default 0, /* 옵션 가격 */
  primary key(idx),
  foreign key(productIdx) references dbProduct(idx)
);

desc categoryMain;
desc categoryMiddle;
desc categorySub;
desc dbProduct;
desc dbOption;

/* ================ 상품 주문 시작시에 사용하는 테이블들~ ==================== */

/* 장바구니 테이블 */
create table dbCart (
  idx   int not null auto_increment,			/* 장바구니 고유번호 */
  cartDate datetime default now(),				/* 장바구니에 상품을 담은 날짜 */
  mid   varchar(20) not null,							/* 장바구니를 사용한 사용자의 아이디 - 로그인한 회원 아이디이다. */
  productIdx  int not null,								/* 장바구니에 구입한 상품의 고유번호 */
  productName varchar(50) not null,				/* 장바구니에 담은 구입한 상품명 */
  mainPrice   int not null,								/* 메인상품의 기본 가격 */
  thumbImg		varchar(100) not null,			/* 서버에 저장된 상품의 메인 이미지 */
  optionIdx	  varchar(50)	 not null,			/* 옵션의 고유번호리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  optionName  varchar(100) not null,			/* 옵션명 리스트(배열처리) */
  optionPrice varchar(100) not null,			/* 옵션가격 리스트(배열처리) */
  optionNum		varchar(50)  not null,			/* 옵션수량 리스트(배열처리) */
  totalPrice  int not null,								/* 구매한 모든 항목(상품과 옵션포함)에 따른 총 가격 */
  primary key(idx,mid),
  /* unique key(mid), */
  foreign key(productIdx) references dbProduct(idx) on update cascade on delete restrict
  /* foreign key(mid) references member2(mid) on update cascade on delete cascade */
);
drop table dbCart;
desc dbCart;
delete from dbCart;
select * from dbCart;


/* 주문 테이블 */
create table dbOrder (
  idx   int not null auto_increment,			/* 고유번호 */
  orderIdx   varchar(15) not null,				/* 주문 고유번호(새로 만들어준다.) */
  mid   varchar(20) not null,							/* 주문자 아이디 - 로그인한 회원 아이디이다. */
  productIdx  int not null,								/* 주문한 상품의 고유번호 */
  orderDate   datetime default now(),			/* 실제 주문을 한 날짜 */
  productName varchar(50) not null,				/* 상품명 */
  mainPrice   int not null,								/* 메인상품의 기본 가격 */
  thumbImg		varchar(100) not null,			/* 서버에 저장된 상품의 메인 이미지 */
  optionName  varchar(100) not null,			/* 옵션명 리스트(배열처리) */
  optionPrice varchar(100) not null,			/* 옵션가격 리스트(배열처리) */
  optionNum		varchar(50)  not null,			/* 옵션수량 리스트(배열처리) */
  totalPrice  int not null,								/* 구매한 모든 항목(상품과 옵션포함)에 따른 총 가격 */
  primary key(idx,orderIdx),
  foreign key(mid) references member2(mid),
  foreign key(productIdx) references dbProduct(idx) on update cascade on delete restrict
);
desc dbOrder;
select * from dbOrder;

