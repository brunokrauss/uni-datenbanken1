create or replace FUNCTION COUNT_STATIONS (IN_STARTSTATION integer,
										   IN_ENDSTATION integer,
										   IN_LINEID integer)

RETURNS integer
as $function$
declare L_RESULT integer;
declare L_ISCIRCLE boolean;
declare L_LINE varchar;
BEGIN
RAISE INFO 'COUNT_STATIONS: from(%) to (%) ',IN_STARTSTATION,IN_ENDSTATION; 

-- YOUR CODE HERE
	L_LINE := (select linename from station where endstationid = IN_STARTSTATION);

	IN_STARTSTATION := (select stationnumber from station where endstationid = IN_STARTSTATION);
	IN_ENDSTATION := (select stationnumber from station where endstationid = IN_ENDSTATION);

	--RAISE INFO 'COUNT_STATIONS: line is (%) ', L_LINE; 
	IF (L_LINE = 'JR Yamanote')
	THEN
	--RAISE INFO 'this is the jr jamanote if condition hit'; 
	-- jr yamanote line
	L_RESULT := LEAST( 30 -IN_STARTSTATION, 30 -IN_ENDSTATION); -- get the smallest value between the two stations in the circle line
		IF ( L_RESULT = 0 ) -- at least full round trip on yamanote line
		THEN
			L_ISCIRCLE := true;
			L_RESULT := 30;
		END IF;
	ELSE
		L_RESULT := ABS( GREATEST(IN_STARTSTATION,IN_ENDSTATION) - LEAST(IN_STARTSTATION,IN_ENDSTATION) );
	END IF;

-- YOUR CODE HERE
   RETURN L_RESULT;
   
END;

$function$
LANGUAGE plpgsql;