Drop DATABASE GLOVO;
CREATE DATABASE GLOVO;
USE GLOVO;

CREATE TABLE users (
  id bigint  primary key
  , signed_up_time timestamp  not null
);

INSERT INTO users VALUES
(21665572, '2019-08-06 22:15:07.000000'),
(54371473, '2021-03-13 18:23:00.000000'),
(35542086, '2020-03-30 07:30:43.000000'),
(66277153, '2021-08-08 15:43:47.000000'),
(66100073, '2021-08-05 18:14:41.000000'),
(  823086, '2017-09-04 20:25:10.000000'),
(46003429, '2020-10-06 15:31:54.000000'),
(23084377, '2019-09-05 19:06:15.000000'),
(  543404, '2017-06-04 18:25:37.000000'),
(33159214, '2020-02-29 14:43:24.000000');

CREATE TABLE stores (
  id bigint  primary key
  , name varchar(200) not null
);

INSERT INTO stores VALUES
( 12391,"Vientos Madrid"),
( 91878,"Telepizza"),
(100398,"Dragón Inn"),
(127484,"Peggy Sue's"),
( 67696,"KFC"),
(266277,"Mezopotamya Doner Kebab"),
(206133,"McDonald's"),
(165703,"Domino's Pizza"),
( 49114,"Foster's Hollywood"),
( 55575,"VIPS"),
( 56545,"KFC"),
(120341,"Pizza Hut"),
(170036,"Marjane"),
( 52140,"McDonald's"),
( 69356,"Wendy's"),
( 81515,"Nikora Supermarket"),
( 81517,"Carrefour"),
( 88059,"Fire Wok"),
(197609,"Baristo Pizza");

CREATE TABLE orders (
  id bigint primary key
  , creation_time timestamp not null
  , user_id bigint not null
  , store_id bigint
  , total_price float not null
  , final_status varchar(20) not null
);

INSERT INTO orders VALUES
(203279281,'2021-01-31 17:56:47.000000',46003429, 88059, 31   ,'DeliveredStatus'),
(206329446,'2021-02-08 15:09:50.000000',  823086,206133, 65.85, 'CanceledStatus'),
(212421733,'2021-02-24 11:57:56.000000',46003429, 81517, 40   ,'DeliveredStatus'),
(233772332,'2021-04-22 18:48:50.000000',21665572,206133, 13.4 ,'DeliveredStatus'),
(208651824,'2021-02-14 14:49:30.000000',46003429,206133, 40.4 ,'DeliveredStatus'),
(210623539,'2021-02-19 18:47:45.000000',  823086,206133, 30   ,'DeliveredStatus'),
(217869483,'2021-03-09 17:54:11.000000',  823086, 81517,  0   , 'CanceledStatus'),
( 58939645,'2019-08-15 22:41:30.000000',  543404, 12391,  6.5 ,'DeliveredStatus'),
( 96463197,'2020-01-31 22:20:34.000000',21665572,127484,  0   , 'CanceledStatus'),
( 63241735,'2019-09-08 11:32:57.000000',21665572, 55575, 37.65,'DeliveredStatus'),
( 59454444,'2019-08-18 19:45:53.000000',  543404, 12391,  6.5 ,'DeliveredStatus'),
(212513212,'2021-02-24 16:10:40.000000',35542086,206133, 18.7 ,'DeliveredStatus'),
(184213022,'2020-12-09 16:00:44.000000',  823086,206133, 30.15,'DeliveredStatus'),
(162485047,'2020-10-07 07:34:52.000000',46003429,  null, 14.2 ,'DeliveredStatus'),
( 73374015,'2019-10-26 11:16:36.000000',21665572, 49114, 29.55,'DeliveredStatus'),
(195361592,'2021-01-10 15:56:39.000000',46003429,165703,  6.6 ,'DeliveredStatus'),
(273415827,'2021-08-10 09:44:45.000000',66277153,170036, 10.15,'DeliveredStatus'),
(146845287,'2020-08-15 11:58:16.000000',23084377,206133,  8.7 ,'DeliveredStatus'),
( 84584719,'2019-12-11 21:08:41.000000',21665572,206133, 16.7 ,'DeliveredStatus'),
(184098974,'2020-12-09 10:30:42.000000',46003429, 88059, 20.5 ,'DeliveredStatus'),
(274871238,'2021-08-14 11:56:57.000000',66277153,120341, 14   ,'DeliveredStatus'),
(195966721,'2021-01-12 12:59:07.000000',  823086,165703,  4.2 ,'DeliveredStatus'),
(115098638,'2020-04-21 19:39:02.000000',21665572, 91878, 23.5 ,'DeliveredStatus'),
(210135143,'2021-02-18 14:53:30.000000',46003429,165703, 16.1 ,'DeliveredStatus'),
(273414058,'2021-08-10 09:38:32.000000',66277153,170036, 20.6 ,'DeliveredStatus'),
(189464608,'2020-12-23 17:05:00.000000',46003429,197609, 16   ,'DeliveredStatus'),
( 74418928,'2019-10-30 22:20:27.000000',21665572,206133, 16.8 ,'DeliveredStatus'),
( 95738805,'2020-01-28 20:52:44.000000',23084377,206133, 19.85,'DeliveredStatus'),
(211448360,'2021-02-21 15:48:55.000000',  823086,206133, 40.85,'DeliveredStatus'),
(183453430,'2020-12-07 14:16:53.000000',  823086,206133, 30.35, 'CanceledStatus'),
(139135976,'2020-07-17 21:04:07.000000',21665572,206133,  8.7 ,'DeliveredStatus'),
(209122467,'2021-02-15 15:26:24.000000',46003429,206133, 68.05,'DeliveredStatus'),
(274795134,'2021-08-14 08:15:44.000000',66277153,170036, 66   ,'DeliveredStatus'),
( 72266196,'2019-10-20 21:27:00.000000',21665572,206133, 17.45,'DeliveredStatus'),
(212287085,'2021-02-23 20:04:04.000000',46003429, 88059, 20   ,'DeliveredStatus'),
(274100915,'2021-08-12 10:13:57.000000',66277153,170036, 50   ,'DeliveredStatus'),
(180901552,'2020-11-30 16:04:45.000000',46003429,206133, 22.4 ,'DeliveredStatus'),
(194992947,'2021-01-09 16:45:23.000000',  823086,206133, 27.9 ,'DeliveredStatus'),
(215322188,'2021-03-03 15:37:07.000000',46003429, 52140, 41.2 , 'CanceledStatus'),
(182199954,'2020-12-04 14:54:47.000000',46003429, 69356,  9.5 ,'DeliveredStatus'),
( 62611973,'2019-09-05 11:59:34.000000',  543404,100398, 19.65,'DeliveredStatus'),
(162484138,'2020-10-07 07:24:56.000000',  823086, 81515, 39.28, 'CanceledStatus'),
( 75864024,'2019-11-05 22:03:28.000000',21665572,206133, 16.8 ,'DeliveredStatus'),
(185806539,'2020-12-13 18:00:17.000000',46003429,165703, 22.8 ,'DeliveredStatus'),
(227514197,'2021-04-04 19:09:41.000000',21665572,266277,  8   ,'DeliveredStatus'),
( 74766149,'2019-11-01 13:11:17.000000',23084377, 56545, 11.58,'DeliveredStatus'),
(156465503,'2020-09-17 20:14:17.000000',23084377,206133, 12.5 ,'DeliveredStatus'),
( 88279030,'2019-12-26 21:09:35.000000',21665572,206133, 17.45,'DeliveredStatus'),
(186508363,'2020-12-15 18:45:43.000000',46003429, 81517, 50   , 'CanceledStatus');
