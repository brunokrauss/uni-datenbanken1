COPY "operator"
FROM 'C:\Users\Bruno\Desktop\Coding\datenbanken-1\bruno\scripts\data\operators.csv' DELIMITER ',' CSV HEADER;

COPY "line"
FROM 'C:\Users\Bruno\Desktop\Coding\datenbanken-1\bruno\scripts\data\lines.csv' DELIMITER ',' CSV HEADER;

COPY "zone"
FROM 'C:\Users\Bruno\Desktop\Coding\datenbanken-1\bruno\scripts\data\zones.csv' DELIMITER ',' CSV HEADER;

COPY "junction"
FROM 'C:\Users\Bruno\Desktop\Coding\datenbanken-1\bruno\scripts\data\junctions.csv' DELIMITER ',' CSV HEADER;

COPY "station"
FROM 'C:\Users\Bruno\Desktop\Coding\datenbanken-1\bruno\scripts\data\stations.csv' DELIMITER ',' CSV HEADER;
