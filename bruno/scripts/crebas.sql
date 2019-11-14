/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     14.11.2019 15:06:39                          */
/*==============================================================*/


-- drop index CARD_PK;

drop table IF EXISTS CARD CASCADE;

-- drop index JUNCTION_PK;

drop table IF EXISTS JUNCTION CASCADE;

-- drop index OPERATOR_PK;

drop table IF EXISTS OPERATOR CASCADE;

-- drop index OPERATES_FK;

-- drop index ROUTE_PK;

drop table IF EXISTS ROUTE CASCADE;

-- drop index CONNECTS_FK;

-- drop index CONSISTS_OF_FK;

-- drop index STATION_PK;

drop table IF EXISTS STATION CASCADE;

-- drop index COVERS_FK;

-- drop index TICKET_PK;

drop table IF EXISTS TICKET CASCADE;

-- drop index CONSITS_OF_FK;

-- drop index CONSITS_OF_2_FK;

-- drop index TICKETCARD_PK;

drop table IF EXISTS TICKETCARD CASCADE;

-- drop index CHOOSE_FK;

-- drop index GETS_CREDITED_FK;

-- drop index END_STATION_FK;

-- drop index START_STATION_FK;

-- drop index TRIP_PK;

drop table IF EXISTS TRIP CASCADE;

-- drop index ZONE_PK;

drop table IF EXISTS ZONE CASCADE;

/*==============================================================*/
/* Table: CARD                                                  */
/*==============================================================*/
create table CARD (
   T_ID                 INT4                 not null,
   constraint PK_CARD primary key (T_ID)
);

/*==============================================================*/
/* Index: CARD_PK                                               */
/*==============================================================*/
create unique index CARD_PK on CARD (
T_ID
);

/*==============================================================*/
/* Table: JUNCTION                                              */
/*==============================================================*/
create table JUNCTION (
   J_ID                 SERIAL               not null,
   constraint PK_JUNCTION primary key (J_ID)
);

/*==============================================================*/
/* Index: JUNCTION_PK                                           */
/*==============================================================*/
create unique index JUNCTION_PK on JUNCTION (
J_ID
);

/*==============================================================*/
/* Table: OPERATOR                                              */
/*==============================================================*/
create table OPERATOR (
   O_NAME               VARCHAR(128)         not null,
   CREDIT_ACCOUNT       MONEY                null,
   constraint PK_OPERATOR primary key (O_NAME)
);

/*==============================================================*/
/* Index: OPERATOR_PK                                           */
/*==============================================================*/
create unique index OPERATOR_PK on OPERATOR (
O_NAME
);

/*==============================================================*/
/* Table: ROUTE                                                 */
/*==============================================================*/
create table ROUTE (
   R_NAME               VARCHAR(128)         not null,
   O_NAME               VARCHAR(128)         not null,
   R_TOKEN              VARCHAR(16)          null,
   COHESIVE_            BOOL                 null,
   COLOR                VARCHAR(2)           null,
   constraint PK_ROUTE primary key (R_NAME)
);

/*==============================================================*/
/* Index: ROUTE_PK                                              */
/*==============================================================*/
create unique index ROUTE_PK on ROUTE (
R_NAME
);

/*==============================================================*/
/* Index: OPERATES_FK                                           */
/*==============================================================*/
create  index OPERATES_FK on ROUTE (
O_NAME
);

/*==============================================================*/
/* Table: STATION                                               */
/*==============================================================*/
create table STATION (
   R_NAME               VARCHAR(128)         not null,
   NUMBER               INT4                 not null,
   NAME                 VARCHAR(128)         null,
   J_ID                 INT4                 null,
   constraint PK_STATION primary key (R_NAME, NUMBER),
   constraint AK_IDENTIFIER_1_STATION unique (NUMBER)
);

/*==============================================================*/
/* Index: STATION_PK                                            */
/*==============================================================*/
create unique index STATION_PK on STATION (
R_NAME,
NUMBER
);

/*==============================================================*/
/* Index: CONSISTS_OF_FK                                        */
/*==============================================================*/
create  index CONSISTS_OF_FK on STATION (
R_NAME
);

/*==============================================================*/
/* Index: CONNECTS_FK                                           */
/*==============================================================*/
create  index CONNECTS_FK on STATION (
J_ID
);

/*==============================================================*/
/* Table: TICKET                                                */
/*==============================================================*/
create table TICKET (
   T_ID                 INT4                 not null,
   Z_NAME               VARCHAR(8)           not null,
   constraint PK_TICKET primary key (T_ID)
);

/*==============================================================*/
/* Index: TICKET_PK                                             */
/*==============================================================*/
create unique index TICKET_PK on TICKET (
T_ID
);

/*==============================================================*/
/* Index: COVERS_FK                                             */
/*==============================================================*/
create  index COVERS_FK on TICKET (
Z_NAME
);

/*==============================================================*/
/* Table: TICKETCARD                                            */
/*==============================================================*/
create table TICKETCARD (
   T_ID                 SERIAL               not null,
   CARD_T_ID            INT4                 null,
   TICKET_T_ID          INT4                 null,
   CUSTOMER_TYPE        VARCHAR(1)           null,
   CREDIT               INT4                 null,
   constraint PK_TICKETCARD primary key (T_ID)
);

/*==============================================================*/
/* Index: TICKETCARD_PK                                         */
/*==============================================================*/
create unique index TICKETCARD_PK on TICKETCARD (
T_ID
);

/*==============================================================*/
/* Index: CONSITS_OF_2_FK                                       */
/*==============================================================*/
create  index CONSITS_OF_2_FK on TICKETCARD (
TICKET_T_ID
);

/*==============================================================*/
/* Index: CONSITS_OF_FK                                         */
/*==============================================================*/
create  index CONSITS_OF_FK on TICKETCARD (
CARD_T_ID
);

/*==============================================================*/
/* Table: TRIP                                                  */
/*==============================================================*/
create table TRIP (
   ID                   SERIAL               not null,
   STATION_R_NAME       VARCHAR(128)         null,
   NUMBER               INT4                 null,
   T_ID                 INT4                 not null,
   R_NAME               VARCHAR(128)         not null,
   STATION_NUMBER       INT4                 not null,
   O_NAME               VARCHAR(128)         not null,
   START_DATE           DATE                 null,
   END_DATE             DATE                 null,
   TRIP_COST            MONEY                null,
   constraint PK_TRIP primary key (ID)
);

/*==============================================================*/
/* Index: TRIP_PK                                               */
/*==============================================================*/
create unique index TRIP_PK on TRIP (
ID
);

/*==============================================================*/
/* Index: START_STATION_FK                                      */
/*==============================================================*/
create  index START_STATION_FK on TRIP (
R_NAME,
STATION_NUMBER
);

/*==============================================================*/
/* Index: END_STATION_FK                                        */
/*==============================================================*/
create  index END_STATION_FK on TRIP (
STATION_R_NAME,
NUMBER
);

/*==============================================================*/
/* Index: GETS_CREDITED_FK                                      */
/*==============================================================*/
create  index GETS_CREDITED_FK on TRIP (
O_NAME
);

/*==============================================================*/
/* Index: CHOOSE_FK                                             */
/*==============================================================*/
create  index CHOOSE_FK on TRIP (
T_ID
);

/*==============================================================*/
/* Table: ZONE                                                  */
/*==============================================================*/
create table ZONE (
   Z_NAME               VARCHAR(8)           not null,
   MAX_STATIONS         INT4                 null,
   PRICE_A              MONEY                null,
   PRICE_C              MONEY                null,
   constraint PK_ZONE primary key (Z_NAME)
);

/*==============================================================*/
/* Index: ZONE_PK                                               */
/*==============================================================*/
create unique index ZONE_PK on ZONE (
Z_NAME
);

alter table CARD
   add constraint FK_CARD_CONSITS_O_TICKETCA foreign key (T_ID)
      references TICKETCARD (T_ID)
      on delete restrict on update restrict;

alter table ROUTE
   add constraint FK_ROUTE_OPERATES_OPERATOR foreign key (O_NAME)
      references OPERATOR (O_NAME)
      on delete restrict on update restrict;

alter table STATION
   add constraint FK_STATION_CONNECTS_JUNCTION foreign key (J_ID)
      references JUNCTION (J_ID)
      on delete restrict on update restrict;

alter table STATION
   add constraint FK_STATION_CONSISTS__ROUTE foreign key (R_NAME)
      references ROUTE (R_NAME)
      on delete restrict on update restrict;

alter table TICKET
   add constraint FK_TICKET_CONSITS_O_TICKETCA foreign key (T_ID)
      references TICKETCARD (T_ID)
      on delete restrict on update restrict;

alter table TICKET
   add constraint FK_TICKET_COVERS_ZONE foreign key (Z_NAME)
      references ZONE (Z_NAME)
      on delete restrict on update restrict;

alter table TICKETCARD
   add constraint FK_TICKETCA_CONSITS_O_CARD foreign key (CARD_T_ID)
      references CARD (T_ID)
      on delete restrict on update restrict;

alter table TICKETCARD
   add constraint FK_TICKETCA_CONSITS_O_TICKET foreign key (TICKET_T_ID)
      references TICKET (T_ID)
      on delete restrict on update restrict;

alter table TRIP
   add constraint FK_TRIP_CHOOSE_TICKETCA foreign key (T_ID)
      references TICKETCARD (T_ID)
      on delete restrict on update restrict;

alter table TRIP
   add constraint FK_TRIP_END_STATI_STATION foreign key (STATION_R_NAME, NUMBER)
      references STATION (R_NAME, NUMBER)
      on delete restrict on update restrict;

alter table TRIP
   add constraint FK_TRIP_GETS_CRED_OPERATOR foreign key (O_NAME)
      references OPERATOR (O_NAME)
      on delete restrict on update restrict;

alter table TRIP
   add constraint FK_TRIP_START_STA_STATION foreign key (R_NAME, STATION_NUMBER)
      references STATION (R_NAME, NUMBER)
      on delete restrict on update restrict;

