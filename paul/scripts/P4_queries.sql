----- 1. FROM 	Tarifzone
----- SELECT 	Nummer der Tarifzone,Fahrpreis, für Kinder
----- SORT		Sortieren Sie Tarifzone aufsteigend
--SELECT zoneid,zoneprice,zonepricereduced
--	FROM zone 
--	ORDER BY zoneid ASC;

----- 2. FROM	Liste aller Stationen 
----- SELECT	Stationsname,interne Stationsnummer, Linien???,
----- 			Betreibernamen, Linienname???, Stationsnummer
----- SORT		nach Betreibername, 
--SELECT stationname,stationid,a.linename,
--	(SELECT operatorname FROM line WHERE linename = a.linename)
--	,stationnumber 
--	FROM station a
--	ORDER BY operatorname;

----- 3a. FROM	
----- SELECT	stationsnamen als start genutzt, linename, limit 1
----- SORT		
--SELECT DISTINCT stationname, linename
--	FROM station
--	WHERE stationid IN (SELECT station_stationid FROM journey);

----- 3b. FROM	
----- SELECT	stationsnamen als start genutzt, linename, limit 1
----- SORT		
--EXPLAIN
--SELECT DISTINCT stationname, linename
--	FROM station
--	WHERE stationid IN (SELECT station_stationid FROM journey);


----- 4. FROM	junction
----- SELECT	junctionid,stationname, linename
----- SORT		in junctionid order by linename
--SELECT junctionid,stationname,linename
--	FROM station
--	WHERE junctionid >= 0
--	ORDER BY junctionid,linename;

----- 5. FROM	all junctions with different station names
----- SELECT	junctionid, stationname
----- SORT		
SELECT stationname
	FROM station
	LEFT JOIN junction ON junctionid = junctionid
	GROUP BY stationname;
----- 6. FROM	
----- SELECT	
----- SORT		
--SELECT 
--	FROM 
--	WHERE 
--	ORDER BY 