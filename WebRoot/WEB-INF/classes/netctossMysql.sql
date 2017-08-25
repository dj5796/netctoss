-----------------------创建SQL课程需要的表(Jeffrey)-------------------------
--管理员信息表
drop table admin_info;

CREATE TABLE admin_info(
   id int(11) PRIMARY KEY auto_increment,
   admin_code VARCHAR(30) UNIQUE NOT NULL,
   password VARCHAR(30) NOT NULL,
   name VARCHAR(30) NOT NULL,
   telephone VARCHAR(30),
   email VARCHAR(50),
   enrolldate DATETIME NOT NULL
);

delete from admin_info;

insert into admin_info values(1001,'jeffrey','123456','jeffrey','15966668888','yourzjf@163.com',now());
insert into admin_info values(1002,'admin','111111','lily','13688997766','shiyl@sin.com',now());

commit;

select * from admin_info;

desc admin_info;

--资费信息表

drop table cost;

create table cost(
  id 					int(4) primary key auto_increment,
  name 				varchar(50)  not null,
  base_duration 	int(11),
  base_cost 		double(7,2),
  unit_cost 		double(7,4),
  status 			char(1),
  descr 				varchar(100),
  creatime 			datetime,
  startime 			datetime,
  costtype    	char(1) not null
  );

delete from cost;

insert into cost values (null,'5.9元套餐',20,5.9,0.4,1,'5.9元20小时/月,超出部分0.4元/时',now(),null,'1');
insert into cost values (null,'6.9元套餐',40,6.9,0.3,1,'6.9元40小时/月,超出部分0.3元/时',now(),null,'2');
insert into cost values (null,'8.5元套餐',100,8.5,0.2,1,'8.5元100小时/月,超出部分0.2元/时',now(),null,'3');
insert into cost values (null,'10.5元套餐',200,10.5,0.1,1,'10.5元200小时/月,超出部分0.1元/时',now(),null,'3');
insert into cost values (null,'计时收费',null,null,0.5,1,'0.5元/时,不使用不收费',now(),null,'1');
insert into cost values (null,'包月',null,20,null,1,'每月20元,不限制使用时间',now(),null,'2');

INSERT INTO cost VALUES (null,'18元套餐',20,5.9,0.4,0,'18元40小时/月,超出部分0.4元/时',now(),now(),'1');
INSERT INTO cost VALUES (null,'28元套餐',40,6.9,0.3,0,'28元60小时/月,超出部分0.3元/时',now(),now(),'1');
INSERT INTO cost VALUES (null,'38元套餐',100,8.5,0.2,0,'38元100小时/月,超出部分0.2元/时',now(),now(),'1');
INSERT INTO cost VALUES (null,'58元套餐',200,10.5,0.1,0,'58元200小时/月,超出部分0.1元/时',now(),now(),'1');
INSERT INTO cost VALUES (null,'88元套餐',400,10.5,0.1,0,'88元400小时/月,超出部分0.1元/时',now(),now(),'1');
INSERT INTO cost VALUES (null,'包月2',null,200,null,0,'每月200元,不限制使用时间',now(),now(),'2');

commit;

desc cost;

select * from cost;

select id, name from cost;

delete from cost where id >10;
--帐务信息表

drop table account;

create table account(
 id					int(9) primary key auto_increment,
 recommender_id	int(9) references account(id),
 login_name			varchar(30) not null unique,
 login_passwd		varchar(30) not null,
 status				char(1),
 create_date		datetime,
 pause_date			datetime,
 close_date			datetime,
 real_name			varchar(20)	not null,
 idcard_no			char(18)		not null unique,
 birthdate			datetime,
 gender	         char(1),
 occupation			varchar(50),
 telephone			varchar(15) not null,
 email				varchar(50),
 mailaddress		varchar(50),
 zipcode				char(6),
 qq					varchar(15),
 last_login_time	datetime,
 last_login_ip		varchar(15)
);

delete from account;

insert into account(id,recommender_id,login_name,login_passwd,status,create_date,real_name,birthdate,idcard_no,telephone)
values(1005,null,'taiji001','256528',1,'2008-03-15','zhangsanfeng','19430225','410381194302256528',13669351234);

insert into account(id,recommender_id,login_name,login_passwd,status,create_date,real_name,birthdate,idcard_no,telephone)
values(1010,null,'xl18z60','190613',1,'2009-01-10','guojing','19690319','330682196903190613',13338924567);

insert into account(id,recommender_id,login_name,login_passwd,status,create_date,real_name,birthdate,idcard_no,telephone)
values(1011,1010,'dgbf70','270429',1,'2009-03-01','huangrong','19710827','330902197108270429',13637811357);

insert into account(id,recommender_id,login_name,login_passwd,status,create_date,real_name,birthdate,idcard_no,telephone)
values(1015,1005,'mjjzh64','041115',1,'2010-03-12','zhangwuji','19890604','610121198906041115',13572952468);

insert into account(id,recommender_id,login_name,login_passwd,status,create_date,real_name,birthdate,idcard_no,telephone)
values(1018,1011,'jmdxj00','010322',1,'2011-01-01','guofurong','19960101','350581200201010322',18617832562);

insert into account(id,recommender_id,login_name,login_passwd,status,create_date,real_name,birthdate,idcard_no,telephone)
values(1019,1011,'ljxj90','310346',1,'2012-02-01','luwushuang','19930731','320211199307310346',13186454984);

insert into account(id,recommender_id,login_name,login_passwd,status,create_date,real_name,birthdate,idcard_no,telephone)
values(1020,null,'kxhxd20','012115',1,'2012-02-20','weixiaobao','20001001','321022200010012115',13953410078);

commit;

desc account;

update account set login_passwd = '111111' where id = 1021;

update account set status = '0';

update account set status = '1' where id in(1011);

select * from account;

delete from account where id = 1022;

--UNIX服务器信息表

drop table host;

create table host
(
 id 			varchar(15) primary key,
 name 		varchar(20), 
 location	varchar(30)
);

delete from host;

insert into host values ('192.168.0.26','sunv210','beijing');
insert into host values('192.168.0.20','sun-server','beijing');
insert into host values ('192.168.0.23','sun280','beijing');
insert into host values ('192.168.0.200','ultra10','beijing');

commit;

desc host;

select * from host;

--业务信息表

drop table service;

create table service(
 id					int(10) 		primary key auto_increment,
 account_id			int(9)  not null,
 unix_host			varchar(15) not null,
 os_username		varchar(8)	not null,
 login_passwd		varchar(8) not null,
 status 				char(1),	
 create_date		datetime,
 pause_date			datetime,
 close_date			datetime,
 cost_id				int(4) not null,
 constraint fk_serv_acc_id foreign key(account_id) references netctoss.account(id),
 constraint fk_serv_host_uhost foreign key(unix_host) references netctoss.host(id),
 constraint fk_serv_cost_id foreign key(cost_id) references netctoss.cost(id),
 unique(unix_host,os_username)
);

delete from service;

insert into service values (2001,1010,'192.168.0.26','guojing','guo1234',0,'2009-03-10 10:00:00',null,null,1);
insert into service values (2002,1011,'192.168.0.26','huangr','huang234',0,'2009-03-01 15:30:05',null,null,1);
insert into service values (2003,1011,'192.168.0.20','huangr','huang234',0,'2009-03-01 15:30:10',null,null,3);
insert into service values (2004,1011,'192.168.0.23','huangr','huang234',0,'2009-03-01 15:30:15',null,null,6);
insert into service values (2005,1019,'192.168.0.26','luwsh','luwu2345',0,'2012-02-10 23:50:55',null,null,4);
insert into service values (2006,1019,'192.168.0.20','luwsh','luwu2345',0,'2012-02-10 00:00:00',null,null,5);
insert into service values (2007,1020,'192.168.0.20','weixb','wei12345',0,'2012-02-10 11:05:20',null,null,6);
insert into service values (2008,1010,'192.168.0.20','guojing','guo09876',0,'2012-02-11 12:05:21',null,null,6);

insert into service values (null,1010,'192.168.0.23','guojing','guo09876',1,'2012-02-11 12:05:21',null,null,6);
commit;

desc service;desc service_update;

select * from service;

--联合条件更新
update service s, account a set s.status=1, s.pause_date=null where account_id = a.id and a.status = 0 and s.id = 2007 ;

--service_update 更新缓存表
drop table service_update;

create table service_update(
	id int(10) primary key auto_increment,
	service_id int(10) not null,
	unix_host varchar(15) not null,
	os_username varchar(8)	not null,
	cost_id	int(4) not null,
	create_date datetime,
	constraint fk_supdate_cost_id foreign key(cost_id) references netctoss.cost(id),
	constraint fk_supdate_host_uhost foreign key(unix_host) references netctoss.host(id),
	constraint fk_supdate_service_id foreign key(service_id) references netctoss.service(id)
);


desc service_update;

select * from service_update;

--联合查询service
select s.id, s.account_id, a.idcard_no, a.real_name, s.os_username, s.status, s.unix_host, c.name, c.descr
from service s, account a, cost c
where s.account_id = a.id
and s.cost_id = c.id
and a.idcard_no = '330682196903190613'
and s.os_username = 'guojing'
and s.unix_host = '192.168.0.26'
and s.status = '0';

---------------------------------------

create table role
(
  id   int(9) primary key auto_increment,
  name VARCHAR(20)
);

insert into role (id, name) values (1, '系统管理员');

select * from role;

delete from role where id in(7,8,10);

desc role;

delete from role where id > 1;

create table admin_role
(
  admin_id int(11) not null,
  role_id  int(9) not null,
	constraint ar_pk primary key (admin_id, role_id)
);

insert into admin_role (admin_id, role_id)values (1, 1);

create table role_privilege
(
  role_id      int(9) not null,
  privilege_id int(9) not null,
  constraint rp_pk primary key (role_id, privilege_id)
);

insert into role_privilege (role_id, privilege_id) values (1, 1);
insert into role_privilege (role_id, privilege_id) values (1, 2);
insert into role_privilege (role_id, privilege_id) values (1, 3);
insert into role_privilege (role_id, privilege_id) values (1, 4);
insert into role_privilege (role_id, privilege_id) values (1, 5);
insert into role_privilege (role_id, privilege_id) values (1, 6);
insert into role_privilege (role_id, privilege_id) values (1, 7);
commit;

select * from role_privilege;

desc role_privilege;

show tables;


