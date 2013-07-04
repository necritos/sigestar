--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: appsistema_categoria; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appsistema_categoria (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.appsistema_categoria OWNER TO sigestar;

--
-- Name: appcomun_categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appcomun_categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appcomun_categoria_id_seq OWNER TO sigestar;

--
-- Name: appcomun_categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appcomun_categoria_id_seq OWNED BY appsistema_categoria.id;


--
-- Name: appcomun_categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appcomun_categoria_id_seq', 4, true);


--
-- Name: appsistema_comentario; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appsistema_comentario (
    id integer NOT NULL,
    emisor_id integer NOT NULL,
    solicitud_id integer NOT NULL,
    texto text NOT NULL,
    fecha timestamp with time zone NOT NULL,
    aprobado boolean NOT NULL
);


ALTER TABLE public.appsistema_comentario OWNER TO sigestar;

--
-- Name: appcomun_comentario_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appcomun_comentario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appcomun_comentario_id_seq OWNER TO sigestar;

--
-- Name: appcomun_comentario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appcomun_comentario_id_seq OWNED BY appsistema_comentario.id;


--
-- Name: appcomun_comentario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appcomun_comentario_id_seq', 21, true);


--
-- Name: appsistema_tipo; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appsistema_tipo (
    id integer NOT NULL,
    nombre character varying(15) NOT NULL
);


ALTER TABLE public.appsistema_tipo OWNER TO sigestar;

--
-- Name: appcomun_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appcomun_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appcomun_tipo_id_seq OWNER TO sigestar;

--
-- Name: appcomun_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appcomun_tipo_id_seq OWNED BY appsistema_tipo.id;


--
-- Name: appcomun_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appcomun_tipo_id_seq', 3, true);


--
-- Name: appcuentas_asistencia; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appcuentas_asistencia (
    id integer NOT NULL,
    user_id integer NOT NULL,
    fecha timestamp with time zone NOT NULL,
    valor boolean NOT NULL,
    turno_ini timestamp with time zone
);


ALTER TABLE public.appcuentas_asistencia OWNER TO sigestar;

--
-- Name: appcuentas_asistencia_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appcuentas_asistencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appcuentas_asistencia_id_seq OWNER TO sigestar;

--
-- Name: appcuentas_asistencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appcuentas_asistencia_id_seq OWNED BY appcuentas_asistencia.id;


--
-- Name: appcuentas_asistencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appcuentas_asistencia_id_seq', 6, true);


--
-- Name: appcuentas_campo; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appcuentas_campo (
    id integer NOT NULL,
    dia_id smallint NOT NULL,
    turno_id integer NOT NULL,
    horario_id integer NOT NULL
);


ALTER TABLE public.appcuentas_campo OWNER TO sigestar;

--
-- Name: appcuentas_campo_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appcuentas_campo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appcuentas_campo_id_seq OWNER TO sigestar;

--
-- Name: appcuentas_campo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appcuentas_campo_id_seq OWNED BY appcuentas_campo.id;


--
-- Name: appcuentas_campo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appcuentas_campo_id_seq', 20, true);


--
-- Name: appcuentas_dia; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appcuentas_dia (
    codigo smallint NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE public.appcuentas_dia OWNER TO sigestar;

--
-- Name: appcuentas_horario; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appcuentas_horario (
    id integer NOT NULL,
    fecha_crea timestamp with time zone NOT NULL
);


ALTER TABLE public.appcuentas_horario OWNER TO sigestar;

--
-- Name: appcuentas_horario_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appcuentas_horario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appcuentas_horario_id_seq OWNER TO sigestar;

--
-- Name: appcuentas_horario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appcuentas_horario_id_seq OWNED BY appcuentas_horario.id;


--
-- Name: appcuentas_horario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appcuentas_horario_id_seq', 17, true);


--
-- Name: appcuentas_perfil; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appcuentas_perfil (
    id integer NOT NULL,
    user_id integer NOT NULL,
    dni character varying(8) NOT NULL,
    direccion text,
    telefono character varying(9),
    empresa character varying(10) NOT NULL,
    horario_id integer,
    dba boolean NOT NULL
);


ALTER TABLE public.appcuentas_perfil OWNER TO sigestar;

--
-- Name: appcuentas_perfil_especialidad; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appcuentas_perfil_especialidad (
    id integer NOT NULL,
    perfil_id integer NOT NULL,
    rubro_id smallint NOT NULL
);


ALTER TABLE public.appcuentas_perfil_especialidad OWNER TO sigestar;

--
-- Name: appcuentas_perfil_especialidad_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appcuentas_perfil_especialidad_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appcuentas_perfil_especialidad_id_seq OWNER TO sigestar;

--
-- Name: appcuentas_perfil_especialidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appcuentas_perfil_especialidad_id_seq OWNED BY appcuentas_perfil_especialidad.id;


--
-- Name: appcuentas_perfil_especialidad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appcuentas_perfil_especialidad_id_seq', 32, true);


--
-- Name: appcuentas_perfil_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appcuentas_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appcuentas_perfil_id_seq OWNER TO sigestar;

--
-- Name: appcuentas_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appcuentas_perfil_id_seq OWNED BY appcuentas_perfil.id;


--
-- Name: appcuentas_perfil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appcuentas_perfil_id_seq', 15, true);


--
-- Name: appcuentas_turno; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appcuentas_turno (
    id integer NOT NULL,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL
);


ALTER TABLE public.appcuentas_turno OWNER TO sigestar;

--
-- Name: appcuentas_turno_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appcuentas_turno_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appcuentas_turno_id_seq OWNER TO sigestar;

--
-- Name: appcuentas_turno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appcuentas_turno_id_seq OWNED BY appcuentas_turno.id;


--
-- Name: appcuentas_turno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appcuentas_turno_id_seq', 4, true);


--
-- Name: appsistema_rubro; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appsistema_rubro (
    codigo smallint NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.appsistema_rubro OWNER TO sigestar;

--
-- Name: appsistema_solicitud; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE appsistema_solicitud (
    id integer NOT NULL,
    creacion timestamp with time zone NOT NULL,
    inicio timestamp with time zone,
    fin timestamp with time zone,
    duracion character varying(100),
    emisor_id integer NOT NULL,
    receptor_id integer NOT NULL,
    descripcion text NOT NULL,
    tipo_id integer NOT NULL,
    categoria_id integer NOT NULL,
    rubro_id smallint,
    estado smallint NOT NULL,
    calificacion character varying(10)
);


ALTER TABLE public.appsistema_solicitud OWNER TO sigestar;

--
-- Name: appsistema_solicitud_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE appsistema_solicitud_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appsistema_solicitud_id_seq OWNER TO sigestar;

--
-- Name: appsistema_solicitud_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE appsistema_solicitud_id_seq OWNED BY appsistema_solicitud.id;


--
-- Name: appsistema_solicitud_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('appsistema_solicitud_id_seq', 15, true);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO sigestar;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO sigestar;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('auth_group_id_seq', 3, true);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO sigestar;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO sigestar;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 10, true);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO sigestar;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO sigestar;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('auth_permission_id_seq', 69, true);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    password character varying(128) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superuser boolean NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO sigestar;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO sigestar;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO sigestar;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 49, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO sigestar;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('auth_user_id_seq', 33, true);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO sigestar;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO sigestar;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO sigestar;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO sigestar;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 83, true);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO sigestar;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO sigestar;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('django_content_type_id_seq', 23, true);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO sigestar;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO sigestar;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: sigestar
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO sigestar;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sigestar
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sigestar
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_asistencia ALTER COLUMN id SET DEFAULT nextval('appcuentas_asistencia_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_campo ALTER COLUMN id SET DEFAULT nextval('appcuentas_campo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_horario ALTER COLUMN id SET DEFAULT nextval('appcuentas_horario_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_perfil ALTER COLUMN id SET DEFAULT nextval('appcuentas_perfil_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_perfil_especialidad ALTER COLUMN id SET DEFAULT nextval('appcuentas_perfil_especialidad_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_turno ALTER COLUMN id SET DEFAULT nextval('appcuentas_turno_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_categoria ALTER COLUMN id SET DEFAULT nextval('appcomun_categoria_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_comentario ALTER COLUMN id SET DEFAULT nextval('appcomun_comentario_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_solicitud ALTER COLUMN id SET DEFAULT nextval('appsistema_solicitud_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_tipo ALTER COLUMN id SET DEFAULT nextval('appcomun_tipo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Data for Name: appcuentas_asistencia; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appcuentas_asistencia (id, user_id, fecha, valor, turno_ini) FROM stdin;
5	24	2012-05-22 01:23:59.281966-05	t	2012-05-22 00:00:01-05
6	28	2012-06-03 23:03:20.208643-05	t	2012-06-04 00:00:01-05
\.


--
-- Data for Name: appcuentas_campo; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appcuentas_campo (id, dia_id, turno_id, horario_id) FROM stdin;
4	6	2	9
8	0	1	11
9	2	1	11
10	1	1	11
13	0	1	14
14	2	1	14
16	0	2	16
17	5	3	17
18	6	3	17
19	3	3	17
20	4	3	17
\.


--
-- Data for Name: appcuentas_dia; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appcuentas_dia (codigo, nombre) FROM stdin;
0	lunes
1	martes
2	miercoles
3	jueves
4	viernes
5	sabado
6	domingo
\.


--
-- Data for Name: appcuentas_horario; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appcuentas_horario (id, fecha_crea) FROM stdin;
9	2012-05-21 00:00:00-05
11	2012-05-22 00:00:00-05
14	2012-05-30 00:00:00-05
16	2012-05-30 00:00:00-05
17	2012-06-04 00:00:00-05
\.


--
-- Data for Name: appcuentas_perfil; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appcuentas_perfil (id, user_id, dni, direccion, telefono, empresa, horario_id, dba) FROM stdin;
6	1	33634534			solrac	\N	f
10	28	99999998		992180737	solrac	17	t
8	24	66776767			solrac	14	f
7	26	33634634			solrac	9	f
13	31	66666666			solrac	16	f
15	33	36363636			solrac	\N	f
9	27	99999999		992180737	solrac	11	f
\.


--
-- Data for Name: appcuentas_perfil_especialidad; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appcuentas_perfil_especialidad (id, perfil_id, rubro_id) FROM stdin;
24	5	2
32	7	3
\.


--
-- Data for Name: appcuentas_turno; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appcuentas_turno (id, hora_ini, hora_fin) FROM stdin;
1	23:00:00	08:00:00
2	07:30:00	17:30:00
3	14:00:00	00:00:00
\.


--
-- Data for Name: appsistema_categoria; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appsistema_categoria (id, nombre) FROM stdin;
2	requerimiento
3	trabajo programado
4	trabajo asignado
1	incidente
\.


--
-- Data for Name: appsistema_comentario; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appsistema_comentario (id, emisor_id, solicitud_id, texto, fecha, aprobado) FROM stdin;
9	1	15	ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss	2012-06-01 02:13:53.171133-05	f
10	1	15	sssssssssss	2012-06-01 03:20:08.671171-05	f
11	1	6	sdsd	2012-06-01 03:20:33.741192-05	f
12	1	15	a	2012-06-01 03:20:38.624551-05	f
13	1	15	asdsdsd	2012-06-01 03:20:42.270138-05	f
14	1	15	aaaa	2012-06-01 03:21:07.707292-05	f
6	1	15	comentario de prueba	2012-06-01 03:28:33.917084-05	t
8	1	15	aver si con esto asdjasd\r\na\r\nsd\r\nasdas\r\ndas	2012-06-01 03:30:47.436788-05	t
7	1	15	askdjaskdjkasdj no asdn  asdoasodjasdsada\r\nsd asdjasdjaksdjlajsdjas asdkjalskjdaklsdj\r\nasjdkajsdjaskd asdjaksdjaskddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd	2012-06-01 03:32:38.983253-05	t
16	1	15	wiiiiiiiiiiiiiiiiii	2012-06-01 03:35:31.874163-05	f
15	1	15	hola	2012-06-01 11:20:10.301371-05	t
17	24	3	aaaaa	2012-06-01 12:08:35.399288-05	f
18	24	3	aaaaa	2012-06-01 12:08:36.727589-05	f
19	24	3	bbbb	2012-06-01 12:09:11.786782-05	f
20	24	3	ahora si funciona	2012-06-01 12:09:31.928531-05	f
21	24	3	vamos a ver que tal esta =)	2012-06-01 12:15:30.68838-05	f
\.


--
-- Data for Name: appsistema_rubro; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appsistema_rubro (codigo, nombre) FROM stdin;
1	Active Directory  y actualizar
2	Herramientas de monitoreo, Nagios, Cacti
3	Thomson , enlaces Huawie
4	Seguridad
5	Instalación o actualización de servidores
\.


--
-- Data for Name: appsistema_solicitud; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appsistema_solicitud (id, creacion, inicio, fin, duracion, emisor_id, receptor_id, descripcion, tipo_id, categoria_id, rubro_id, estado, calificacion) FROM stdin;
1	2012-05-20 19:39:40.748752-05	\N	\N	\N	26	24	blaaa	1	2	1	1	\N
4	2012-05-21 20:03:07.873747-05	\N	\N	\N	26	24	gggggg	3	3	\N	1	\N
9	2012-05-21 20:48:05.862368-05	\N	\N	\N	26	24	jhygjhbjhb j	2	1	3	1	\N
2	2012-05-21 00:05:45.409518-05	\N	\N	\N	24	24	ggggg	1	1	4	1	\N
8	2012-05-21 20:18:37.823079-05	\N	\N	\N	26	24	bbbbbbb	1	2	5	1	\N
15	2012-05-21 21:36:01.705011-05	\N	\N	\N	26	24	primerito	3	1	5	1	\N
6	2012-05-21 20:17:02.012652-05	\N	\N	\N	26	24	pruebita	1	1	4	1	\N
14	2012-05-21 21:17:20.145907-05	\N	\N	\N	26	24	esta sol es con algritmo	3	4	\N	1	\N
3	2012-05-21 19:24:37.037269-05	2012-05-31 03:31:49.575646-05	2012-06-01 12:02:01.23246-05	1 dias | 8 horas | 30 minutos | 11 segundos	26	24	un trabajo que se hara mas tarde peor si se puede posiblmene se haga hoy con cosas como estas uno pretende hacer de todo por la empresa esperoq ue entiedan muchachos. Gracias	2	4	\N	4	\N
7	2012-05-21 20:18:06.116163-05	2012-05-31 03:31:54.286564-05	\N	\N	26	24	bla bla bla	1	2	4	2	\N
5	2012-05-21 20:03:26.545619-05	2012-05-31 03:32:00.759954-05	\N	\N	26	24	una mas	1	3	\N	2	\N
\.


--
-- Data for Name: appsistema_tipo; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY appsistema_tipo (id, nombre) FROM stdin;
1	conectividad
2	base de datos
3	plataforma
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY auth_group (id, name) FROM stdin;
1	administradores
2	empleados
3	super
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	34
2	1	35
3	1	36
4	1	7
5	1	8
6	1	9
7	1	25
8	1	26
9	2	26
10	2	29
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add site	6	add_site
17	Can change site	6	change_site
18	Can delete site	6	delete_site
19	Can add tipo	7	add_tipo
20	Can change tipo	7	change_tipo
21	Can delete tipo	7	delete_tipo
22	Can add categoria	8	add_categoria
23	Can change categoria	8	change_categoria
24	Can delete categoria	8	delete_categoria
25	Can add solicitud	9	add_solicitud
26	Can change solicitud	9	change_solicitud
27	Can delete solicitud	9	delete_solicitud
28	Can add horario	10	add_horario
29	Can change horario	10	change_horario
30	Can delete horario	10	delete_horario
31	Can add dia	11	add_dia
32	Can change dia	11	change_dia
33	Can delete dia	11	delete_dia
34	Can add perfil	12	add_perfil
35	Can change perfil	12	change_perfil
36	Can delete perfil	12	delete_perfil
37	Can add log entry	13	add_logentry
38	Can change log entry	13	change_logentry
39	Can delete log entry	13	delete_logentry
40	Can add comentario	14	add_comentario
41	Can change comentario	14	change_comentario
42	Can delete comentario	14	delete_comentario
43	Can add asistencia	15	add_asistencia
44	Can change asistencia	15	change_asistencia
45	Can delete asistencia	15	delete_asistencia
46	Can add rubro	16	add_rubro
47	Can change rubro	16	change_rubro
48	Can delete rubro	16	delete_rubro
49	Can add rubro	17	add_rubro
50	Can change rubro	17	change_rubro
51	Can delete rubro	17	delete_rubro
52	Can add tipo	18	add_tipo
53	Can change tipo	18	change_tipo
54	Can delete tipo	18	delete_tipo
55	Can add categoria	19	add_categoria
56	Can change categoria	19	change_categoria
57	Can delete categoria	19	delete_categoria
58	Can add solicitud	20	add_solicitud
59	Can change solicitud	20	change_solicitud
60	Can delete solicitud	20	delete_solicitud
61	Can add comentario	21	add_comentario
62	Can change comentario	21	change_comentario
63	Can delete comentario	21	delete_comentario
64	Can add turno	22	add_turno
65	Can change turno	22	change_turno
66	Can delete turno	22	delete_turno
67	Can add campo	23	add_campo
68	Can change campo	23	change_campo
69	Can delete campo	23	delete_campo
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined) FROM stdin;
24	6779406599	Fernado 	Cardenas Alva	fdelgado@solucionesracionales.com	pbkdf2_sha256$10000$FU4kkvYrhlpk$h5mkhnN1jbuwTI7BbCIfitkCsO43RXh9g1pU8hgWebo=	f	t	f	2012-06-01 12:45:37.487947-05	2012-05-20 18:11:59.522836-05
1	sigestar	Roberto	Cuadros Osorio	eyscode0@gmail.com	pbkdf2_sha256$10000$FU4kkvYrhlpk$h5mkhnN1jbuwTI7BbCIfitkCsO43RXh9g1pU8hgWebo=	t	t	t	2012-06-01 12:46:37.059994-05	2012-04-17 23:49:19-05
28	2529726777	eys2 fred	prueba2	eyscode2@gmail.com	pbkdf2_sha256$10000$FU4kkvYrhlpk$h5mkhnN1jbuwTI7BbCIfitkCsO43RXh9g1pU8hgWebo=	f	t	f	2012-06-03 22:48:21.274545-05	2012-05-29 12:40:24.244252-05
31	0540283525	Roberto	Cuadros Osorio		pbkdf2_sha256$10000$DeHRNJm4Hl9v$C8QF4MK++tU7hF5VbxMgzAaJiahNrqGrkeDWWPIeV0Y=	f	t	f	2012-05-30 12:10:53.117618-05	2012-05-30 12:10:53.117618-05
33	5168593438	prueba	prueba	eyscode@hotmail.com	pbkdf2_sha256$10000$0AWmNP00oKHd$c40nbt4ju+Wk1szyzsKfQZp+5LY7eO4rYxX3GOIWFSc=	f	t	f	2012-05-31 11:35:58.672689-05	2012-05-31 11:35:58.672689-05
27	5752086909	eys fred	prueba2	eyscode@gmail.com	pbkdf2_sha256$10000$oOCpqHyNpD0q$bS/AcQtNBuRa146a24nC8xw14lnYTvkZqfIidnsxcc8=	f	t	f	2012-05-29 12:34:20.303963-05	2012-05-29 12:34:20.303963-05
26	3995799685	Dick	Delgado Gordillo	sashegori_13_90@hotmail.com	pbkdf2_sha256$10000$FU4kkvYrhlpk$h5mkhnN1jbuwTI7BbCIfitkCsO43RXh9g1pU8hgWebo=	f	t	f	2012-06-01 12:44:39.524667-05	2012-05-20 19:27:04.139654-05
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
17	1	3
41	24	2
42	26	1
43	27	2
44	28	2
47	31	2
49	33	2
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
1	2012-04-18 00:05:55.790526-05	1	2	1	administradores	1	
2	2012-04-18 00:06:35.739705-05	1	2	2	empleados	1	
3	2012-04-18 00:12:45.454008-05	1	10	4	2012-04-18|2012-09-18	1	
4	2012-04-18 00:12:54.372704-05	1	11	1	Dia object	1	
5	2012-04-18 00:15:16.200333-05	1	11	2	martes	1	
6	2012-04-18 00:19:17.37961-05	1	12	1	55555555	1	
7	2012-04-18 00:20:22.990211-05	1	3	1	sigestar	2	Changed password and groups.
8	2012-04-18 00:20:28.116801-05	1	3	1	sigestar	2	Changed password.
9	2012-04-18 00:20:48.515159-05	1	3	2	empleado	1	
10	2012-04-18 00:20:59.467067-05	1	3	2	empleado	2	Changed password and groups.
11	2012-04-18 00:22:20.303646-05	1	12	2	11111111	1	
12	2012-04-18 00:58:30.210734-05	1	3	2	empleado	2	Changed password, first_name and last_name.
13	2012-04-19 00:41:10.709463-05	1	8	1	insidente	1	
14	2012-04-19 00:41:16.083571-05	1	8	2	requerimiento	1	
15	2012-04-19 00:41:22.812064-05	1	8	3	trabajo programado	1	
16	2012-04-19 00:41:27.970364-05	1	8	4	trabajo asignado	1	
17	2012-04-19 00:41:37.534657-05	1	7	1	conectividad	1	
18	2012-04-19 00:41:42.139245-05	1	7	2	base de datos	1	
19	2012-04-19 00:41:47.066391-05	1	7	3	plataforma	1	
20	2012-04-19 01:27:50.519019-05	1	12	1	55555555	2	Changed empresa.
21	2012-04-19 01:28:01.316077-05	1	12	1	55555555	2	Changed empresa.
22	2012-04-19 01:29:34.876952-05	1	3	1	sigestar	2	Changed password, first_name and last_name.
23	2012-04-20 12:12:37.802128-05	1	3	3	empleado2	1	
24	2012-04-20 12:13:06.62997-05	1	3	3	empleado2	2	Changed password, first_name, last_name, email and groups.
25	2012-04-20 12:13:22.610453-05	1	3	2	empleado	2	Changed password and email.
26	2012-04-20 12:16:46.579427-05	1	3	4	admin	1	
27	2012-04-20 12:17:14.877442-05	1	3	4	admin	2	Changed password, first_name, last_name, is_staff and groups.
28	2012-04-21 02:01:23.88355-05	1	12	3	66666666	1	
29	2012-04-22 20:38:55.294979-05	1	3	4	admin	2	Changed password and is_staff.
30	2012-04-22 20:39:41.87164-05	1	2	3	super	1	
31	2012-04-22 20:40:54.230123-05	1	12	1	55555555	3	
32	2012-04-22 20:52:36.84804-05	1	12	4	43634634	1	
33	2012-04-22 20:52:50.192008-05	1	3	1	sigestar	2	Changed password and groups.
34	2012-05-01 00:46:45.434841-05	1	10	5	2012-04-17|2012-09-18	1	
35	2012-05-01 00:47:37.537233-05	1	11	3	martes	1	
36	2012-05-01 11:55:55.095082-05	1	10	5	2012-04-17|2012-09-18	2	Changed user.
37	2012-05-01 11:57:50.54292-05	1	9	3	plataforma | insidente	2	Changed inicio and estado.
38	2012-05-05 20:24:35.755863-05	1	12	1	empleado	1	
39	2012-05-05 20:24:47.783774-05	1	12	2	empleado2	1	
40	2012-05-08 01:09:47.598454-05	1	12	9	admin	1	
41	2012-05-08 01:10:10.830041-05	1	3	11	admin2	1	
42	2012-05-08 01:10:19.588028-05	1	3	11	admin2	2	Changed password and groups.
43	2012-05-08 01:10:36.069688-05	1	12	10	admin2	1	
44	2012-05-08 11:43:01.227468-05	1	17	1	Active Directory  y actualizar	1	
45	2012-05-08 11:44:04.957713-05	1	17	1	Active Directory  y actualizar	1	
46	2012-05-08 11:44:13.169971-05	1	17	2	Herramientas de monitoreo, Nagios, Cacti	1	
47	2012-05-08 11:44:25.644064-05	1	17	3	Thomson , enlaces Huawie	1	
48	2012-05-08 11:44:37.541847-05	1	17	4	Seguridad	1	
49	2012-05-08 11:44:51.422519-05	1	17	5	Instalación o actualización de servidores	1	
50	2012-05-08 11:45:33.054313-05	1	12	1	admin	1	
51	2012-05-08 11:45:42.75115-05	1	12	2	admin2	1	
52	2012-05-08 11:52:41.944188-05	1	10	6	2012-05-01|2012-05-31	1	
53	2012-05-08 11:53:54.392575-05	1	12	3	empleado	1	
54	2012-05-08 11:54:13.753221-05	1	12	4	empleado2	1	
55	2012-05-08 11:55:23.958916-05	1	3	12	empleado3	1	
56	2012-05-08 11:55:54.361796-05	1	3	12	empleado3	2	Changed password, first_name, last_name and groups.
57	2012-05-08 11:56:45.652224-05	1	12	5	empleado3	1	
58	2012-05-08 13:05:40.741167-05	1	3	2	empleado	2	Changed password.
59	2012-05-08 13:08:27.421953-05	1	3	11	admin2	2	Changed password, first_name and last_name.
60	2012-05-08 13:08:43.423674-05	1	12	2	admin2	2	Changed empresa.
61	2012-05-08 13:08:48.433657-05	1	12	1	admin	2	Changed empresa.
62	2012-05-08 13:09:06.872929-05	1	3	1	sigestar	2	Changed password, first_name and last_name.
63	2012-05-08 13:09:37.888276-05	1	12	6	sigestar	1	
64	2012-05-08 13:11:21.813725-05	1	12	3	empleado	2	Changed especialidad.
65	2012-05-08 13:11:27.387151-05	1	12	4	empleado2	2	No fields changed.
66	2012-05-08 13:11:32.113575-05	1	12	5	empleado3	2	Changed especialidad.
67	2012-05-17 23:44:14.823895-05	1	22	1	23:00:00 - 08:00:00	1	
68	2012-05-17 23:44:33.959315-05	1	22	2	07:30:00 - 17:30:00	1	
69	2012-05-17 23:45:04.387841-05	1	22	3	14:00:00 - 00:00:00	1	
70	2012-05-20 13:20:03.755645-05	1	12	1	sigestar	1	
71	2012-05-20 18:53:10.232316-05	1	12	1	sigestar	1	
72	2012-05-20 18:53:20.766719-05	1	12	2	0165055474	1	
73	2012-05-20 18:53:48.247442-05	1	12	3	6779406599	1	
74	2012-05-20 21:44:40.598483-05	1	12	6	sigestar	1	
75	2012-05-20 21:51:39.279147-05	1	12	7	3995799685	1	
76	2012-05-20 21:51:49.145891-05	1	12	8	6779406599	1	
77	2012-05-20 22:00:08.490406-05	1	11	0	lunes	1	
78	2012-05-20 22:00:13.410731-05	1	11	1	martes	1	
79	2012-05-20 22:00:26.305328-05	1	11	2	miercoles	1	
80	2012-05-20 22:00:30.560519-05	1	11	3	jueves	1	
81	2012-05-20 22:00:39.770846-05	1	11	4	viernes	1	
82	2012-05-20 22:00:43.920727-05	1	11	5	sabado	1	
83	2012-05-20 22:00:49.064347-05	1	11	6	domingo	1	
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	permission	auth	permission
2	group	auth	group
3	user	auth	user
4	content type	contenttypes	contenttype
5	session	sessions	session
6	site	sites	site
7	tipo	appcomun	tipo
8	categoria	appcomun	categoria
9	solicitud	appcomun	solicitud
10	horario	appcuentas	horario
11	dia	appcuentas	dia
12	perfil	appcuentas	perfil
13	log entry	admin	logentry
14	comentario	appcomun	comentario
15	asistencia	appcuentas	asistencia
16	rubro	appcomun	rubro
17	rubro	appsistema	rubro
18	tipo	appsistema	tipo
19	categoria	appsistema	categoria
20	solicitud	appsistema	solicitud
21	comentario	appsistema	comentario
22	turno	appcuentas	turno
23	campo	appcuentas	campo
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
d66c754ada9255d576a07d32fe6d5b5a	MGZjZjdkZjY3MzlkNzlkZDg1Y2NkZDZkMjUxNjQ5ZDA1MTk3NzUwZjqAAn1xAShVDV9hdXRoX3Vz\nZXJfaWRLAlUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRz\nLk1vZGVsQmFja2VuZHECdS4=\n	2012-05-02 00:39:48.26699-05
61f846d3d1fbec1e09ca7c6701a3a0c2	M2E5NWFlODQ1MmQyOWJhMThlY2NiZjhkZWY4OTE0YTgyMGI0NWY4ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAnUu\n	2012-05-02 00:40:44.354858-05
f4b1a7934213f9352fcb1160a5c402e6	YzkxMDg2MzI2YTI5OTI1N2U3NzA2ZmM2MDhiNjYzNDVhYzhmOWM5ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-23 15:17:40.273985-05
ad8c9b981653c96ab9d656fd99d0b6cc	YzkxMDg2MzI2YTI5OTI1N2U3NzA2ZmM2MDhiNjYzNDVhYzhmOWM5ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-05 02:00:22.730934-05
4109ea2f2e9dc61aacae97f97ddb9bb2	YzkxMDg2MzI2YTI5OTI1N2U3NzA2ZmM2MDhiNjYzNDVhYzhmOWM5ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-02 00:27:39.765249-05
46e5f3e309ed27860f58de0314ce9250	M2E5NWFlODQ1MmQyOWJhMThlY2NiZjhkZWY4OTE0YTgyMGI0NWY4ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAnUu\n	2012-05-04 10:18:40.729355-05
414351b3c70a913154562a119f707be0	YzkxMDg2MzI2YTI5OTI1N2U3NzA2ZmM2MDhiNjYzNDVhYzhmOWM5ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-03 21:59:35.964569-05
83e5d8f7644606431185f88d502a67fc	NGM4YzI0YTZkNmE3ODk5OWRhZDc4MmRmNDQ0OWRhMjdkZmUwNTIwMzqAAn1xAS4=\n	2012-06-04 19:22:00.451754-05
2870259f52565d7102de26e39560273a	N2NlZDZkNTYwZTZmYWJjMjA5M2EyM2Q3NjZiN2E1OWQ3ZWZkZTY2NTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLHHUu\n	2012-06-17 22:48:21.304151-05
6366f55105cb19f422ba0c05489038e2	YWQwZjlkOTc3OTJmMzM3MTgxYThjNDYwODI3MjcyNDk1MTEyMzU3ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2012-05-15 16:50:00.139184-05
689191b91a2d34ee7544ddba143230ac	YWQwZjlkOTc3OTJmMzM3MTgxYThjNDYwODI3MjcyNDk1MTEyMzU3ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2012-05-06 23:21:41.525252-05
e02a0d4be5d9c07d84efd59a60a2b4cd	NGM4YzI0YTZkNmE3ODk5OWRhZDc4MmRmNDQ0OWRhMjdkZmUwNTIwMzqAAn1xAS4=\n	2012-05-30 12:24:06.576083-05
c6cf825b2ce81baa94e659f5a4db6325	YWQwZjlkOTc3OTJmMzM3MTgxYThjNDYwODI3MjcyNDk1MTEyMzU3ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2012-05-09 11:10:07.321374-05
67891adcf2b04fe697ccbc47ce60f91c	YWQwZjlkOTc3OTJmMzM3MTgxYThjNDYwODI3MjcyNDk1MTEyMzU3ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2012-05-09 14:34:40.368812-05
c90af8efb8d90063a04508bd7c98c056	MWFkMmMwYjA2OWM2YjZlMTYwODhmYTZmYjM2NWIwNGMwMTg5MTE3ODqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLA3Uu\n	2012-05-04 13:04:22.888503-05
b4d2dabdded4aba7673d9db77b2572c4	YzkxMDg2MzI2YTI5OTI1N2U3NzA2ZmM2MDhiNjYzNDVhYzhmOWM5ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-06-05 00:53:50.510311-05
a6ebe1a80c8b3cda2c3d9fa13361d384	YzkxMDg2MzI2YTI5OTI1N2U3NzA2ZmM2MDhiNjYzNDVhYzhmOWM5ZTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLAXUu\n	2012-05-18 14:29:12.899036-05
acce433cec4a6f6815124ee3dfcc5004	YzQ1ODQzNjM0YzZhNjQ4Y2JkNjUxM2ZkNjcxZDRmMGI0ZGQ2NjAxNjqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLGHUu\n	2012-06-15 01:17:46.366113-05
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: sigestar
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: appcomun_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appsistema_categoria
    ADD CONSTRAINT appcomun_categoria_pkey PRIMARY KEY (id);


--
-- Name: appcomun_comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appsistema_comentario
    ADD CONSTRAINT appcomun_comentario_pkey PRIMARY KEY (id);


--
-- Name: appcomun_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appsistema_tipo
    ADD CONSTRAINT appcomun_tipo_pkey PRIMARY KEY (id);


--
-- Name: appcuentas_asistencia_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appcuentas_asistencia
    ADD CONSTRAINT appcuentas_asistencia_pkey PRIMARY KEY (id);


--
-- Name: appcuentas_campo_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appcuentas_campo
    ADD CONSTRAINT appcuentas_campo_pkey PRIMARY KEY (id);


--
-- Name: appcuentas_dia_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appcuentas_dia
    ADD CONSTRAINT appcuentas_dia_pkey PRIMARY KEY (codigo);


--
-- Name: appcuentas_horario_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appcuentas_horario
    ADD CONSTRAINT appcuentas_horario_pkey PRIMARY KEY (id);


--
-- Name: appcuentas_perfil_especialidad_perfil_id_rubro_id_key; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appcuentas_perfil_especialidad
    ADD CONSTRAINT appcuentas_perfil_especialidad_perfil_id_rubro_id_key UNIQUE (perfil_id, rubro_id);


--
-- Name: appcuentas_perfil_especialidad_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appcuentas_perfil_especialidad
    ADD CONSTRAINT appcuentas_perfil_especialidad_pkey PRIMARY KEY (id);


--
-- Name: appcuentas_perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appcuentas_perfil
    ADD CONSTRAINT appcuentas_perfil_pkey PRIMARY KEY (id);


--
-- Name: appcuentas_perfil_user_id_key; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appcuentas_perfil
    ADD CONSTRAINT appcuentas_perfil_user_id_key UNIQUE (user_id);


--
-- Name: appcuentas_turno_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appcuentas_turno
    ADD CONSTRAINT appcuentas_turno_pkey PRIMARY KEY (id);


--
-- Name: appsistema_rubro_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appsistema_rubro
    ADD CONSTRAINT appsistema_rubro_pkey PRIMARY KEY (codigo);


--
-- Name: appsistema_solicitud_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY appsistema_solicitud
    ADD CONSTRAINT appsistema_solicitud_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_model_key; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: sigestar; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: appcomun_comentario_emisor_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appcomun_comentario_emisor_id ON appsistema_comentario USING btree (emisor_id);


--
-- Name: appcomun_comentario_solicitud_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appcomun_comentario_solicitud_id ON appsistema_comentario USING btree (solicitud_id);


--
-- Name: appcuentas_asistencia_user_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appcuentas_asistencia_user_id ON appcuentas_asistencia USING btree (user_id);


--
-- Name: appcuentas_campo_dia_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appcuentas_campo_dia_id ON appcuentas_campo USING btree (dia_id);


--
-- Name: appcuentas_campo_horario_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appcuentas_campo_horario_id ON appcuentas_campo USING btree (horario_id);


--
-- Name: appcuentas_campo_turno_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appcuentas_campo_turno_id ON appcuentas_campo USING btree (turno_id);


--
-- Name: appcuentas_perfil_especialidad_perfil_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appcuentas_perfil_especialidad_perfil_id ON appcuentas_perfil_especialidad USING btree (perfil_id);


--
-- Name: appcuentas_perfil_especialidad_rubro_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appcuentas_perfil_especialidad_rubro_id ON appcuentas_perfil_especialidad USING btree (rubro_id);


--
-- Name: appcuentas_perfil_horario_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appcuentas_perfil_horario_id ON appcuentas_perfil USING btree (horario_id);


--
-- Name: appsistema_solicitud_categoria_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appsistema_solicitud_categoria_id ON appsistema_solicitud USING btree (categoria_id);


--
-- Name: appsistema_solicitud_emisor_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appsistema_solicitud_emisor_id ON appsistema_solicitud USING btree (emisor_id);


--
-- Name: appsistema_solicitud_receptor_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appsistema_solicitud_receptor_id ON appsistema_solicitud USING btree (receptor_id);


--
-- Name: appsistema_solicitud_rubro_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appsistema_solicitud_rubro_id ON appsistema_solicitud USING btree (rubro_id);


--
-- Name: appsistema_solicitud_tipo_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX appsistema_solicitud_tipo_id ON appsistema_solicitud USING btree (tipo_id);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: sigestar; Tablespace: 
--

CREATE INDEX django_session_expire_date ON django_session USING btree (expire_date);


--
-- Name: appcomun_comentario_emisor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_comentario
    ADD CONSTRAINT appcomun_comentario_emisor_id_fkey FOREIGN KEY (emisor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appcuentas_asistencia_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_asistencia
    ADD CONSTRAINT appcuentas_asistencia_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appcuentas_campo_horario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_campo
    ADD CONSTRAINT appcuentas_campo_horario_id_fkey FOREIGN KEY (horario_id) REFERENCES appcuentas_horario(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appcuentas_campo_turno_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_campo
    ADD CONSTRAINT appcuentas_campo_turno_id_fkey FOREIGN KEY (turno_id) REFERENCES appcuentas_turno(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appcuentas_perfil_especialidad_rubro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_perfil_especialidad
    ADD CONSTRAINT appcuentas_perfil_especialidad_rubro_id_fkey FOREIGN KEY (rubro_id) REFERENCES appsistema_rubro(codigo) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appcuentas_perfil_horario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_perfil
    ADD CONSTRAINT appcuentas_perfil_horario_id_fkey FOREIGN KEY (horario_id) REFERENCES appcuentas_horario(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appcuentas_perfil_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appcuentas_perfil
    ADD CONSTRAINT appcuentas_perfil_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appsistema_solicitud_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_solicitud
    ADD CONSTRAINT appsistema_solicitud_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES appsistema_categoria(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appsistema_solicitud_emisor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_solicitud
    ADD CONSTRAINT appsistema_solicitud_emisor_id_fkey FOREIGN KEY (emisor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appsistema_solicitud_receptor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_solicitud
    ADD CONSTRAINT appsistema_solicitud_receptor_id_fkey FOREIGN KEY (receptor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appsistema_solicitud_rubro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_solicitud
    ADD CONSTRAINT appsistema_solicitud_rubro_id_fkey FOREIGN KEY (rubro_id) REFERENCES appsistema_rubro(codigo) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appsistema_solicitud_tipo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY appsistema_solicitud
    ADD CONSTRAINT appsistema_solicitud_tipo_id_fkey FOREIGN KEY (tipo_id) REFERENCES appsistema_tipo(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_728de91f; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_728de91f FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_3cea63fe; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_3cea63fe FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_7ceef80f; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_7ceef80f FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_dfbab7d; Type: FK CONSTRAINT; Schema: public; Owner: sigestar
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_dfbab7d FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

