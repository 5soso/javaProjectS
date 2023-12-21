show tables;
drop table board2;

create table board2 (
  idx  int not null auto_increment,	/* 게시글의 고유번호 */
  mid  varchar(30) not null,				/* 게시글 올린이 아이디 */
  nickName varchar(30) not null,		/* 게시글 올린이 닉네임 */
  title   varchar(100) not null,		/* 게시글 제목 */
  email   varchar(60),							/* 이메일 주소 */
  homePage varchar(60),							/* 홈페이지(개인블로그) 주소 */
  content text not null,						/* 게시글 내용 */
  readNum	int not null default 0,		/* 글 조회수 */
  hostIp	varchar(40) not null,			/* 글 올린이 IP */
  openSw	char(2) default 'OK',			/* 게시글의 공개여부(OK:공개, NO:비공개) */
  wDate		datetime default now(),		/* 글 올린 날짜(시간) */
  good		int default 0,						/* '좋아요' 클릭 횟수 누적 */  
  primary key(idx)
  /*unique(mid)*/
);

desc board2;

insert into board2 values (default,'admin','관리맨','게시판서비스를 시작합니다.','apple_1114@naver.com','admin1234.tistory.com','게시할 내용들을 입력해 주세요',default,'192.168.50.65',default,default,default);
select * from board2;

/* 게시판에 댓글 달기 */
create table board2Reply (
	idx 			int not null auto_increment,   /* 댓글의 고유번호 */
	boardIdx 	int not null, 							   /* 원본글(부모글)의 고유번호(외래키로 설정) */
	re_step   int not null, 								 /* 레벨(re_step값)에 따른 들여쓰기(계층번호) : 부모댓글의 re_step은 0이다. 대댓글의 경우는 부모re_step +1 로 처리한다 */
	re_order  int not null, 								 /* 댓글의 순서를 결정한다. 부모댓글은 1번, 대댓글의 경우는 부모댓글보다 큰 대댓글에 대하여 're_order + 1' 시키고, 자신의 부모댓글의 re_order보다 1개 더 증가시킨다. ??*/
	mid				varchar(30) not null,				   /* 댓글 올린이의 아이디 */
	nickName	varchar(30) not null, 			   /* 댓글 올린이의 닉네임 */
	wDate			datetime default now(),			   /* 댓글 올린 날짜 */  -- 게시글 올린 날짜와 상관 없음.
	hostIp		varchar(50) not null,				   /* 댓글 올린 PC의 고유 IP */
	content		text not null,							   /* 댓글 내용 */
	primary key(idx),
	foreign key(boardIdx) references board2(idx)
	on update cascade		/* 부모필드를 수정하면 함께 영향을 받는다. */
	on delete restrict 	/* 부모필드를 함부로 삭제할 수 없다. */
);
desc board2Reply;

insert into board2Reply values(default,17,'kms1234','김장미',default,'210.100.20.25','글을 참조했습니다.' );
insert into board2Reply values(default,17,'hkd1234','홍장군',default,'200.130.25.2','좋은글 감사합니다.' );
insert into board2Reply values(default,16,'hkd1234','홍장군',default,'200.130.25.2','안녕하세요.' ); 

select * from board2Reply;

select b.*,br.nickName from board2 b, board2Reply br where b.idx=br.boardIdx;
select b.*,br.nickName,br.boardIdx from board2 b, board2Reply br where b.idx=(select boardIdx from board2Reply where boardIdx=17 limit 1);
select b.*,br.nickName,br.boardIdx from board2 b, (select * from board2Reply where boardIdx=17) br where b.idx=17;

----------------------------------------------------------------------------------------------------------------------
/* 댓글수 연습 */
/* 게시판(board2)리스트화면에서 글제목옆에 해당글의 댓글(board2Reply)수를 출력해보자...*/
-- 전체 board2테이블의 내용을 최신순으로 출력?
select * from board2 order by idx desc;

-- board2 테이블 고유번호 17번에 해당하는 댓글테이블의 댓글수는?
select count(*) from board2Reply where boardIdx = 16;
select count(*) from board2Reply where boardIdx = 17;

-- 앞의 예에서 원본글의 고유번호와 함께, 총 댓글의 개수는 replyCnt란 변수로 출력하시오.
select boardIdx, count(*) as replyCnt from board2Reply where boardIdx = 17; 

-- 앞의 예제에 이어서, 원본글을 쓴 닉네임도 함께 출력시켜보자.(여기서 닉네임은 부모테이블에서 가져와서 출력한다.)  = 필드를 출력해라
select boardIdx, count(*) as replyCnt, (select nickName from board2 where idx=17) as nickName  from board2Reply where boardIdx = 17; 

-- 앞의 내용을 부모관점(board2)에서 처리...
-- 18번 게시글의 mid와 닉네임을 출력
select mid, nickName from board2 where idx = 17;

-- 앞에 이어서 닉네임을 자식(댓글테이블)에서 가져와서 보여주시오.
select mid, (select nickName from board2Reply where boardIdx=17 limit 1) as nickName from board2 where idx = 17;

-- 부모글(원본글)에 해당하는 자식글(댓글)의 갯수를 부모글과 함께 출력하시오.
select mid, (select count(*) from board2Reply where boardIdx=17) as nickName from board2 where idx = 17; 
select *, (select count(*) from board2Reply where boardIdx=17) as replyCnt from board2 where idx = 17; 





/* new.gif를 24시간동안만 보여주기 위한 처리 */http://192.168.50.65:9090/javaProject/boardContent.bo?idx=17&pag=1&pageSize=5
select * from board2 order by idx desc limit 0, 10;
select *, datediff(wDate, now()) from board2 order by idx desc limit 0, 10;
select *, timestampdiff(hour, wDate, now()) from board2 order by idx desc limit 0, 10;

/* 이전글/다음글 꺼내오기 */
select * from board2 where idx = 7; -- 현재글
select * from board2 where idx < 7 order by idx desc limit 1; -- 이전글
select * from board2 where idx > 7 order by idx limit 1; -- 다음글

/* 날짜 함수 연습 */
select now();
/* date_add() - datetime형식 비교 */
select now() as 오늘날짜, date_add(now(), interval 1 day);
select now() as 오늘날짜, date_add(now(), interval -1 day);
select now() as 오늘날짜, date_add(now(), interval 10 hour);
select now() as 오늘날짜, date_add(now(), interval -10 hour) as preHour;

/* date_sub() */
select now() as 오늘날짜, date_sub(now(), interval 1 day);
select now() as 오늘날짜, date_sub(now(), interval -1 day);

/* board2테이블에 적용 */
-- 게시글 중에서 하루전에 올라온 글만 보여주시오.
select wDate, date_add(now(), interval 1 day) from board2;
select substring(wDate,1,10), substring(date_add(now(), interval 1 day),1,10) from board2;
select idx, nickName, wDate from board2 where substring(wDate,1,10) = substring(date_add(now(), interval -1 day),1,10);

/* 날짜차이 계산 : DateDiff(시작날짜, 마지막날짜) - int형식 비교 */
select datediff('2023-11-14', now());
select datediff(now(), wDate) from board2;
select idx, nickName, wDate from board2 where wDate >= date_add(now(), interval -2 day);
select idx, nickName, wDate from board2 where wDate between date_add(now(), interval -2 day) and now();

/*  */
select timestampdiff(hour, now(), wDate) from board2;
select timestampdiff(day, now(), wDate) from board2;
select timestampdiff(day, wDate, now()) from board2;

/* 날짜형식(date_format(날짜형식자료, 포맷)) : 년도 4자리(%Y), 월(%m), 일(%d), 시간(%H), 분(%i) */
select wDate, date_format(wDate, '%Y-%m-%d') from board2;
select wDate, date_format(wDate, '%Y-%m-%d %H:%i') from board2;



/*-----------------------------------------------------------*/
select * from board2 order by idx desc limit 0,5;

select *,datediff(wDate, now()) as date_diff,
  timestampdiff(hour, wDate, now()) as hour_diff
  from board2 order by idx desc limit 0,15;

