-- insert values into database

INSERT INTO age_group (age_group_name, age_group_instruction) VALUES
	('Youth: 15-17 y.o.', 'more active tempo of a tour'),
	('Adult: 18-50 y.o.', 'middle level tempo of a tour'),
	('Senior: 51-69 y.o.', 'relaxed tempo of a tour'),
	('Old-old: 70+ y.o.', 'slow tempo of a tour'),
	('Not specified', 'Not specified');


INSERT INTO member (first_name, surname, email, phone_no, age_group_id) VALUES
	('Sten', 'Koppel', 'stenkoppel@hotmail.eu', '0405608970', 1),
	('Maria', 'Trust', 'maria.truuu@hotmail.com', '0406789012', 5),
	('Madu', 'Othman', 'mohhamedothman@outlook.eg', '0459870909', 3),
	('Reija', 'Jokinen', 'reija.jokinen@mcd.com', '0501234590', 4),
	('Zohaib', 'Malik', 'zohaibmalikkk@gmail.com', '0405623689', 3),
	('Hadi', 'Kanbar', 'hadihadihadi@outlook.lb', '0457623401', 2),
	('Satu', 'Honkanen', 'satuhonkanen@gmail.com', '0406287639', 2),
	('Arttu', 'Pisinen', 'pisinenpisi@hotmail.com', '0508234091', 1),
	('Olga', 'Ivanova', 'olechka787@mail.ru', '0451328967', 4),
	('Seppo', 'Karisto', 'seppo.karisto@hh.fi', '0456723415', 3),
	('Antti', 'Koskinen', 'koskinen111@outlook.com', '0456723112', 2),
	('Nikita', 'Ponomarev', 'nikitaponomarev@outlook.fi', '0449876541', 2),
	('Sara', 'Kanerva', 'sara.kanerva@outlook.fi', '0451009878', 2);

INSERT INTO tour (tour_name, tour_date, tour_status, tour_description, guide_id) VALUES
	('Most popular places in Helsinki', '2020-06-20 10:00:00', 'A', 'Top 10 popular places in Helsinki according to TripAdvisor', 2),
	('1952 Olympics sites', '2020-07-01 11:00:00', 'F', 'The most interesting site of olympic games 1952', 2),
	('The best parks in Helsinki', '2020-06-01 09:00:00', 'F', 'The most beautiful and green parks to spend a lovely day', 13),
	('Helsinki historical tour', '2020-07-29 09:30:00', 'A', 'Refresh and learn more about Finnish history and culture', 13),
	('Suomenlinna tour', '2020-07-15 10:00:00', 'C', 'Explore the highlights of the Supmenlinna island and its history', 5);

INSERT INTO site (site_name, site_description) VALUES
	('Parliament House', 'The seat of the Parliament of Finland'),
	('Velodrome', 'An arena for track cycling. Modern velodromes feature steeply banked oval tracks, consisting of two 180-degree circular bends connected by two straights'),
	('Laakso Riding Hall', 'Riding arena in the Central park area'),
	('Olympiaterminaali', 'A dock in the South Harbour of Helsinki. and was opened for the 1952 Summer Olympics. Today, the terminal has a regular connection to Stockholm'),
	('Kaivopuisto', 'One of the oldest and best known parks in central Helsinki, Finland, and also a neighbourhood of about 500 inhabitants where the park is located'),
	('Esplanaadi', 'Colloquially known as Espa, is an esplanade and urban park in downtown Helsinki, Finland, situated between the Erottaja square and the Market Square'),
	('Pihlajasaari', 'A former villa island that is now a versatile outdoor recreation area. It still has a few old villas set amongst rocks, wooded areas, groves and beaches'),
	('Kaisaniemi', 'A part of the centre of Helsinki, Finland. It is located immediately north of the Helsinki Central railway station'),
	('Sibelius Park', 'Based an informal English-style landscape garden adapted to the typically Finnish shoreline environment.'),
	('Helsinki Cathedral', 'The Finnish Evangelical Lutheran cathedral of the Diocese of Helsinki, located in the neighborhood of Kruununhaka'),
	('Temppeliaukion Church', 'Excavated directly into solid rock, the Temppeliaukio church is situated in the heart of Helsinki'),
	('Uspenski Cathedral', 'An Eastern Orthodox cathedral in Helsinki, Finland, and main cathedral of the Orthodox Church of Finland'),
	('Suomenlinna Museum', 'The main museum of the fortress is located in the Suomenlinna Centre and is open throughout the year'),
	('Suomenlinna Church', 'It was built as a Russian Orthodox church and later converted into a Lutheran place of worship'),
	('Dry Dock', 'One of Europe oldest operational dry docks. In the 1760s, ships for the Swedish naval fleet were built here'),
	('Kustaanmiekka', 'Home to Suomenlinna痴 original bastion and a late-19th-century Russian defence line, complete with sand embankments and artillery points');

INSERT INTO site_tour (site_id, tour_id, order_in_tour) VALUES
	(1, 1, 3),
	(1, 4, 2),
	(2, 2, 1),
	(3, 2, 2),
	(4, 2, 3),
	(5, 1, 6),
	(5, 3, 4),
	(6, 3, 3),
	(7, 3, 5),
	(8, 3, 2),
	(8, 2, 4),
	(9, 3, 1),
	(9, 1, 1),
	(10, 4, 3),
	(10, 1, 4),
	(11, 4, 1),
	(11, 1, 2),
	(12, 4, 4),
	(12, 1, 5),
	(13, 4, 5),
	(13, 5, 1),
	(14, 5, 2),
	(15, 5, 3),
	(16, 5, 4);

INSERT INTO evaluation (evaluation_mark) VALUES 
('Enjoyable')
,('Highly recommend')
,('Okay')
,('Only as a filler')
,('Would never visit');

INSERT INTO reservation (member_id,tour_id,reservation_date,reservation_status) VALUES 
(1,1,'2020-06-19 09:45:00.000','OK')
,(1,4,'2020-07-28 09:15:00.000','OK')
,(2,4,'2020-07-27 09:00:00.000','OK')
,(3,3,'2020-05-29 08:15:00.000','OK')
,(3,4,'2020-07-26 08:45:00.000','OK')
,(3,5,'2020-07-12 09:15:00.000','NO')
,(4,2,'2020-06-27 10:00:00.000','OK')
,(4,3,'2020-05-28 08:00:00.000','OK')
,(4,4,'2020-07-25 08:30:00.000','OK')
,(5,2,'2020-06-26 09:45:00.000','OK')
,(5,3,'2020-05-27 07:45:00.000','OK')
,(5,4,'2020-07-24 08:15:00.000','OK')
,(6,1,'2020-06-14 08:30:00.000','OK')
,(6,4,'2020-07-23 08:00:00.000','OK')
,(7,1,'2020-06-13 08:15:00.000','NO')
,(7,4,'2020-07-22 07:45:00.000','OK')
,(8,3,'2020-05-24 07:00:00.000','OK')
,(8,4,'2020-07-21 07:30:00.000','OK')
,(8,5,'2020-07-07 08:00:00.000','NO')
,(9,2,'2020-06-22 08:45:00.000','OK')
,(9,3,'2020-05-23 06:45:00.000','OK')
,(9,4,'2020-07-20 07:15:00.000','OK')
,(10,2,'2020-06-21 08:30:00.000','OK')
,(10,3,'2020-05-22 06:30:00.000','NO')
,(10,4,'2020-07-19 07:00:00.000','NO')
,(11,1,'2020-06-09 07:15:00.000','OK')
,(11,4,'2020-07-18 06:45:00.000','OK')
,(12,1,'2020-06-08 07:00:00.000','OK')
,(12,4,'2020-07-17 06:30:00.000','OK')
,(13,5,'2020-07-02 06:45:00.000','NO');

INSERT INTO site_evaluation (site_id,member_id,evaluation_id) VALUES 
(2,4,1)
,(2,5,2)
,(2,9,3)
,(2,10,1)
,(3,4,1)
,(3,5,3)
,(3,9,1)
,(3,10,1)
,(4,4,1)
,(4,5,1)
,(4,9,1)
,(4,10,1)
,(5,3,1)
,(5,4,1)
,(5,5,1)
,(5,8,1)
,(5,9,2)
,(5,10,1)
,(6,3,1)
,(6,4,5)
,(6,5,1)
,(6,8,2)
,(6,9,1)
,(6,10,2)
,(7,3,1)
,(7,4,2)
,(7,5,1)
,(7,8,2)
,(7,9,1)
,(7,10,1)
,(8,3,5)
,(8,4,1)
,(8,5,2)
,(8,8,1)
,(8,9,1)
,(8,10,4)
,(9,3,5)
,(9,4,1)
,(9,5,5)
,(9,8,1)
,(9,9,3)
,(9,10,1);

INSERT INTO tag(tag_mark) VALUES
('1940'),
('1952 Olympics'),
('Functionalism'),
('1936'),
('Aviation'),
('Housing'),
('Park'),
('Sport'),
('Church'),
('Bastion'),
('Museum'),
('Island'),
('Ferry'),
('Sea');

INSERT INTO site_tag (site_id,tag_id) VALUES 
(1,6)
,(1,10)
,(2,1)
,(2,2)
,(2,8)
,(3,8)
,(4,12)
,(4,13)
,(5,7)
,(8,7)
,(9,7)
,(10,9)
,(10,10)
,(11,9)
,(11,10)
,(12,9)
,(12,10)
,(13,7)
,(13,9)
,(13,10)
,(13,11)
,(13,12)
,(13,14)
,(14,9)
,(14,10)
,(16,14);