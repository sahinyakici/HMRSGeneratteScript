-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.candidates
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    surname character varying(15) COLLATE pg_catalog."default" NOT NULL,
    national_id character varying(11) COLLATE pg_catalog."default" NOT NULL,
    birth_date date NOT NULL,
    e_mail character varying(20) COLLATE pg_catalog."default" NOT NULL,
    password character varying(15) COLLATE pg_catalog."default" NOT NULL,
    re_password character varying(15) COLLATE pg_catalog."default" NOT NULL,
    mernis_auth integer NOT NULL,
    e_mail_auth integer NOT NULL,
    e_mail_auths_id integer,
    mernis_auths_id integer,
    mernis_auth_id integer,
    CONSTRAINT "PK_Candidates_Id" PRIMARY KEY (id),
    CONSTRAINT "UK_Candidates_EMail" UNIQUE (e_mail),
    CONSTRAINT "UK_Candidates_EMailAuth" UNIQUE (e_mail_auth),
    CONSTRAINT "UK_Candidates_MernisAuth" UNIQUE (mernis_auth),
    CONSTRAINT "UK_Candidates_NationalId" UNIQUE (national_id)
);

CREATE TABLE IF NOT EXISTS public.e_mail_auths
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    is_verified boolean NOT NULL,
    verified_date date NOT NULL,
    candidates_e_mail_auth integer,
    CONSTRAINT "PK_EMailAuths_Id" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.employers
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    company_name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    web_site character varying(20) COLLATE pg_catalog."default" NOT NULL,
    e_mail character varying(20) COLLATE pg_catalog."default" NOT NULL,
    telephone character varying(15) COLLATE pg_catalog."default" NOT NULL,
    password character varying(15) COLLATE pg_catalog."default" NOT NULL,
    re_password character varying(15) COLLATE pg_catalog."default" NOT NULL,
    e_mail_auth integer NOT NULL,
    hmrs_auth integer NOT NULL,
    CONSTRAINT "PK_Employers_Id" PRIMARY KEY (id),
    CONSTRAINT "UK_Employers_ HMRSAuth" UNIQUE (hmrs_auth),
    CONSTRAINT "UK_Employers_CompanyName" UNIQUE (company_name),
    CONSTRAINT "UK_Employers_EMailAuth" UNIQUE (e_mail_auth)
);

CREATE TABLE IF NOT EXISTS public.hmrs_auths
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    verified_date date NOT NULL,
    verified_employee integer NOT NULL,
    is_verified boolean NOT NULL,
    CONSTRAINT "PK_HMRSAuths_Id" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.hmrs_employees
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    surname character varying(15) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_HMRSEmployees_Id" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.mernis_auths
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    auth_date date NOT NULL,
    is_verified boolean NOT NULL,
    candidates_id integer,
    CONSTRAINT "PK_MernisAuths_Id" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.titles
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    title character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Titles_pkey" PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.candidates
    ADD CONSTRAINT "FK_Candidates_EMailAuthId" FOREIGN KEY (e_mail_auth)
    REFERENCES public.e_mail_auths (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS "UK_Candidates_EMailAuth"
    ON public.candidates(e_mail_auth);


ALTER TABLE IF EXISTS public.candidates
    ADD CONSTRAINT "FK_Candidates_MernisAuthId" FOREIGN KEY (mernis_auth)
    REFERENCES public.mernis_auths (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS "UK_Candidates_MernisAuth"
    ON public.candidates(mernis_auth);


ALTER TABLE IF EXISTS public.candidates
    ADD CONSTRAINT fkb84jpcek0t1gn0kolu2qa67w6 FOREIGN KEY (mernis_auth_id)
    REFERENCES public.mernis_auths (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.candidates
    ADD CONSTRAINT fklinfikwhm0yl8ye8jv7em2ybr FOREIGN KEY (e_mail_auths_id)
    REFERENCES public.e_mail_auths (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.candidates
    ADD CONSTRAINT fkoe6vfr9e0ojp43o9lxnbuv9pg FOREIGN KEY (mernis_auths_id)
    REFERENCES public.mernis_auths (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.e_mail_auths
    ADD CONSTRAINT fka4v9o9jk2bm0m7nbwprymv3q3 FOREIGN KEY (candidates_e_mail_auth)
    REFERENCES public.candidates (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.employers
    ADD CONSTRAINT "FK_Employers_EMailAuthId" FOREIGN KEY (e_mail_auth)
    REFERENCES public.e_mail_auths (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS "UK_Employers_EMailAuth"
    ON public.employers(e_mail_auth);


ALTER TABLE IF EXISTS public.employers
    ADD CONSTRAINT "FK_Employers_HMRSAuthId" FOREIGN KEY (hmrs_auth)
    REFERENCES public.hmrs_auths (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS "UK_Employers_ HMRSAuth"
    ON public.employers(hmrs_auth);


ALTER TABLE IF EXISTS public.hmrs_auths
    ADD CONSTRAINT "FK_HMRSAuths_HMRSEmployeeId" FOREIGN KEY (verified_employee)
    REFERENCES public.hmrs_employees (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.mernis_auths
    ADD CONSTRAINT fk7r7fbkr5yrn6mxuof21bobrt1 FOREIGN KEY (candidates_id)
    REFERENCES public.candidates (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;