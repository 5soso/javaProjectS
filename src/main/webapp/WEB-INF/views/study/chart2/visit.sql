show tables;

create table visit (
	visitDate datetime not null default now(),
	visitCount int not null default 1
);

desc visit;

select * from visit;

insert into visit values (date(now()), default); /* 시간까지 들어감 */
insert into visit values (default, default);
insert into visit values ('2023-12-27', 8);
insert into visit values ('2023-12-26', 10);
insert into visit values ('2023-12-25', 23);
insert into visit values ('2023-12-24', 20);
insert into visit values ('2023-12-23', 3);
insert into visit values ('2023-12-22', 11);
insert into visit values ('2023-12-21', 17);
insert into visit values ('2023-12-19', 15);
insert into visit values ('2023-12-18', 9);
insert into visit values ('2023-12-15', 14);
insert into visit values ('2023-12-16', 13);

delete from visit;

select * from visit order by visitDate desc limit 7;
select substring(visitDate, 1, 10) as visitDate, visitCount from visit order by visitDate desc limit 7; /* substring : sql은 1부터 시작 */





