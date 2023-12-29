show tables;

create table qrCode(
	idx int not null auto_increment primary key, 			/* 고유번호 */
	mid varchar(20) not null, 												/* 아이디 */
	name varchar(30) not null, 												/* 이름 */
	email varchar(50) not null, 											/* 이메일 */
	movieName varchar(50) not null, 									/* 영화 이름 */
	movieDate varchar(50) not null, 									/* 영화 상영날짜 */
	movieTime varchar(50) not null, 									/* 영화 상영시간 */
	movieAdult int not null, 													/* 성인 티켓수 */
	movieChild int not null, 													/* 어린이티켓수 */
	publicShow varchar(50) not null, 									/* 발행일자 */
	qrCodeName varchar(50) not null 									/* QR코드명 */
);

desc qrCode;

select * from qrCode;

select * from qrCode where qrCodeName = '20231229143043_해리포터_2023-12-29_22시00분_3_0_btom';