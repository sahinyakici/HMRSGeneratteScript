-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


DROP TABLE IF EXISTS public."Candidates";

CREATE TABLE IF NOT EXISTS public."Candidates"
(
    "Id" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    "Name" character(15) NOT NULL,
    "Surname" character(15) NOT NULL,
    "NationalId" character(11) NOT NULL,
    "BirthDate" date NOT NULL,
    "EMail" character(20) NOT NULL,
    "Password" character NOT NULL,
    "RePassword" character NOT NULL,
    "MernisAuth" integer NOT NULL,
    "EMailAuth" integer NOT NULL,
    CONSTRAINT "PK_Candidates_Id" PRIMARY KEY ("Id"),
    CONSTRAINT "UK_Candidates_NationalId" UNIQUE ("NationalId"),
    CONSTRAINT "UK_Candidates_EMail" UNIQUE ("EMail"),
    CONSTRAINT "UK_Candidates_MernisAuth" UNIQUE ("MernisAuth"),
    CONSTRAINT "UK_Candidates_EMailAuth" UNIQUE ("EMailAuth")
);

DROP TABLE IF EXISTS public."MernisAuths";

CREATE TABLE IF NOT EXISTS public."MernisAuths"
(
    "Id" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    "AuthDate" date NOT NULL,
    "IsVerified" boolean NOT NULL,
    CONSTRAINT "PK_MernisAuths_Id" PRIMARY KEY ("Id")
);

DROP TABLE IF EXISTS public."EMailAuths";

CREATE TABLE IF NOT EXISTS public."EMailAuths"
(
    "Id" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    "IsVerified" boolean NOT NULL,
    "VerifiedDate" date NOT NULL,
    CONSTRAINT "PK_EMailAuths_Id" PRIMARY KEY ("Id")
);

DROP TABLE IF EXISTS public."Employers";

CREATE TABLE IF NOT EXISTS public."Employers"
(
    "Id" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    "CompanyName" character(15) NOT NULL,
    "WebSite" character(20) NOT NULL,
    "EMail" character(20) NOT NULL,
    "Telephone" character(15) NOT NULL,
    "Password" character(15) NOT NULL,
    "RePassword" character(15) NOT NULL,
    "EMailAuth" integer NOT NULL,
    "HMRSAuth" integer NOT NULL,
    CONSTRAINT "PK_Employers_Id" PRIMARY KEY ("Id"),
    CONSTRAINT "UK_Employers_CompanyName" UNIQUE ("CompanyName"),
    CONSTRAINT "UK_Employers_EMailAuth" UNIQUE ("EMailAuth"),
    CONSTRAINT "UK_Employers_ HMRSAuth" UNIQUE ("HMRSAuth")
);

DROP TABLE IF EXISTS public."HMRSAuths";

CREATE TABLE IF NOT EXISTS public."HMRSAuths"
(
    "Id" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    "VerifiedDate" date NOT NULL,
    "VerifiedEmploye" integer NOT NULL,
    "IsVerified" boolean NOT NULL,
    CONSTRAINT "PK_HMRSAuths_Id" PRIMARY KEY ("Id")
);

DROP TABLE IF EXISTS public."HMRSEmployees";

CREATE TABLE IF NOT EXISTS public."HMRSEmployees"
(
    "Id" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    "Name" character(15) NOT NULL,
    "Surname" character(15) NOT NULL,
    CONSTRAINT "PK_HMRSEmployees_Id" PRIMARY KEY ("Id")
);

DROP TABLE IF EXISTS public."Titles";

CREATE TABLE IF NOT EXISTS public."Titles"
(
    "Id" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    "Title" character(15) NOT NULL,
    CONSTRAINT "PK_Titles_Id" PRIMARY KEY ("Id")
);

ALTER TABLE IF EXISTS public."Candidates"
    ADD CONSTRAINT "FK_Candidates_MernisAuthId" FOREIGN KEY ("MernisAuth")
    REFERENCES public."MernisAuths" ("Id") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Candidates"
    ADD CONSTRAINT "FK_Candidates_EMailAuthId" FOREIGN KEY ("EMailAuth")
    REFERENCES public."EMailAuths" ("Id") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Employers"
    ADD CONSTRAINT "FK_Employers_EMailAuthId" FOREIGN KEY ("EMailAuth")
    REFERENCES public."EMailAuths" ("Id") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Employers"
    ADD CONSTRAINT "FK_Employers_HMRSAuthId" FOREIGN KEY ("HMRSAuth")
    REFERENCES public."HMRSAuths" ("Id") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."HMRSAuths"
    ADD CONSTRAINT "FK_HMRSAuths_HMRSEmployeeId" FOREIGN KEY ("VerifiedEmploye")
    REFERENCES public."HMRSEmployees" ("Id") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;