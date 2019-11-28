-- Aufgabe 3

-- SELECT * FROM station;
-- INSERT INTO station VALUES ('Shinjuku', 1, 23, 'foobar', 2);
-- UPDATE station SET linename='foobar' WHERE stationID=1;

-- SELECT * FROM line;
-- UPDATE line SET linename='foobar' WHERE linename='JR Yamanote';
-- DELETE FROM line WHERE linename='JR Yamanote';

-- Aufgabe 4

/*
alter table STATION drop constraint FK_STATION_USE_LINE;
alter table STATION add constraint FK_STATION_USE_LINE foreign key (LINENAME)
      references LINE (LINENAME) on delete cascade on update cascade;
UPDATE line SET linename='foobar' WHERE linename='JR Yamanote';
DELETE FROM line WHERE linename='Shinjuku';
SELECT * FROM station;
*/