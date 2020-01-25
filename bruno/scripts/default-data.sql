COPY "operator"
FROM 'C:/tmp/operators.csv' DELIMITER ',' CSV HEADER;

COPY "line"
FROM 'C:/tmp/lines.csv' DELIMITER ',' CSV HEADER;

COPY "zone"
FROM 'C:/tmp/zones.csv' DELIMITER ',' CSV HEADER;

COPY "junction"
FROM 'C:/tmp/junctions.csv' DELIMITER ',' CSV HEADER;

COPY "station"
FROM 'C:/tmp/stations.csv' DELIMITER ',' CSV HEADER;


-- COPY "junction"
-- FROM 'C:/Users/pmoeller/workspace/uni-datenbanken1/bruno/scripts/data/junctions.csv' DELIMITER ',' CSV HEADER;
	
-- COPY "line"
-- FROM 'C:/Users/pmoeller/workspace/uni-datenbanken1/bruno/scripts/data/lines.csv' DELIMITER ',' CSV HEADER;
	
-- COPY "operator"
-- FROM 'C:/Users/pmoeller/workspace/uni-datenbanken1/bruno/scripts/data/operators.csv' DELIMITER ',' CSV HEADER;
	
-- COPY "station"
-- FROM 'C:/Users/pmoeller/workspace/uni-datenbanken1/bruno/scripts/data/stations.csv' DELIMITER ',' CSV HEADER;
	
-- COPY "zone"
-- FROM 'C:/Users/pmoeller/workspace/uni-datenbanken1/bruno/scripts/data/zones.csv' DELIMITER ',' CSV HEADER;