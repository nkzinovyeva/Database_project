--1. Listing available tours with their enrolment count and sites to be visited

SELECT tour_id, tour_name, participants, "tour date", "starts at", 
string_agg( t1.site_name , ' , ')  WITHIN GROUP (ORDER BY t1.site_name asc ) AS "sites to be visited"
FROM (
    SELECT  tour.tour_id, tour.tour_name, 
	    COUNT(DISTINCT reservation.member_id ) AS "participants" ,
	    CONVERT(DATE, tour.tour_date ) AS "tour date",
        CONVERT(TIME, tour.tour_date ) AS "starts at",
	    site_name--string_agg( site.site_name , ' , ')  WITHIN GROUP (ORDER BY site_tour.order_in_tour asc ) AS "sites to be visited"
        FROM tour JOIN  site_tour ON (tour.tour_id = site_tour.tour_id) 
					   JOIN  site ON (site_tour.site_id = site.site_id) 
					   LEFT JOIN reservation ON (reservation.tour_id  = tour.tour_id) 
        WHERE reservation.reservation_status  = 'OK' AND tour.tour_status = 'A'
    GROUP BY tour.tour_id, tour.tour_name, tour.tour_date, tour.tour_status,site_name
    ) AS t1
GROUP BY  tour_id, tour_name, participants, "tour date", "starts at"

--2. Making an enrolment for a tour

	INSERT INTO reservation(member_id ,tour_id , reservation_status )
	VALUES (5, 5, 
	(CASE WHEN (SELECT COUNT(*) FROM reservation 
                                WHERE reservation.tour_id = 5 AND reservation.reservation_status = 'OK') < 9 
	 THEN 'OK' ELSE 'WL' END)
	)

--3. Cancelling a tour enrolment

	UPDATE reservation 
		SET reservation_status = 'NO'
	WHERE member_id = 5 AND tour_id = 5


--4. Listing the waypoints (Sites) of a tour.	

	SELECT site_tour.order_in_tour , site.site_name   
	FROM site_tour JOIN site ON (site_tour.site_id = site.site_id)
	WHERE site_tour.tour_id  = 1
	ORDER BY site_tour.order_in_tour 





--6. Listing the Sites and reading the details of each site, e.g. the tags related to the site. 
	--E.g. Helsinki Velodrome might have the tags “1940”,”1952 Olympics”,”Functionalism”. 
	--Malmi airport might have the tags “1936”, “Functionalism”, “Aviation”.
	--Kisakylä in Käpylä might have tags “1952 Olympics”,”Housing”.
	
	SELECT site.site_name, site.site_description, 
    string_agg( tag.tag_mark, ' , ')  WITHIN GROUP (ORDER BY tag.tag_mark asc ) AS "sites tags"
    FROM site JOIN site_tag ON (site_tag.site_id = site.site_id)
					JOIN tag ON tag.tag_id = site_tag.tag_id 
	GROUP BY site.site_name, site.site_description
    --WHERE lower(tag.tag_mark) like '%church%'
	






--7. Cancelling the whole tour (e.g. when organizer sick, or only 1-2 customers enrolled)

	UPDATE tour 
	SET tour.tour_status = 'C'
	WHERE tour_id = 5;

--8. Emailing all enrolled people in the case of a cancelled tour.
	
	SELECT email FROM member JOIN reservation ON member.member_id = reservation.member_id 
	JOIN tour ON (tour.tour_id = reservation.tour_id)
	WHERE tour.tour_id = 5 AND tour.tour_status = 'C';

--9. Maintaining a custom instruction text (specific to each age group).

	UPDATE age_group  
	SET age_group_instruction = 'instruction'
	WHERE age_group_id = 2;
    
    --test--
    SELECT * FROM age_group

--10. Even if customer is encouraged to SELECT the agegroup,this is not obligatory. So,we mighthave
customers for whom the age group is not specified.
	
	SELECT * FROM member 
    JOIN age_group ON (age_group.age_group_id = member.age_group_id)
	WHERE age_group.age_group_name = 'Not specified';

--11. For the organizer : Listingnames(and possible age groups) for all customers of a tour.
	
	SELECT member.first_name  + ' ' + member.surname AS Participats, age_group.age_group_name  
	FROM member JOIN reservation ON (reservation.member_id = member.member_id) 
						   JOIN tour ON (tour.tour_id = reservation.tour_id)
						   JOIN age_group ON (age_group.age_group_id = member.age_group_id )
	 WHERE tour.tour_id = 4 AND reservation.reservation_status = 'OK'
	 
----------------------------

--1. Who are the organizers of the tours organized 2020-06-20?
	
	SELECT  member.first_name  + ' ' + member.surname AS organizer, tour.tour_name 
	FROM tour JOIN member ON (tour.guide_id = member.member_id)
	WHERE CONVERT(DATE, tour.tour_date ) =  '2020-06-20' 
	 
--2. What are all the tags that can be associated to a certain tour X?

SELECT DISTINCT tag.tag_mark 
FROM tour JOIN site_tour ON (tour.tour_id = site_tour.tour_id)
					 JOIN site_tag ON (site_tag.site_id = site_tour.site_id)
					 JOIN tag ON (tag.tag_id = site_tag.tag_id)
WHERE tour.tour_id = 4

	 
--3. List of tours ON a certain day, and along each tour the list of tags for each tour.
	 
SELECT tour_name, 
string_agg( tag_mark , ' , ')  WITHIN GROUP (ORDER BY tag_mark asc ) AS "tour tags"
FROM (
SELECT DISTINCT tour.tour_name, tag.tag_mark
FROM tour JOIN site_tour ON (tour.tour_id = site_tour.tour_id)
					 JOIN site_tag ON (site_tag.site_id = site_tour.site_id)
					 JOIN tag ON (tag.tag_id = site_tag.tag_id) 
	 WHERE CONVERT(DATE, tour.tour_date ) =  '2020-06-20'
	 ) AS t1
GROUP BY tour_name
	 
	 
--4. Which sites have lowest evaluations by the biggest agegroup?

SELECT DISTINCT site.site_name 
FROM site_evaluation 
JOIN evaluation ON (site_evaluation.evaluation_id = evaluation.evaluation_id)
			JOIN member ON (member.member_id = site_evaluation.member_id)
			JOIN age_group ON (age_group.age_group_id = member.age_group_id)
			JOIN site ON (site.site_id = site_evaluation.site_id)
WHERE age_group.age_group_name = 'Senior: 51-69 y.o.' AND evaluation.evaluation_mark = 'Would never visit'
	 
	 
--5. What are the tags (in order of occurrances) for the sites that people belonging to agegroup X have
--evaluated with the highest evaluations? This is a quite long JOIN query, do not expect to see the
--needed tables be connected directly but via a long path.	 

SELECT tag.tag_mark , COUNT(*) AS "evaluations count"
FROM site_evaluation JOIN evaluation ON (site_evaluation.evaluation_id = evaluation.evaluation_id)
				        JOIN member ON (member.member_id = site_evaluation.member_id)
						JOIN age_group ON (age_group.age_group_id = member.age_group_id)
						JOIN site_tag ON (site_tag.site_id = site_evaluation.site_id)
						JOIN tag ON (tag.tag_id = site_tag.tag_id)
WHERE age_group.age_group_name = 'Senior: 51-69 y.o.' AND evaluation.evaluation_mark = 'Enjoyable'
GROUP BY tag.tag_mark 
ORDER BY "evaluations count" desc

--6. Full report of tour X attendees: organizer + enrollees with their names and agegroup.	 
	
	SELECT org.first_name  + ' ' + org.surname as organizer , member.first_name  + ' ' + member.surname as participant, 
    age_group.age_group_name  
	FROM member JOIN reservation ON (reservation.member_id = member.member_id)
						   JOIN tour ON (tour.tour_id = reservation.tour_id) 
						   JOIN age_group ON (age_group.age_group_id = member.age_group_id)
						   JOIN member AS org ON (org.member_id = tour.guide_id )
	 WHERE tour.tour_id =4 AND reservation.reservation_status = 'OK'
    
	 
--7. The itinerary for tour X, the way points = sites in order, and the tags for each site
	
	SELECT site.site_name, site_tour.order_in_tour, 
    string_agg(tag.tag_mark , ' , ')  WITHIN GROUP (ORDER BY site_tour.order_in_tour ) AS tags
	FROM tour JOIN site_tour ON (tour.tour_id = site_tour.tour_id)
						 JOIN site ON (site.site_id = site_tour.site_id)
						 LEFT JOIN site_tag ON (site_tag.site_id = site_tour.site_id)
						 LEFT JOIN tag ON (tag.tag_id = site_tag.tag_id)
	WHERE tour.tour_id = 4
	GROUP BY site.site_name, site_tour.order_in_tour
	ORDER BY site_tour.order_in_tour
					   
	 
--8. What tags are not yet in use = not used by any site?

	SELECT * FROM tag WHERE tag.tag_id NOT IN (SELECT site_tag.tag_id FROM site_tag )