CREATE OR REPLACE FUNCTION triggerfunc()
RETURNS trigger
AS $function$
DECLARE 
  L_COUNT_OF_STATIONS INTEGER := COUNT_STATIONS(OLD.startstationid, NEW.endstationid, 0);
  L_OPERATORNAME varchar;
  L_CHILD BOOLEAN;
  L_FAREZONE INTEGER DEFAULT NULL;
  L_ZONE_ID INTEGER DEFAULT NULL;
  L_PRICE MONEY;
BEGIN
  RAISE INFO 'COMPLETE_TRIP'; 
  
  --YOUR CODE HERE
	RAISE INFO 'station count: %', L_COUNT_OF_STATIONS;
	select old.operatorname into L_OPERATORNAME from journey;
	RAISE INFO 'operator name: %', L_OPERATORNAME;
	select old.reducedprice into L_CHILD from journey;
	RAISE INFO 'traveler is a child: %', L_CHILD;
	select zoneid into L_ZONE_ID from zone where ( stationcount >= L_COUNT_OF_STATIONS );
	L_PRICE := calc_zone_price( L_COUNT_OF_STATIONS, L_CHILD, L_ZONE_ID );
	new.price := L_PRICE;
	perform book_money( old.ticketid, L_OPERATORNAME, L_PRICE );
  --YOUR CODE HERE
  RETURN NEW;  
  
END;
$function$
LANGUAGE plpgsql;

create TRIGGER COMPLETE_TRIP 
-- TRIGGER PARAMETERS HERE
BEFORE UPDATE OF endstationid ON journey
for each row
-- TRIGGER PARAMETERS HERE
EXECUTE PROCEDURE triggerfunc();