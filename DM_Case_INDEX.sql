-- indexes

-- for reservation table
 
CREATE NONCLUSTERED INDEX ix_FK_member_id ON Reservation (member_id);
CREATE NONCLUSTERED INDEX ix_FK_tour_id ON Reservation (tour_id);
 
-- for tour table
 
CREATE NONCLUSTERED INDEX ix_FK_guide_id ON Tour (guide_id);
 
-- for site_tour table
 
CREATE NONCLUSTERED INDEX ix_FK_site_id ON site_tour (site_id);
 
-- for site_evaluation table
 
CREATE NONCLUSTERED INDEX ix_FK_member_id ON site_evaluation (member_id);
CREATE NONCLUSTERED INDEX ix_FK_site_id ON site_evaluation (site_id);
 
-- for site_tag table
CREATE NONCLUSTERED INDEX ix_FK_site_id ON site_tag (site_id);