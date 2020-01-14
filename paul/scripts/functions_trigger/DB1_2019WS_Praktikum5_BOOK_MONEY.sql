create or replace FUNCTION BOOK_MONEY 
(
  IN_TICKET_ID INT,
  IN_OPERATOR_ID VARCHAR,
  IN_MONEY MONEY 
) 
RETURNS void 
AS $function$

DECLARE
L_CREDIT MONEY;

BEGIN
  RAISE INFO 'BOOK_MONEY: (%) from (TicketId)(%) to (OperatorId)(%)',  IN_MONEY, IN_TICKET_ID,IN_OPERATOR_ID; 
  

  --YOUR CODE HERE
	SELECT ticketcardbalance INTO L_CREDIT FROM ticketcard WHERE ticketid = IN_TICKET_ID;
	IF ( L_CREDIT >= IN_MONEY )
		THEN
		update operator
		set operatorbalance = operatorbalance + IN_MONEY
		where operatorname = IN_OPERATOR_ID;
		
		update ticketcard
		set ticketcardbalance = ticketcardbalance - IN_MONEY
		where ticketid = IN_TICKET_ID;
	END IF;
  
  --YOUR CODE HERE
  
  
END;
$function$
LANGUAGE plpgsql;
