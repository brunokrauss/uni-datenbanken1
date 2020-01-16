create or replace FUNCTION CALC_ZONE_PRICE(
  IN_COUNT_OF_STATIONS integer,
  IN_CHILD  BOOL,
  IN_ZONE_ID  integer)
returns numeric
as $function$
declare 
L_PRICE MONEY;
L_MAXAMOUNTSTATIONS numeric;
begin
RAISE INFO 'CALC_ZONE_PRICE: Stations (%) price is reduced (%)', IN_COUNT_OF_STATIONS, IN_CHILD;

-- YOUR CODE HERE
	if ( IN_CHILD )
	THEN
		SELECT zonepricereduced INTO L_PRICE FROM zone WHERE zoneid = IN_ZONE_ID ORDER BY zonepricereduced ASC LIMIT 1;
		SELECT zoneMaxStations INTO L_MAXAMOUNTSTATIONS FROM zone WHERE zoneid = IN_ZONE_ID ORDER BY zonepricereduced ASC LIMIT 1;
	ELSE
		SELECT zoneprice INTO L_PRICE FROM zone WHERE zoneid = IN_ZONE_ID ORDER BY zoneprice ASC LIMIT 1;
		SELECT zoneMaxStations INTO L_MAXAMOUNTSTATIONS FROM zone WHERE zoneid = IN_ZONE_ID ORDER BY zoneprice ASC LIMIT 1;
	END IF;
	L_PRICE := (L_PRICE /L_MAXAMOUNTSTATIONS) *IN_COUNT_OF_STATIONS;
-- YOUR CODE HERE
   RETURN L_PRICE;

end;
$function$
language plpgsql;