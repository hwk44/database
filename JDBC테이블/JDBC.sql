CREATE TABLE member (
  id varchar(10) NOT NULL,
  pass varchar(10) NOT NULL,
  name varchar(30) NOT NULL,
  regidate timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (id)
);

create table board (
    num int not null auto_increment,
    title varchar(200) not null,
    content varchar(2000) not null,
    id varchar(10) not null, 
    postdate timestamp default current_timestamp not null,
    visitcount decimal(6),
    primary key (num)
);
alter table board
    add constraint board_mem_fk foreign key (id)
    references member (id);

insert into member (id, pass, name) values();

insert into board (title, content, id, visitcount) values ('제목1입니다', '내용1입니다', 'musthave', 0);
insert into board (title, content, id, visitcount) values ('제목2입니다', '내용2입니다', 'musthave2', 1);
insert into board (title, content, id, visitcount) values ('제목3입니다', '내용3입니다', 'musthave3', 2);
insert into board (title, content, id, visitcount) values ('제목4입니다', '내용4입니다', 'musthave4', 3);
insert into board (title, content, id, visitcount) values ('제목5입니다', '내용5입니다', 'musthave5', 4);board

create table myfile(
idx int primary key,
name varchar(50) not null,
title varchar(200) not null,
cate varchar(30) not null,
ofile varchar(100) not null,
sfile varchar(30) not null,
postdate datetime default CURRENT_TIMESTAMP
);

SELECT *  FROM myfile ORDER BY idx DESC;

drop table mvboard;
create table mvboard(
idx int primary key,
name varchar(50) not null,
title varchar(200) not null,
content varchar(2000) not null,
postdate datetime default CURRENT_TIMESTAMP,
ofile varchar(200) ,
sfile varchar(30) ,
downcount int default 0 not null,
pass varchar(50) not null,
visitcount int default 0 not null
);

insert into mvboard(name ,title,content,pass)
values ('김유신', '자료실 제목1입니다.', '내용', '1234');
insert into mvboard(name ,title,content,pass)
values ('장보고', '자료실 제목2입니다.', '내용', '1234');
insert into mvboard(name ,title,content,pass)
values ('이순신', '자료실 제목3입니다.', '내용', '1234');
insert into mvboard(name ,title,content,pass)
values ('강감찬', '자료실 제목4입니다.', '내용', '1234');
insert into mvboard(name ,title,content,pass)
values ('대조영', '자료실 제목5입니다.', '내용', '1234');
insert into mvboard(name ,title,content,pass)
values ('이산', '자료실 제목6입니다.', '내용', '1234');