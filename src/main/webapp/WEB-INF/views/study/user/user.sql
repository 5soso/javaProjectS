show tables;

create table user (
	idx  int not null auto_increment primary key,
	mid  varchar(20) not null,
	name varchar(20) not null,
	age  int default 20,
	address varchar(10)
);

desc user;
select * from user;

insert into user value (default,'aaa1234','에이맨',20,'부산');
insert into user value (default,'bbb1234','비맨',20,'울산');
insert into user value (default,'ccc1234','씨맨',20,'전주');
insert into user value (default,'ddd1234','디맨',20,'제주');
insert into user value (default,'eee1234','이맨',20,'서울');

delete from user where idx = 7;


select * from user where name like '%맨%' order by idx desc;
select * from user where name like concat('%','맨','%') order by idx desc;