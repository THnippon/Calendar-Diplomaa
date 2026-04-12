--
-- PostgreSQL database dump
--

\restrict SjuoPQ2vD6YVKHyoCGf3YuFje6BGzXBUxCAIhP2n28mRarLT1iEeXJmdJ6ENAe1

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-03-27 14:25:07

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
-- TOC entry 5070 (class 0 OID 0)
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
-- TOC entry 5071 (class 0 OID 0)
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
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 227
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


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
-- TOC entry 5073 (class 0 OID 0)
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
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 229
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


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
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 231
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4846 (class 2604 OID 16461)
-- Name: attendance_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_statuses ALTER COLUMN id SET DEFAULT nextval('public.attendance_statuses_id_seq'::regclass);


--
-- TOC entry 4848 (class 2604 OID 16462)
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- TOC entry 4850 (class 2604 OID 16463)
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- TOC entry 4855 (class 2604 OID 16542)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('public.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 4852 (class 2604 OID 16464)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4853 (class 2604 OID 16465)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5050 (class 0 OID 16385)
-- Dependencies: 219
-- Data for Name: attendance_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance_statuses (id, name) FROM stdin;
1	Не ответил
2	Иду
3	Не иду
\.


--
-- TOC entry 5052 (class 0 OID 16394)
-- Dependencies: 221
-- Data for Name: event_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_participants (event_id, user_id, status_id) FROM stdin;
30	1	2
31	1	2
\.


--
-- TOC entry 5053 (class 0 OID 16400)
-- Dependencies: 222
-- Data for Name: event_scopes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_scopes (code, name) FROM stdin;
GROUP	Событие привязанно к группе\t
INVITE_ONLY	Событие по приглашению
\.


--
-- TOC entry 5054 (class 0 OID 16408)
-- Dependencies: 223
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, title, description, start_at, end_at, address, created_by, scope_code, group_id, created_at) FROM stdin;
30	[TEST] Через 4 дня: защита макета	Проверка будущей даты	2026-03-25 15:00:00+05	2026-03-25 16:00:00+05	Zoom	1	INVITE_ONLY	\N	2026-03-21 18:46:14.27134+05
31	[TEST] Через 5 дней: личное дело	Последний тестовый день	2026-03-26 19:00:00+05	2026-03-26 20:00:00+05	Город	1	INVITE_ONLY	\N	2026-03-21 18:46:14.27134+05
32	Консультация по диплому	Обсуждение структуры ВКР и списка задач на неделю	2026-04-03 10:00:00+05	2026-04-03 11:00:00+05	НГТУ, аудитория 312	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
33	Работа над клиентом Flutter	Верстка экрана календаря и списка событий выбранного дня	2026-04-03 14:00:00+05	2026-04-03 16:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
34	Тестирование API событий	Проверка загрузки событий за диапазон дат	2026-04-07 12:00:00+05	2026-04-07 13:30:00+05	Онлайн	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
35	Подготовка диаграмм для диплома	Проработка UML и архитектуры приложения	2026-04-12 15:00:00+05	2026-04-12 17:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
36	Встреча с научным руководителем	Показ промежуточного результата по календарю	2026-04-18 09:30:00+05	2026-04-18 10:30:00+05	НГТУ, кафедра	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
37	Рефакторинг CalendarBloc	Очистка логики выбранного дня и фильтрации событий	2026-04-18 18:00:00+05	2026-04-18 20:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
38	Заполнение тестовыми событиями	Добавление событий на май для проверки прокрутки календаря	2026-04-25 13:00:00+05	2026-04-25 14:00:00+05	Онлайн	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
39	Подготовка к показу приложения	Проверка клиентской части перед демонстрацией	2026-04-29 16:00:00+05	2026-04-29 18:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
40	Майское планирование задач	Формирование задач на месяц по клиенту и серверу	2026-05-02 11:00:00+05	2026-05-02 12:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
41	Доработка списка событий дня	Добавление карточек событий и пустого состояния	2026-05-05 15:00:00+05	2026-05-05 17:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
42	Тестирование календаря за май	Проверка переходов между месяцами и выбора дат	2026-05-05 18:00:00+05	2026-05-05 19:00:00+05	Онлайн	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
43	Добавление деталей события	Работа над отображением адреса и описания	2026-05-10 10:30:00+05	2026-05-10 12:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
44	Проверка базы данных	Тестовые выборки и валидация связей	2026-05-16 13:00:00+05	2026-05-16 14:30:00+05	PostgreSQL локально	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
45	Подготовка текста пояснительной записки	Описание модуля календаря и логики событий	2026-05-21 17:00:00+05	2026-05-21 19:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
46	Финальная отладка	Проверка сценария выбора дня и отображения списка событий	2026-05-27 14:00:00+05	2026-05-27 16:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
47	Резервный день	Буфер под исправление багов перед сдачей	2026-05-30 12:00:00+05	2026-05-30 15:00:00+05	Дом	1	INVITE_ONLY	\N	2026-03-22 15:21:46.997527+05
\.


--
-- TOC entry 5056 (class 0 OID 16423)
-- Dependencies: 225
-- Data for Name: group_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_members (group_id, user_id, role_id) FROM stdin;
\.


--
-- TOC entry 5057 (class 0 OID 16429)
-- Dependencies: 226
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, name, description, created_by, avatar_url, created_at) FROM stdin;
\.


--
-- TOC entry 5064 (class 0 OID 16539)
-- Dependencies: 233
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (id, user_id, token_hash, family_id, created_at, expires_at, revoked_at, revoke_reason, replaced_by_token_id) FROM stdin;
\.


--
-- TOC entry 5059 (class 0 OID 16441)
-- Dependencies: 228
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	ADMIN
2	SEMI_ADMIN
3	USER
\.


--
-- TOC entry 5061 (class 0 OID 16449)
-- Dependencies: 230
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password_hash, nickname, bio, avatar_url, created_at) FROM stdin;
1	12	12	12	12	12	2026-01-07 20:26:43.889235+05
\.


--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 220
-- Name: attendance_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_statuses_id_seq', 3, true);


--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 224
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 47, true);


--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 227
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 1, false);


--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 232
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 1, false);


--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 229
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 231
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- TOC entry 4862 (class 2606 OID 16467)
-- Name: attendance_statuses attendance_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_statuses
    ADD CONSTRAINT attendance_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 16469)
-- Name: event_participants event_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_pkey PRIMARY KEY (event_id, user_id);


--
-- TOC entry 4866 (class 2606 OID 16471)
-- Name: event_scopes event_scopes_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_scopes
    ADD CONSTRAINT event_scopes_name_key UNIQUE (name);


--
-- TOC entry 4868 (class 2606 OID 16473)
-- Name: event_scopes event_scopes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_scopes
    ADD CONSTRAINT event_scopes_pkey PRIMARY KEY (code);


--
-- TOC entry 4870 (class 2606 OID 16475)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- TOC entry 4872 (class 2606 OID 16477)
-- Name: group_members group_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_pkey PRIMARY KEY (group_id, user_id);


--
-- TOC entry 4874 (class 2606 OID 16479)
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4888 (class 2606 OID 16555)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 16557)
-- Name: refresh_tokens refresh_tokens_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_hash_key UNIQUE (token_hash);


--
-- TOC entry 4876 (class 2606 OID 16481)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4878 (class 2606 OID 16483)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 16485)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4882 (class 2606 OID 16487)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4883 (class 1259 OID 16570)
-- Name: idx_refresh_tokens_expires_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_expires_at ON public.refresh_tokens USING btree (expires_at);


--
-- TOC entry 4884 (class 1259 OID 16569)
-- Name: idx_refresh_tokens_family_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_family_id ON public.refresh_tokens USING btree (family_id);


--
-- TOC entry 4885 (class 1259 OID 16571)
-- Name: idx_refresh_tokens_revoked_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_revoked_at ON public.refresh_tokens USING btree (revoked_at);


--
-- TOC entry 4886 (class 1259 OID 16568)
-- Name: idx_refresh_tokens_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refresh_tokens_user_id ON public.refresh_tokens USING btree (user_id);


--
-- TOC entry 4891 (class 2606 OID 16488)
-- Name: event_participants event_participants_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.attendance_statuses(id);


--
-- TOC entry 4892 (class 2606 OID 16493)
-- Name: event_participants event_participants_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4894 (class 2606 OID 16498)
-- Name: events events_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- TOC entry 4900 (class 2606 OID 16503)
-- Name: groups fk_created_by_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_created_by_user FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4893 (class 2606 OID 16508)
-- Name: event_participants fk_event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- TOC entry 4895 (class 2606 OID 16513)
-- Name: events fk_events_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT fk_events_group FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- TOC entry 4896 (class 2606 OID 16518)
-- Name: events fk_events_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT fk_events_scope FOREIGN KEY (scope_code) REFERENCES public.event_scopes(code);


--
-- TOC entry 4897 (class 2606 OID 16523)
-- Name: group_members fk_gm_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT fk_gm_group FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- TOC entry 4898 (class 2606 OID 16528)
-- Name: group_members fk_gm_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT fk_gm_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4899 (class 2606 OID 16533)
-- Name: group_members group_members_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- TOC entry 4901 (class 2606 OID 16563)
-- Name: refresh_tokens refresh_tokens_replaced_by_token_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_replaced_by_token_id_fkey FOREIGN KEY (replaced_by_token_id) REFERENCES public.refresh_tokens(id) ON DELETE SET NULL;


--
-- TOC entry 4902 (class 2606 OID 16558)
-- Name: refresh_tokens refresh_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-03-27 14:25:07

--
-- PostgreSQL database dump complete
--

\unrestrict SjuoPQ2vD6YVKHyoCGf3YuFje6BGzXBUxCAIhP2n28mRarLT1iEeXJmdJ6ENAe1

