----- delete all journeys with id below 10
--DELETE FROM journey WHERE journeyid < 10;
----- delete all ticketcards with id below 10
--DELETE FROM ticketcard WHERE ticketid < 10;

----- insert four ticket card
INSERT INTO ticketcard VALUES (1, 1, 9999999999, 'T');
INSERT INTO ticketcard VALUES (2, 1, 1456416, 'T');
INSERT INTO ticketcard VALUES (3, 1, 12316, 'C');
INSERT INTO ticketcard VALUES (4, 1, 9999999999, 'C');

----- insert 4 journeys 	(at least two full price/reduced price,
-----						one station uses twice as start,
-----						at least 2 ticketcards with may balance)
INSERT INTO journey VALUES (1,NULL, 'Toei', 1, 1, '20190712', false, 150);
INSERT INTO journey VALUES (2,NULL, 'Toei', 2, 1, '20190712', true, 75);
INSERT INTO journey VALUES (3, NULL, 'Toei', 3, 3, '20190712', true, 75);
INSERT INTO journey VALUES (4, NULL, 'Toei', 4, 3, '20190712', false, 150);

-- SELECT * FROM operator;
-- SELECT * FROM ticketcard;
SELECT * FROM journey;
