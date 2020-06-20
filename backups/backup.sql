--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: sbloger
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    post_id integer NOT NULL,
    commentary_text character varying(1000) NOT NULL,
    creation_date date NOT NULL,
    username_id integer NOT NULL
);


ALTER TABLE public.comment OWNER TO sbloger;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: sbloger
--

CREATE SEQUENCE public.comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO sbloger;

--
-- Name: migration_versions; Type: TABLE; Schema: public; Owner: sbloger
--

CREATE TABLE public.migration_versions (
    version character varying(14) NOT NULL,
    executed_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.migration_versions OWNER TO sbloger;

--
-- Name: COLUMN migration_versions.executed_at; Type: COMMENT; Schema: public; Owner: sbloger
--

COMMENT ON COLUMN public.migration_versions.executed_at IS '(DC2Type:datetime_immutable)';


--
-- Name: post; Type: TABLE; Schema: public; Owner: sbloger
--

CREATE TABLE public.post (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    adding_date date NOT NULL,
    description character varying(300) NOT NULL,
    full_text text NOT NULL,
    views_count integer NOT NULL
);


ALTER TABLE public.post OWNER TO sbloger;

--
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: sbloger
--

CREATE SEQUENCE public.post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_id_seq OWNER TO sbloger;

--
-- Name: user; Type: TABLE; Schema: public; Owner: sbloger
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    nickname character varying(50) NOT NULL
);


ALTER TABLE public."user" OWNER TO sbloger;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: sbloger
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO sbloger;

--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: sbloger
--

COPY public.comment (id, post_id, commentary_text, creation_date, username_id) FROM stdin;
2	3	test comment	2020-06-19	7
6	8	asdqweqweqweqsdqwe	2020-06-20	7
7	8	qweqweqweqweasdqweqweqweqsdqwe	2020-06-20	7
8	8	qweqweqweqweasdqweqweqweqsdqweasdqdsdqeq	2020-06-20	7
9	8	thx for post	2020-06-20	7
10	8	thx for post 1	2020-06-20	7
11	8	thx for post 2	2020-06-20	7
12	8	test comment	2020-06-20	10
13	8	тестовый комментарий 	2020-06-20	10
\.


--
-- Data for Name: migration_versions; Type: TABLE DATA; Schema: public; Owner: sbloger
--

COPY public.migration_versions (version, executed_at) FROM stdin;
20200512115643	2020-05-12 11:57:39
20200619101359	2020-06-19 10:14:19
20200619104741	2020-06-19 10:47:50
20200619111015	2020-06-19 11:10:25
20200619145715	2020-06-19 14:59:58
\.


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: sbloger
--

COPY public.post (id, name, adding_date, description, full_text, views_count) FROM stdin;
3	test post 01	2020-06-19	description for test post 01	text of test post 01sad kqlw d;las dl,qlw ,;,asl d,q	54
8	TEST POST NAME	2020-06-19	TEST POST DESCRIPTION	TEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTIONTEST POST DESCRIPTION	147
9	Unix system	2020-06-20	about unix system, 1'st paragraph from wiki	Unix (/ˈjuːnɪks/; trademarked as UNIX) is a family of multitasking, multiuser computer operating systems that derive from the original AT&T Unix, development starting in the 1970s at the Bell Labs research center by Ken Thompson, Dennis Ritchie, and others.[3]\r\n\r\nInitially intended for use inside the Bell System, AT&T licensed Unix to outside parties in the late 1970s, leading to a variety of both academic and commercial Unix variants from vendors including University of California, Berkeley (BSD), Microsoft (Xenix), Sun Microsystems (SunOS/Solaris), HP/HPE (HP-UX), and IBM (AIX). In the early 1990s, AT&T sold its rights in Unix to Novell, which then sold its Unix business to the Santa Cruz Operation (SCO) in 1995.[4] The UNIX trademark passed to The Open Group, a neutral industry consortium founded in 1996, which allows the use of the mark for certified operating systems that comply with the Single UNIX Specification (SUS). However, Novell continues to own the Unix copyrights, which the SCO Group, Inc. v. Novell, Inc. court case (2010) confirmed.\r\n\r\nUnix systems are characterized by a modular design that is sometimes called the "Unix philosophy". According to this philosophy, the operating system should provide a set of simple tools, each of which performs a limited, well-defined function.[5] A unified filesystem (the Unix filesystem) and an inter-process communication mechanism known as "pipes" serve as the main means of communication,[3] and a shell scripting and command language (the Unix shell) is used to combine the tools to perform complex workflows.\r\n\r\nUnix distinguishes itself from its predecessors as the first portable operating system: almost the entire operating system is written in the C programming language, which allows Unix to operate on numerous platforms.[6]	7
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: sbloger
--

COPY public."user" (id, email, roles, password, nickname) FROM stdin;
7	user@mail.com	["ROLE_USER"]	$argon2id$v=19$m=65536,t=4,p=1$P/i47k/b4JmYhGQH+TiHIg$DwzBNxD5Hox5FLbsGMU3+FC7klu5uspPOINDRT+940M	User01
8	admin@mail.com	["ROLE_ADMIN"]	$argon2id$v=19$m=65536,t=4,p=1$74zQ7ex6tAW7sfUMPFfYbg$BpEgmNeFqpf6yv6QfJaybFVA6DGuEsePcDvm/sj6BjU	Admin01
9	w@q.ru	["ROLE_USER"]	$argon2id$v=19$m=65536,t=4,p=1$5ytq6rpvaq1KaniZ6jCiCw$95m3cahYU6a+O0bl0UqpmcDMdNWEVCW7477wqpPlu+g	viktor
10	q@q.ew	["ROLE_USER"]	$argon2id$v=19$m=65536,t=4,p=1$42u/r/i0yjROe6TuF5osbw$PqMtXxTJATpzkfV8m+ZIv7oNBhtaDaLQj3KNqGhT3Bc	testuserreg
\.


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sbloger
--

SELECT pg_catalog.setval('public.comment_id_seq', 13, true);


--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sbloger
--

SELECT pg_catalog.setval('public.post_id_seq', 9, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sbloger
--

SELECT pg_catalog.setval('public.user_id_seq', 10, true);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: sbloger
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: migration_versions migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: sbloger
--

ALTER TABLE ONLY public.migration_versions
    ADD CONSTRAINT migration_versions_pkey PRIMARY KEY (version);


--
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: sbloger
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: sbloger
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_9474526c4b89032c; Type: INDEX; Schema: public; Owner: sbloger
--

CREATE INDEX idx_9474526c4b89032c ON public.comment USING btree (post_id);


--
-- Name: idx_9474526ced766068; Type: INDEX; Schema: public; Owner: sbloger
--

CREATE INDEX idx_9474526ced766068 ON public.comment USING btree (username_id);


--
-- Name: uniq_8d93d649e7927c74; Type: INDEX; Schema: public; Owner: sbloger
--

CREATE UNIQUE INDEX uniq_8d93d649e7927c74 ON public."user" USING btree (email);


--
-- Name: comment fk_9474526c4b89032c; Type: FK CONSTRAINT; Schema: public; Owner: sbloger
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk_9474526c4b89032c FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- Name: comment fk_9474526ced766068; Type: FK CONSTRAINT; Schema: public; Owner: sbloger
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk_9474526ced766068 FOREIGN KEY (username_id) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

