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
   RETURN L_RESULT;
   
END;
$function$
LANGUAGE plpgsql;