create or replace FUNCTION COUNT_STATIONS (IN_STARTSTATION integer,
										   IN_ENDSTATION integer,
										   IN_LINEID integer)

RETURNS integer
as $function$
declare L_RESULT integer;
declare L_ISCIRCLE boolean;
BEGIN
RAISE INFO 'COUNT_STATIONS: from(%) to (%) ',IN_STARTSTATION,IN_ENDSTATION; 

-- YOUR CODE HERE
	-- there could be an if condition to check weather the stations are even on the same line
	-- probably thats what IN_LINEID is for
	IN_STARTSTATION := (select stationnumber from station where stationid = IN_STARTSTATION);
	IN_ENDSTATION := (select stationnumber from station where stationid = IN_ENDSTATION);
	L_RESULT := ABS( IN_STARTSTATION - IN_ENDSTATION );
	IF ( L_RESULT = 0 )
		THEN
		L_ISCIRCLE := true;
		L_RESULT := 30;
	END IF;
-- YOUR CODE HERE
   RETURN L_RESULT;
   
END;
$function$
LANGUAGE plpgsql;