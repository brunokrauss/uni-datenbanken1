-- select relname, reltuples
-- from pg_class
-- where relkind = 'r'
-- and relname = 'journey';

-- select relname, reltuples
-- from pg_class
-- where relkind = 'r'
-- and relname = 'ticketcard'

--SELECT *
--    FROM ticketcard INNER JOIN journey ON (ticketcard.ticketid = journey.ticketid);

--ANALYZE VERBOSE ticketcard;
--ANALYZE VERBOSE journey;