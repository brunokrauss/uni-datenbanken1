create or replace FUNCTION CALC_ZONE_PRICE(
  IN_COUNT_OF_STATIONS integer,
  IN_CHILD_ADULT  CHAR,
  IN_ZONE_ID  integer)
returns numeric
as $function$
declare 
L_PRICE numeric;
L_MAXAMOUNTSTATIONS numeric;
begin
RAISE INFO 'CALC_ZONE_PRICE: Stations (%) (%)', IN_COUNT_OF_STATIONS, IN_CHILD_ADULT;

-- YOUR CODE HERE
   RETURN L_PRICE;

end;
$function$
language plpgsql;

