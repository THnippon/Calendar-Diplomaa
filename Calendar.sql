--
-- PostgreSQL database dump
--

\restrict LHZ3flSjR3JGS4bfgI63aTI0kKTgClurIJ5RJu8HAr8H2mPfT41sbmDVT0FWqhm

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-04-30 19:04:15

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
-- TOC entry 219 (class 1259 OID 16385)
-- Name: attendance_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance_statuses (
    id integer NOT NULL,
    name text DEFAULT 'Не ответил'::text NOT NULL
);


ALTER TABLE public.attendance_statuses OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16393)
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
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 220
-- Name: attendance_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendance_statuses_id_seq OWNED BY public.attendance_statuses.id;


--
-- TOC entry 221 (class 1259 OID 16394)
-- Name: event_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_participants (
    event_id integer NOT NULL,
    user_id integer NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.event_participants OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16400)
-- Name: event_scopes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_scopes (
    code text NOT NULL,
    name text NOT NULL,
    CONSTRAINT event_scopes_code_check CHECK ((code = ANY (ARRAY['GROUP'::text, 'INVITE_ONLY'::text])))
);


ALTER TABLE public.event_scopes OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16635)
-- Name: event_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_tags (
    event_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.event_tags OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16408)
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
    deleted_at timestamp with time zone,
    CONSTRAINT chk_code_group CHECK ((((scope_code = 'INVITE_ONLY'::text) AND (group_id IS NULL)) OR ((scope_code = 'GROUP'::text) AND (group_id IS NOT NULL))))
);


ALTER TABLE public.events OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16422)
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
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 224
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- TOC entry 225 (class 1259 OID 16423)
-- Name: group_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_members (
    group_id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.group_members OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16429)
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
-- TOC entry 227 (class 1259 OID 16440)
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
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 227
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- TOC entry 240 (class 1259 OID 16653)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    event_id integer NOT NULL,
    user_id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16652)
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO postgres;

--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 239
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- TOC entry 233 (class 1259 OID 16539)
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh_tokens (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    token_hash text NOT NULL,
    family_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    revoked_at timestamp with time zone,
    revoke_reason text,
    replaced_by_token_id bigint,
    CONSTRAINT chk_refresh_tokens_expires_after_created CHECK ((expires_at > created_at)),
    CONSTRAINT chk_refresh_tokens_not_self_replaced CHECK (((replaced_by_token_id IS NULL) OR (replaced_by_token_id <> id)))
);


ALTER TABLE public.refresh_tokens OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16538)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refresh_tokens_id_seq OWNER TO postgres;

--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 232
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refresh_tokens_id_seq OWNED BY public.refresh_tokens.id;


--
-- TOC entry 228 (class 1259 OID 16441)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16448)
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
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 229
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 237 (class 1259 OID 16621)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name text NOT NULL,
    color character varying(7) DEFAULT '#607D8B'::character varying NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16620)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO postgres;

--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 236
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 235 (class 1259 OID 16574)
-- Name: user_fcm_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_fcm_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_fcm_tokens OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16573)
-- Name: user_fcm_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_fcm_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_fcm_tokens_id_seq OWNER TO postgres;

--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 234
-- Name: user_fcm_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_fcm_tokens_id_seq OWNED BY public.user_fcm_tokens.id;


--
-- TOC entry 230 (class 1259 OID 16449)
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
-- TOC entry 231 (class 1259 OID 16460)
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
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 231
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4865 (class 2604 OID 16461)
-- Name: attendance_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_statuses ALTER COLUMN id SET DEFAULT nextval('public.attendance_statuses_id_seq'::regclass);


--
-- TOC entry 4867 (class 2604 OID 16462)
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- TOC entry 4869 (class 2604 OID 16463)
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- TOC entry 4881 (class 2604 OID 16656)
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- TOC entry 4874 (class 2604 OID 16542)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 4871 (class 2604 OID 16464)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4879 (class 2604 OID 16624)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 4876 (class 2604 OID 16577)
-- Name: user_fcm_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_fcm_tokens ALTER COLUMN id SET DEFAULT nextval('public.user_fcm_tokens_id_seq'::regclass);


--
-- TOC entry 4872 (class 2604 OID 16465)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5095 (class 0 OID 16385)
-- Dependencies: 219
-- Data for Name: attendance_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance_statuses (id, name) FROM stdin;
1	Не ответил
2	Иду
3	Не иду
\.


--
-- TOC entry 5097 (class 0 OID 16394)
-- Dependencies: 221
-- Data for Name: event_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_participants (event_id, user_id, status_id) FROM stdin;
30	1	2
31	1	2
\.


--
-- TOC entry 5098 (class 0 OID 16400)
-- Dependencies: 222
-- Data for Name: event_scopes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_scopes (code, name) FROM stdin;
GROUP	Событие привязанно к группе\t
INVITE_ONLY	Событие по приглашению
\.


--
-- TOC entry 5114 (class 0 OID 16635)
-- Dependencies: 238
-- Data for Name: event_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_tags (event_id, tag_id) FROM stdin;
\.


--
-- TOC entry 5099 (class 0 OID 16408)
-- Dependencies: 223
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, title, description, start_at, end_at, address, created_by, scope_code, group_id, created_at, deleted_at) FROM stdin;
30	[TEST] Через 4 дня: защита макета	Проверка будущей даты	2026-03-25 15:00:00+05	2026-03-25 16:00:00+05	Zoom	1	INVITE_ONLY	\N	2026-03-21 18:46:14.27134+05	\N
31	[TEST] Через 5 дней: личное дело	Последний тестовый день	2026-03-26 19:00:00+05	2026-03-26 20:00:00+05	Город	1	INVITE_ONLY	\N	2026-03-21 18:46:14.27134+05	\N
32	Консультация по диплому	Обсуждение структуры ВКР и списка задач на неделю	2026-04-03 10:00:00+05	2026-04-03 11:00:00+05	НГТУ, аудитория 312	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
33	Работа над клиентом Flutter	Верстка экрана календаря и списка событий выбранного дня	2026-04-03 14:00:00+05	2026-04-03 16:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
34	Тестирование API событий	Проверка загрузки событий за диапазон дат	2026-04-07 12:00:00+05	2026-04-07 13:30:00+05	Онлайн	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
35	Подготовка диаграмм для диплома	Проработка UML и архитектуры приложения	2026-04-12 15:00:00+05	2026-04-12 17:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
36	Встреча с научным руководителем	Показ промежуточного результата по календарю	2026-04-18 09:30:00+05	2026-04-18 10:30:00+05	НГТУ, кафедра	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
37	Рефакторинг CalendarBloc	Очистка логики выбранного дня и фильтрации событий	2026-04-18 18:00:00+05	2026-04-18 20:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
38	Заполнение тестовыми событиями	Добавление событий на май для проверки прокрутки календаря	2026-04-25 13:00:00+05	2026-04-25 14:00:00+05	Онлайн	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
39	Подготовка к показу приложения	Проверка клиентской части перед демонстрацией	2026-04-29 16:00:00+05	2026-04-29 18:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
40	Майское планирование задач	Формирование задач на месяц по клиенту и серверу	2026-05-02 11:00:00+05	2026-05-02 12:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
41	Доработка списка событий дня	Добавление карточек событий и пустого состояния	2026-05-05 15:00:00+05	2026-05-05 17:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
42	Тестирование календаря за май	Проверка переходов между месяцами и выбора дат	2026-05-05 18:00:00+05	2026-05-05 19:00:00+05	Онлайн	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
43	Добавление деталей события	Работа над отображением адреса и описания	2026-05-10 10:30:00+05	2026-05-10 12:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
44	Проверка базы данных	Тестовые выборки и валидация связей	2026-05-16 13:00:00+05	2026-05-16 14:30:00+05	PostgreSQL локально	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
45	Подготовка текста пояснительной записки	Описание модуля календаря и логики событий	2026-05-21 17:00:00+05	2026-05-21 19:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
46	Финальная отладка	Проверка сценария выбора дня и отображения списка событий	2026-05-27 14:00:00+05	2026-05-27 16:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
47	Резервный день	Буфер под исправление багов перед сдачей	2026-05-30 12:00:00+05	2026-05-30 15:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05	\N
\.


--
-- TOC entry 5101 (class 0 OID 16423)
-- Dependencies: 225
-- Data for Name: group_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_members (group_id, user_id, role_id) FROM stdin;
\.


--
-- TOC entry 5102 (class 0 OID 16429)
-- Dependencies: 226
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, name, description, created_by, avatar_url, created_at) FROM stdin;
\.


--
-- TOC entry 5116 (class 0 OID 16653)
-- Dependencies: 240
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, event_id, user_id, content, created_at) FROM stdin;
\.


--
-- TOC entry 5109 (class 0 OID 16539)
-- Dependencies: 233
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (id, user_id, token_hash, family_id, created_at, expires_at, revoked_at, revoke_reason, replaced_by_token_id) FROM stdin;
1	2	7f00a0f05c1c497a3cb0970333133d5109281db7f2e686594e05d5602e272805	d607d94c-ff36-4bf1-9911-ab6eedef08a6	2026-04-12 18:09:49.25003+05	2026-05-12 18:09:49.874599+05	2026-04-12 18:10:46.096137+05	ROTATED	2
2	2	56b847f5ca5b88e9f6678a29456f0ca04bb89e4bdd1da76cdd74303e6d477d25	d607d94c-ff36-4bf1-9911-ab6eedef08a6	2026-04-12 18:10:46.082331+05	2026-05-12 18:10:46.095038+05	2026-04-12 18:22:20.80796+05	ROTATED	3
3	2	a7047d459f217073870fca80158c2f9b8fb631cc5c6c747913de7c4754b5263b	d607d94c-ff36-4bf1-9911-ab6eedef08a6	2026-04-12 18:22:20.787523+05	2026-05-12 18:22:20.804414+05	2026-04-12 18:57:13.954868+05	ROTATED	4
4	2	c0b81f90f133885320de51ade50939f0acc9fabcd7a6a942b4424d5ca76c3732	d607d94c-ff36-4bf1-9911-ab6eedef08a6	2026-04-12 18:57:13.930241+05	2026-05-12 18:57:13.949731+05	2026-04-12 18:58:09.556048+05	ROTATED	5
5	2	cf757a065ebbaa0c903200ed7e960e7c19a67e40b49cab12ab28740cdd2604a2	d607d94c-ff36-4bf1-9911-ab6eedef08a6	2026-04-12 18:58:09.518127+05	2026-05-12 18:58:09.543522+05	2026-04-12 18:58:13.858482+05	Logout	\N
6	2	a714e5ddabc9ee1e2891092f7d3874342f4b3732ad2d3c0168754e6a91dde25a	ae8abfdb-25f3-4160-96b2-30757f9b4b0b	2026-04-12 18:59:08.02688+05	2026-05-12 18:59:08.097576+05	\N	\N	\N
\.


--
-- TOC entry 5104 (class 0 OID 16441)
-- Dependencies: 228
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	ADMIN
2	SEMI_ADMIN
3	USER
\.


--
-- TOC entry 5113 (class 0 OID 16621)
-- Dependencies: 237
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, name, color) FROM stdin;
\.


--
-- TOC entry 5111 (class 0 OID 16574)
-- Dependencies: 235
-- Data for Name: user_fcm_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_fcm_tokens (id, user_id, token, created_at, last_seen_at) FROM stdin;
\.


--
-- TOC entry 5106 (class 0 OID 16449)
-- Dependencies: 230
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password_hash, nickname, bio, avatar_url, created_at) FROM stdin;
1	12	12	12	12	12	2026-01-07 20:26:43.889235+05
2	123@gmail.com	$2a$10$mt32fUQJES53RJSXiaPpiuD/ij9uzqIg92SUp8FDcFGln8yPRj7mS	123	\N	\N	2026-04-12 18:09:49.25003+05
\.


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 220
-- Name: attendance_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_statuses_id_seq', 3, true);


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 224
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 47, true);


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 227
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 1, false);


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 239
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 232
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 6, true);


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 229
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 236
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 234
-- Name: user_fcm_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_fcm_tokens_id_seq', 1, false);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 231
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4888 (class 2606 OID 16467)
-- Name: attendance_statuses attendance_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_statuses
    ADD CONSTRAINT attendance_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 16469)
-- Name: event_participants event_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_pkey PRIMARY KEY (event_id, user_id);


--
-- TOC entry 4892 (class 2606 OID 16471)
-- Name: event_scopes event_scopes_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_scopes
    ADD CONSTRAINT event_scopes_name_key UNIQUE (name);


--
-- TOC entry 4894 (class 2606 OID 16473)
-- Name: event_scopes event_scopes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_scopes
    ADD CONSTRAINT event_scopes_pkey PRIMARY KEY (code);


--
-- TOC entry 4927 (class 2606 OID 16641)
-- Name: event_tags event_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT event_tags_pkey PRIMARY KEY (event_id, tag_id);


--
-- TOC entry 4896 (class 2606 OID 16475)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- TOC entry 4899 (class 2606 OID 16477)
-- Name: group_members group_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_pkey PRIMARY KEY (group_id, user_id);


--
-- TOC entry 4901 (class 2606 OID 16479)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4930 (class 2606 OID 16666)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- TOC entry 4915 (class 2606 OID 16555)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4917 (class 2606 OID 16557)
-- Name: refresh_tokens refresh_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_hash_key UNIQUE (token_hash);


--
-- TOC entry 4903 (class 2606 OID 16481)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4905 (class 2606 OID 16483)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4923 (class 2606 OID 16634)
-- Name: tags tags_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);


--
-- TOC entry 4925 (class 2606 OID 16632)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 4919 (class 2606 OID 16588)
-- Name: user_fcm_tokens user_fcm_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_fcm_tokens
    ADD CONSTRAINT user_fcm_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4921 (class 2606 OID 16590)
-- Name: user_fcm_tokens user_fcm_tokens_user_id_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_fcm_tokens
    ADD CONSTRAINT user_fcm_tokens_user_id_token_key UNIQUE (user_id, token);


--
-- TOC entry 4907 (class 2606 OID 16485)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4909 (class 2606 OID 16487)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4897 (class 1259 OID 16572)
-- Name: idx_events_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_events_deleted_at ON public.events USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- TOC entry 4928 (class 1259 OID 16677)
-- Name: idx_messages_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_event_id ON public.messages USING btree (event_id);


--
-- TOC entry 4910 (class 1259 OID 16570)
-- Name: idx_refresh_tokens_expires_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_expires_at ON public.refresh_tokens USING btree (expires_at);


--
-- TOC entry 4911 (class 1259 OID 16569)
-- Name: idx_refresh_tokens_family_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_family_id ON public.refresh_tokens USING btree (family_id);


--
-- TOC entry 4912 (class 1259 OID 16571)
-- Name: idx_refresh_tokens_revoked_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_revoked_at ON public.refresh_tokens USING btree (revoked_at);


--
-- TOC entry 4913 (class 1259 OID 16568)
-- Name: idx_refresh_tokens_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_user_id ON public.refresh_tokens USING btree (user_id);


--
-- TOC entry 4931 (class 2606 OID 16488)
-- Name: event_participants event_participants_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.attendance_statuses(id);


--
-- TOC entry 4932 (class 2606 OID 16493)
-- Name: event_participants event_participants_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4944 (class 2606 OID 16642)
-- Name: event_tags event_tags_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT event_tags_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- TOC entry 4945 (class 2606 OID 16647)
-- Name: event_tags event_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT event_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- TOC entry 4934 (class 2606 OID 16498)
-- Name: events events_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- TOC entry 4940 (class 2606 OID 16503)
-- Name: groups fk_created_by_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_created_by_user FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4933 (class 2606 OID 16508)
-- Name: event_participants fk_event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- TOC entry 4935 (class 2606 OID 16513)
-- Name: events fk_events_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT fk_events_group FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- TOC entry 4936 (class 2606 OID 16518)
-- Name: events fk_events_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT fk_events_scope FOREIGN KEY (scope_code) REFERENCES public.event_scopes(code);


--
-- TOC entry 4937 (class 2606 OID 16523)
-- Name: group_members fk_gm_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT fk_gm_group FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- TOC entry 4938 (class 2606 OID 16528)
-- Name: group_members fk_gm_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT fk_gm_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4939 (class 2606 OID 16533)
-- Name: group_members group_members_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- TOC entry 4946 (class 2606 OID 16667)
-- Name: messages messages_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- TOC entry 4947 (class 2606 OID 16672)
-- Name: messages messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4941 (class 2606 OID 16563)
-- Name: refresh_tokens refresh_tokens_replaced_by_token_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_replaced_by_token_id_fkey FOREIGN KEY (replaced_by_token_id) REFERENCES public.refresh_tokens(id) ON DELETE SET NULL;


--
-- TOC entry 4942 (class 2606 OID 16558)
-- Name: refresh_tokens refresh_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4943 (class 2606 OID 16591)
-- Name: user_fcm_tokens user_fcm_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_fcm_tokens
    ADD CONSTRAINT user_fcm_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-04-30 19:04:15

--
-- PostgreSQL database dump complete
--

\unrestrict LHZ3flSjR3JGS4bfgI63aTI0kKTgClurIJ5RJu8HAr8H2mPfT41sbmDVT0FWqhm

