--
-- PostgreSQL database dump
--

\restrict rSBXP3r7KlPglbAfjhlGSQVoXcq5PObRJ42urhQQF9UFGvhtfvvwcSFGbH6AdZx

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-01-23 23:19:55

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 16594)
-- Name: attendance_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance_statuses (
    id integer NOT NULL,
    name text DEFAULT 'Не ответил'::text NOT NULL
);


ALTER TABLE public.attendance_statuses OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16593)
-- Name: attendance_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendance_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_statuses_id_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 229
-- Name: attendance_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendance_statuses_id_seq OWNED BY public.attendance_statuses.id;


--
-- TOC entry 231 (class 1259 OID 16606)
-- Name: event_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_participants (
    event_id integer NOT NULL,
    user_id integer NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.event_participants OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16530)
-- Name: event_scopes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_scopes (
    code text NOT NULL,
    name text NOT NULL,
    CONSTRAINT event_scopes_code_check CHECK ((code = ANY (ARRAY['GROUP'::text, 'INVITE_ONLY'::text])))
);


ALTER TABLE public.event_scopes OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16561)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer NOT NULL,
    title text NOT NULL,
    description text,
    start_at timestamp with time zone NOT NULL,
    end_at timestamp with time zone NOT NULL,
    address text,
    created_by integer NOT NULL,
    scope_code text NOT NULL,
    group_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_code_group CHECK ((((scope_code = 'INVITE_ONLY'::text) AND (group_id IS NULL)) OR ((scope_code = 'GROUP'::text) AND (group_id IS NOT NULL))))
);


ALTER TABLE public.events OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16560)
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_id_seq OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 227
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- TOC entry 225 (class 1259 OID 16507)
-- Name: group_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_members (
    group_id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.group_members OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16433)
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    created_by integer NOT NULL,
    avatar_url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16432)
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.groups_id_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 223
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 222 (class 1259 OID 16416)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    nickname text NOT NULL,
    bio text,
    avatar_url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16415)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4895 (class 2604 OID 16597)
-- Name: attendance_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_statuses ALTER COLUMN id SET DEFAULT nextval('public.attendance_statuses_id_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 16564)
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 16436)
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 16393)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4889 (class 2604 OID 16419)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5089 (class 0 OID 16594)
-- Dependencies: 230
-- Data for Name: attendance_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance_statuses (id, name) FROM stdin;
1	Не ответил
2	Иду
3	Не иду
\.


--
-- TOC entry 5090 (class 0 OID 16606)
-- Dependencies: 231
-- Data for Name: event_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_participants (event_id, user_id, status_id) FROM stdin;
1	1	2
\.


--
-- TOC entry 5085 (class 0 OID 16530)
-- Dependencies: 226
-- Data for Name: event_scopes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_scopes (code, name) FROM stdin;
GROUP	Событие привязанно к группе\t
INVITE_ONLY	Событие по приглашению
\.


--
-- TOC entry 5087 (class 0 OID 16561)
-- Dependencies: 228
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, title, description, start_at, end_at, address, created_by, scope_code, group_id, created_at) FROM stdin;
1	Встреча по диплому	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-07 21:59:25.381047+05
2	Встреча по диплому	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-08 16:54:39.823799+05
3	???????? ???????	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-08 16:59:46.930158+05
4	Тест кириллицы	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-08 17:02:54.158639+05
5	Встреча по диплому	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-08 17:23:13.762671+05
6	Встреча по диплому	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-15 14:37:16.110766+05
7	Встреча по диплому	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-15 14:53:42.268395+05
8	Встреча по диплому	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-17 14:02:08.683534+05
9	Встреча по диплому	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-17 14:19:35.939577+05
10	Встреча по диплому	\N	2026-01-10 18:00:00+05	2026-01-10 19:00:00+05	\N	1	INVITE_ONLY	\N	2026-01-17 14:27:00.997021+05
\.


--
-- TOC entry 5084 (class 0 OID 16507)
-- Dependencies: 225
-- Data for Name: group_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_members (group_id, user_id, role_id) FROM stdin;
\.


--
-- TOC entry 5083 (class 0 OID 16433)
-- Dependencies: 224
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, name, description, created_by, avatar_url, created_at) FROM stdin;
\.


--
-- TOC entry 5079 (class 0 OID 16390)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	ADMIN
2	SEMI_ADMIN
3	USER
\.


--
-- TOC entry 5081 (class 0 OID 16416)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password_hash, nickname, bio, avatar_url, created_at) FROM stdin;
1	12	12	12	12	12	2026-01-07 20:26:43.889235+05
\.


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 229
-- Name: attendance_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_statuses_id_seq', 3, true);


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 227
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 10, true);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 223
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 1, false);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- TOC entry 4918 (class 2606 OID 16604)
-- Name: attendance_statuses attendance_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_statuses
    ADD CONSTRAINT attendance_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4920 (class 2606 OID 16613)
-- Name: event_participants event_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_pkey PRIMARY KEY (event_id, user_id);


--
-- TOC entry 4912 (class 2606 OID 16541)
-- Name: event_scopes event_scopes_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_scopes
    ADD CONSTRAINT event_scopes_name_key UNIQUE (name);


--
-- TOC entry 4914 (class 2606 OID 16539)
-- Name: event_scopes event_scopes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_scopes
    ADD CONSTRAINT event_scopes_pkey PRIMARY KEY (code);


--
-- TOC entry 4916 (class 2606 OID 16577)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- TOC entry 4910 (class 2606 OID 16514)
-- Name: group_members group_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_pkey PRIMARY KEY (group_id, user_id);


--
-- TOC entry 4908 (class 2606 OID 16446)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4900 (class 2606 OID 16401)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4902 (class 2606 OID 16399)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4904 (class 2606 OID 16431)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4906 (class 2606 OID 16429)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4928 (class 2606 OID 16619)
-- Name: event_participants event_participants_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.attendance_statuses(id);


--
-- TOC entry 4929 (class 2606 OID 16614)
-- Name: event_participants event_participants_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4925 (class 2606 OID 16578)
-- Name: events events_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- TOC entry 4921 (class 2606 OID 16453)
-- Name: groups fk_created_by_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_created_by_user FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4930 (class 2606 OID 16624)
-- Name: event_participants fk_event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- TOC entry 4926 (class 2606 OID 16583)
-- Name: events fk_events_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT fk_events_group FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- TOC entry 4927 (class 2606 OID 16588)
-- Name: events fk_events_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT fk_events_scope FOREIGN KEY (scope_code) REFERENCES public.event_scopes(code);


--
-- TOC entry 4922 (class 2606 OID 16520)
-- Name: group_members fk_gm_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT fk_gm_group FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- TOC entry 4923 (class 2606 OID 16525)
-- Name: group_members fk_gm_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT fk_gm_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4924 (class 2606 OID 16515)
-- Name: group_members group_members_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


-- Completed on 2026-01-23 23:19:55

--
-- PostgreSQL database dump complete
--

\unrestrict rSBXP3r7KlPglbAfjhlGSQVoXcq5PObRJ42urhQQF9UFGvhtfvvwcSFGbH6AdZx

