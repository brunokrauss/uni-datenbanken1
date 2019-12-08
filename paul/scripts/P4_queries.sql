----- 1.	Nummer der Tarifzone,Fahrpreis, für Kinder
-----		sortieren Sie Tarifzone aufsteigend
--SELECT zoneid,zoneprice,zonepricereduced
--	FROM zone 
--	ORDER BY zoneid ASC;

----- 2.	Liste aller Stationen 
----- 		Stationsname,interne Stationsnummer, Linien???,
----- 		Betreibernamen, Linienname???, Stationsnummer
-----		sortieren nach Betreibername, 
--SELECT stationname,stationid,a.linename,
--	(SELECT operatorname FROM line WHERE linename = a.linename)
--	,stationnumber 
--	FROM station a
--	ORDER BY operatorname;

----- 3a.	stationsnamen als start genutzt
-----		linename, limit 1	
--SELECT DISTINCT stationname, linename
--	FROM station
--	WHERE stationid IN (SELECT station_stationid FROM journey);

----- 3b. 	stationsnamen als start genutzt, linename, limit 1
----- 		explain function		
--EXPLAIN
--SELECT DISTINCT stationname, linename
--	FROM station
--	WHERE stationid IN (SELECT station_stationid FROM journey);


----- 4. 	junctionid,stationname, linename
-----       order by linename
--SELECT junctionid,stationname,linename
--	FROM station
--	WHERE junctionid >= 0
--	ORDER BY junctionid,linename;

----- 5.	all junctions with different station names
--  	select station.stationname,station.junctionid from (				-- format to stationname, junctionid, group by name,id
--  		select junctionid from (										-- show only distinct junction ids
--  			select junctionid, count(*) as anzahl from (				-- check for multiple entries in junctionid row
--  				select junctionid,stationname from station				-- create table with junctionid, stationname; grouped by junctionid,stationname
--  					where junctionid is not null
--  					group by junctionid, stationname
--  					order by junctionid) as test
--  				group by junctionid) test2
--  			where anzahl > 1) as test3
--  		join station station on station.junctionid = test3.junctionid
--  		group by station.stationname, station.junctionid;
	
----- 6a.	Anzahl aller Umsteigebahnhöfe pro Linie
-----		Liniennamen und die Anzahl
-----		sortieren Sie das Ergebnis absteigend nach der Anzahl
/*
SELECT linename, COUNT(linename) AS junctioncount
	FROM station
	WHERE junctionid >= 0
	GROUP BY linename
	ORDER BY junctioncount DESC;
*/

----- 6b.	Schränken Sie das Ergebnis ein, mindestens vier Umsteigebahnhöfen angezeigt werden.
--SELECT linename, COUNT(linename) AS junctioncount
--	FROM station
--	WHERE junctionid >= 0
--	GROUP BY linename
--	HAVING COUNT(linename) >= 4
--	ORDER BY junctioncount DESC;
	
----- 7.	wie viele Tickets vom Typ „Card“ haben maximale Karten-Guthaben
-----		Geben Sie dieses maximale Guthaben im Ergebnis mit aus
--SELECT COUNT(ticketcardbalance) AS count_C_cards_with_max_value, max(ticketcardbalance) AS max_ticketcard_value
--	FROM ticketcard
--	WHERE (ticketcardbalance = (SELECT max(ticketcardbalance) from ticketcard)
--		  AND type = 'C')
--	  GROUP BY ticketcardbalance;

----- 8.	Formulieren Sie eine Aufgabenstellung, die in Ihrem Datenmodell sowohl
-----		a) mit einem Join aus Kreuzprodukt und equi-Join-Bedingung in der where-Klausel als auch
-----		b) mit einem Subselect-Join zu lösen ist.
-- zeigen sie die stationsnamen, liniennamen und den dazugehörigen hexfarbcode in einer tabelle
-- variante 1
--SELECT stationname, station.linename, hexcolorcode
--	FROM station
--	JOIN line
--	ON station.linename = line.linename;
-- variante 2	
--SELECT station.stationname, station.linename, line.hexcolorcode
--	FROM station, line
--	WHERE station.linename = line.linename;
	
-- SELECT stationname, linename, (SELECT hexcolorcode FROM line WHERE station.linename = line.linename )
-- 	FROM station;