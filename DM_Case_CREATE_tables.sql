DROP TABLE site_tag;
DROP TABLE tag;
DROP TABLE site_evaluation;
DROP TABLE evaluation;
DROP TABLE reservation;
DROP TABLE site_tour;
DROP TABLE site;
DROP TABLE tour;
DROP TABLE member;
DROP TABLE age_group;

-- creating tables

CREATE TABLE age_group(
	age_group_id INTEGER NOT NULL IDENTITY,
	age_group_name VARCHAR(256),
	age_group_instruction VARCHAR(4000),
	
	CONSTRAINT PK_age_group PRIMARY KEY (age_group_id)
);

CREATE TABLE member(
	member_id INTEGER NOT NULL IDENTITY,
	first_name VARCHAR(256) NOT NULL,
	surname VARCHAR(256) NOT NULL,
	email VARCHAR(256) NOT NULL,
	phone_no VARCHAR(256) NOT NULL,
	age_group_id INTEGER NOT null,
	
	CONSTRAINT PK_member PRIMARY KEY (member_id),
	CONSTRAINT FK_member_age_group FOREIGN KEY (age_group_id)
    	REFERENCES age_group (age_group_id),
    CONSTRAINT UNQ_member_email UNIQUE(email),
    CONSTRAINT UNQ_member_phone_no UNIQUE(phone_no),

	CHECK (email LIKE ('%@%.%')),
	CHECK (phone_no NOT LIKE ('%[^0-9+-.]%'))
);

CREATE TABLE tour(
	tour_id INTEGER NOT NULL IDENTITY,
	tour_name VARCHAR(256) NOT NULL,
	tour_date DATETIME2 NOT NULL,
	tour_status VARCHAR(1) NOT NULL,
	tour_description VARCHAR(4000) NOT NULL,
	guide_id INTEGER NOT NULL,

	CONSTRAINT PK_tour PRIMARY KEY (tour_id),
	CONSTRAINT FK_tour_member FOREIGN KEY (guide_id)
		REFERENCES member (member_id),
	CONSTRAINT UNQ_tour_tour_name UNIQUE(tour_name),

	CHECK (tour_status = 'A' OR tour_status = 'F' OR tour_status = 'C')
);

CREATE TABLE site(
	site_id INTEGER NOT NULL IDENTITY,
	site_name VARCHAR(256) NOT NULL,
	site_description VARCHAR (4000) NOT NULL,

	CONSTRAINT PK_site PRIMARY KEY (site_id),
	CONSTRAINT UNQ_site_site_name UNIQUE (site_name)
);

CREATE TABLE site_tour(
	site_id INTEGER NOT NULL,
	tour_id INTEGER NOT NULL,
	order_in_tour INTEGER NOT NULL

	CONSTRAINT PK_site_tour PRIMARY KEY (site_id, tour_id)
	CONSTRAINT FK_site_tour_site FOREIGN KEY (site_id)
		REFERENCES site (site_id),
	CONSTRAINT FK_site_tour_tour FOREIGN KEY (tour_id)
		REFERENCES tour (tour_id),
	CONSTRAINT UNQ_site_tour_tour_id_order UNIQUE (tour_id,order_in_tour)
);

CREATE TABLE reservation(
	member_id INTEGER  NOT NULL,
	tour_id INTEGER NOT NULL,
	reservation_date DATETIME2  NOT NULL DEFAULT GETDATE(),
	reservation_status VARCHAR(2)  NOT NULL,
	
	CONSTRAINT PK_reservation PRIMARY KEY (member_id,tour_id),
	CONSTRAINT FK_reservation_member FOREIGN KEY (member_id)
    	REFERENCES member (member_id),
    CONSTRAINT FK_reservation_tour FOREIGN KEY (tour_id)
    	REFERENCES tour (tour_id),

    CHECK (reservation_status IN ('OK', 'NO', 'WL'))  
);

CREATE TABLE evaluation(
	evaluation_id INTEGER  NOT NULL IDENTITY,
	evaluation_mark VARCHAR(256)  NOT NULL,
	
	CONSTRAINT PK_evaluation PRIMARY KEY (evaluation_id),
	CONSTRAINT UNQ_evaluation_evaluation_mark UNIQUE(evaluation_mark)
);

CREATE TABLE site_evaluation(
	site_id INTEGER  NOT NULL,
	member_id INTEGER  NOT NULL,
	evaluation_id INTEGER  NOT NULL,
	
	CONSTRAINT PK_site_evaluation PRIMARY KEY (site_id,member_id),
	CONSTRAINT FK_site_evaluation_site FOREIGN KEY (site_id)
    	REFERENCES site (site_id),
    CONSTRAINT FK_site_evaluation_member FOREIGN KEY (member_id)
    	REFERENCES member (member_id),
    CONSTRAINT FK_site_evaluation_evaluation FOREIGN KEY (evaluation_id)
    	REFERENCES evaluation (evaluation_id)
);

CREATE TABLE tag(
	tag_id INTEGER NOT NULL IDENTITY,
	tag_mark VARCHAR(256) NOT NULL,

	CONSTRAINT PK_tag PRIMARY KEY (tag_id),
	CONSTRAINT UNQ_tag_tag_mark UNIQUE (tag_mark)
);

CREATE TABLE site_tag(
	site_id INTEGER NOT NULL,
	tag_id INTEGER NOT NULL,

	CONSTRAINT PK_site_tag PRIMARY KEY (site_id, tag_id),
	CONSTRAINT FK_site_tag_site FOREIGN KEY (site_id)
		REFERENCES site (site_id),
	CONSTRAINT FK_site_tag_tag FOREIGN KEY (tag_id)
		REFERENCES tag (tag_id)
);

