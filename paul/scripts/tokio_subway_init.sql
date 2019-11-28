/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     12/11/2019 22:14:40                          */
/*==============================================================*/


/*
drop index PAYMENT_FK;

drop index GETSPAYED_FK;

drop index DESTINATIONSTATION_FK;

drop index STARTSTATION_FK;

drop index JOURNEY_PK;
*/
drop table IF EXISTS JOURNEY CASCADE;
/*
drop index JUNCTION_PK;
*/
drop table IF EXISTS JUNCTION CASCADE;
/*
drop index OPERATE_FK;

drop index LINE_PK;
*/
drop table IF EXISTS LINE CASCADE;
/*
drop index OPERATOR_PK;
*/
drop table IF EXISTS OPERATOR CASCADE;
/*
drop index IS_FK;

drop index USE_FK;

drop index STATION_PK;
*/
drop table IF EXISTS STATION CASCADE;
/*
drop index CHARGESTCARDS_FK;

drop index TICKETCARD_PK;
*/
drop table IF EXISTS TICKETCARD CASCADE;
/*
drop index ZONE_PK;
*/
drop table IF EXISTS ZONE CASCADE;

/*==============================================================*/
/* Table: JOURNEY                                               */
/*==============================================================*/
create table JOURNEY (
   JOURNEYID            SERIAL               not null,
   STATIONID            INT4                 null,
   OPERATORNAME         VARCHAR(30)          not null,
   TICKETID             INT4                 not null,
   STATION_STATIONID    INT4                 not null,
   JOURNEYDATE          DATE                 not null,
   REDUCEDPRICE         BOOL                 not null,
   PRICE                MONEY                not null,
   constraint PK_JOURNEY primary key (JOURNEYID)
);

/*==============================================================*/
/* Index: JOURNEY_PK                                            */
/*==============================================================*/
create unique index JOURNEY_PK on JOURNEY (
JOURNEYID
);

/*==============================================================*/
/* Index: STARTSTATION_FK                                       */
/*==============================================================*/
create  index STARTSTATION_FK on JOURNEY (
STATION_STATIONID
);

/*==============================================================*/
/* Index: DESTINATIONSTATION_FK                                 */
/*==============================================================*/
create  index DESTINATIONSTATION_FK on JOURNEY (
STATIONID
);

/*==============================================================*/
/* Index: GETSPAYED_FK                                          */
/*==============================================================*/
create  index GETSPAYED_FK on JOURNEY (
OPERATORNAME
);

/*==============================================================*/
/* Index: PAYMENT_FK                                            */
/*==============================================================*/
create  index PAYMENT_FK on JOURNEY (
TICKETID
);

/*==============================================================*/
/* Table: JUNCTION                                              */
/*==============================================================*/
create table JUNCTION (
   JUNCTIONID           SERIAL               not null,
   constraint PK_JUNCTION primary key (JUNCTIONID)
);

/*==============================================================*/
/* Index: JUNCTION_PK                                           */
/*==============================================================*/
create unique index JUNCTION_PK on JUNCTION (
JUNCTIONID
);

/*==============================================================*/
/* Table: LINE                                                  */
/*==============================================================*/
create table LINE (
   LINENAME             VARCHAR(15)          not null,
   OPERATORNAME         VARCHAR(30)          not null,
   HEXCOLORCODE         CHAR(7)              not null,
   LINENAMESHORT        CHAR(2)              null,
   constraint PK_LINE primary key (LINENAME)
);

/*==============================================================*/
/* Index: LINE_PK                                               */
/*==============================================================*/
create unique index LINE_PK on LINE (
LINENAME
);

/*==============================================================*/
/* Index: OPERATE_FK                                            */
/*==============================================================*/
create  index OPERATE_FK on LINE (
OPERATORNAME
);

/*==============================================================*/
/* Table: OPERATOR                                              */
/*==============================================================*/
create table OPERATOR (
   OPERATORNAME         VARCHAR(30)          not null,
   OPERATORBALANCE      MONEY                null,
   constraint PK_OPERATOR primary key (OPERATORNAME)
);

/*==============================================================*/
/* Index: OPERATOR_PK                                           */
/*==============================================================*/
create unique index OPERATOR_PK on OPERATOR (
OPERATORNAME
);

/*==============================================================*/
/* Table: STATION                                               */
/*==============================================================*/
create table STATION (
   STATIONNAME          VARCHAR(30)          not null,
   STATIONNUMBER        NUMERIC(2)           not null,
   STATIONID            SERIAL               not null,
   LINENAME             VARCHAR(15)          not null,
   JUNCTIONID           INT4                 null,
   constraint PK_STATION primary key (STATIONID)
);

/*==============================================================*/
/* Index: STATION_PK                                            */
/*==============================================================*/
create unique index STATION_PK on STATION (
STATIONID
);

/*==============================================================*/
/* Index: USE_FK                                                */
/*==============================================================*/
create  index USE_FK on STATION (
LINENAME
);

/*==============================================================*/
/* Index: IS_FK                                                 */
/*==============================================================*/
create  index IS_FK on STATION (
JUNCTIONID
);

/*==============================================================*/
/* Table: TICKETCARD                                            */
/*==============================================================*/
create table TICKETCARD (
   TICKETID             SERIAL               not null,
   ZONEID               INT4                 null,
   TICKETCARDBALANCE    MONEY                not null,
   TYPE                 CHAR(1)              not null,
   constraint PK_TICKETCARD primary key (TICKETID)
);

/*==============================================================*/
/* Index: TICKETCARD_PK                                         */
/*==============================================================*/
create unique index TICKETCARD_PK on TICKETCARD (
TICKETID
);

/*==============================================================*/
/* Index: CHARGESTCARDS_FK                                      */
/*==============================================================*/
create  index CHARGESTCARDS_FK on TICKETCARD (
ZONEID
);

/*==============================================================*/
/* Table: ZONE                                                  */
/*==============================================================*/
create table ZONE (
   ZONEID               SERIAL               not null,				-- type changed from serial
   ZONEPRICE            NUMERIC(4)           not null,
   ZONEPRICEREDUCED     NUMERIC(4)           not null,
   STATIONCOUNT         NUMERIC(2)           not null,
   constraint PK_ZONE primary key (ZONEID)
);

/*==============================================================*/
/* Index: ZONE_PK                                               */
/*==============================================================*/
create unique index ZONE_PK on ZONE (
ZONEID
);

alter table JOURNEY
   add constraint FK_JOURNEY_DESTINATI_STATION foreign key (STATIONID)
      references STATION (STATIONID)
      on delete restrict on update restrict;

alter table JOURNEY
   add constraint FK_JOURNEY_GETSPAYED_OPERATOR foreign key (OPERATORNAME)
      references OPERATOR (OPERATORNAME)
      on delete restrict on update restrict;

alter table JOURNEY
   add constraint FK_JOURNEY_PAYMENT_TICKETCA foreign key (TICKETID)
      references TICKETCARD (TICKETID)
      on delete restrict on update restrict;

alter table JOURNEY
   add constraint FK_JOURNEY_STARTSTAT_STATION foreign key (STATION_STATIONID)
      references STATION (STATIONID)
      on delete restrict on update restrict;

alter table LINE
   add constraint FK_LINE_OPERATE_OPERATOR foreign key (OPERATORNAME)
      references OPERATOR (OPERATORNAME)
      on delete restrict on update restrict;

alter table STATION
   add constraint FK_STATION_IS_JUNCTION foreign key (JUNCTIONID)
      references JUNCTION (JUNCTIONID)
      on delete restrict on update restrict;

alter table STATION
   add constraint FK_STATION_USE_LINE foreign key (LINENAME)
      references LINE (LINENAME)
      on delete restrict on update restrict;


alter table TICKETCARD
   add constraint FK_TICKETCA_CHARGESTC_ZONE foreign key (ZONEID)
      references ZONE (ZONEID)
      on delete restrict on update restrict;

