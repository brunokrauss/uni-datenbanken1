create or replace FUNCTION BOOK_MONEY 
(
  IN_TICKET_ID BIGINT,
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
  
  
END;
$function$
LANGUAGE plpgsql;
