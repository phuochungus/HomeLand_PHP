php artisan schema:dump --prune

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.3

-- Started on 2023-11-17 22:29:27

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
-- TOC entry 5 (class 2615 OID 18549)
-- Name: public; Type: SCHEMA; Schema: -; Owner: homeland_db_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO homeland_db_user;

--
-- TOC entry 3317 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: homeland_db_user
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 883 (class 1247 OID 23174)
-- Name: admin_profilegender_enum; Type: TYPE; Schema: public; Owner: homeland_db_user
--

CREATE TYPE public.admin_profilegender_enum AS ENUM (
    'male',
    'female'
);


ALTER TYPE public.admin_profilegender_enum OWNER TO homeland_db_user;

--
-- TOC entry 862 (class 1247 OID 23109)
-- Name: apartment_status_enum; Type: TYPE; Schema: public; Owner: homeland_db_user
--

CREATE TYPE public.apartment_status_enum AS ENUM (
    'active',
    'inactive'
);


ALTER TYPE public.apartment_status_enum OWNER TO homeland_db_user;

--
-- TOC entry 868 (class 1247 OID 23123)
-- Name: contract_role_enum; Type: TYPE; Schema: public; Owner: homeland_db_user
--

CREATE TYPE public.contract_role_enum AS ENUM (
    'buy',
    'rent'
);


ALTER TYPE public.contract_role_enum OWNER TO homeland_db_user;

--
-- TOC entry 871 (class 1247 OID 23128)
-- Name: contract_status_enum; Type: TYPE; Schema: public; Owner: homeland_db_user
--

CREATE TYPE public.contract_status_enum AS ENUM (
    'active',
    'inactive'
);


ALTER TYPE public.contract_status_enum OWNER TO homeland_db_user;

--
-- TOC entry 898 (class 1247 OID 23220)
-- Name: employee_profilegender_enum; Type: TYPE; Schema: public; Owner: homeland_db_user
--

CREATE TYPE public.employee_profilegender_enum AS ENUM (
    'male',
    'female'
);


ALTER TYPE public.employee_profilegender_enum OWNER TO homeland_db_user;

--
-- TOC entry 913 (class 1247 OID 23411)
-- Name: equipment_status_enum; Type: TYPE; Schema: public; Owner: homeland_db_user
--

CREATE TYPE public.equipment_status_enum AS ENUM (
    'AVAILABLE',
    'NOT_AVAILABLE',
    'MAINTENANCE'
);


ALTER TYPE public.equipment_status_enum OWNER TO homeland_db_user;

--
-- TOC entry 850 (class 1247 OID 23077)
-- Name: manager_profilegender_enum; Type: TYPE; Schema: public; Owner: homeland_db_user
--

CREATE TYPE public.manager_profilegender_enum AS ENUM (
    'male',
    'female'
);


ALTER TYPE public.manager_profilegender_enum OWNER TO homeland_db_user;

--
-- TOC entry 877 (class 1247 OID 23156)
-- Name: resident_profilegender_enum; Type: TYPE; Schema: public; Owner: homeland_db_user
--

CREATE TYPE public.resident_profilegender_enum AS ENUM (
    'male',
    'female'
);


ALTER TYPE public.resident_profilegender_enum OWNER TO homeland_db_user;

--
-- TOC entry 889 (class 1247 OID 23192)
-- Name: technician_profilegender_enum; Type: TYPE; Schema: public; Owner: homeland_db_user
--

CREATE TYPE public.technician_profilegender_enum AS ENUM (
    'male',
    'female'
);


ALTER TYPE public.technician_profilegender_enum OWNER TO homeland_db_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 23209)
-- Name: account; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.account (
    owner_id character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    "avatarURL" character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    activated_at timestamp without time zone
);


ALTER TABLE public.account OWNER TO homeland_db_user;

--
-- TOC entry 220 (class 1259 OID 23179)
-- Name: admin; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.admin (
    id character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    "accountOwnerId" character varying,
    "profileName" character varying NOT NULL,
    "profileDate_of_birth" timestamp without time zone NOT NULL,
    "profileGender" public.admin_profilegender_enum NOT NULL,
    "profileFront_identify_card_photo_url" character varying NOT NULL,
    "profileBack_identify_card_photo_url" character varying NOT NULL,
    "profilePhone_number" character varying NOT NULL
);


ALTER TABLE public.admin OWNER TO homeland_db_user;

--
-- TOC entry 217 (class 1259 OID 23113)
-- Name: apartment; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.apartment (
    apartment_id character varying NOT NULL,
    name character varying NOT NULL,
    width integer NOT NULL,
    length integer NOT NULL,
    number_of_bedroom integer NOT NULL,
    number_of_bathroom integer NOT NULL,
    rent numeric NOT NULL,
    status public.apartment_status_enum DEFAULT 'inactive'::public.apartment_status_enum NOT NULL,
    description character varying NOT NULL,
    floor_id character varying,
    building_id character varying,
    "imageURLs" text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.apartment OWNER TO homeland_db_user;

--
-- TOC entry 215 (class 1259 OID 23093)
-- Name: building; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.building (
    building_id character varying NOT NULL,
    name character varying NOT NULL,
    max_floor integer DEFAULT 0 NOT NULL,
    address character varying NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.building OWNER TO homeland_db_user;

--
-- TOC entry 218 (class 1259 OID 23133)
-- Name: contract; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.contract (
    contract_id character varying NOT NULL,
    resident_id character varying,
    apartment_id character varying,
    role public.contract_role_enum NOT NULL,
    status public.contract_status_enum NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    expire_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    "contract_with_signature_photo_URL" character varying,
    "previousContractContractId" character varying,
    "nextContractContractId" character varying
);


ALTER TABLE public.contract OWNER TO homeland_db_user;

--
-- TOC entry 223 (class 1259 OID 23225)
-- Name: employee; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.employee (
    id character varying NOT NULL,
    activated_at timestamp without time zone,
    "profilePictureURL" character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    "profileName" character varying NOT NULL,
    "profileDate_of_birth" timestamp without time zone NOT NULL,
    "profileGender" public.employee_profilegender_enum NOT NULL,
    "profileFront_identify_card_photo_url" character varying NOT NULL,
    "profileBack_identify_card_photo_url" character varying NOT NULL,
    "profilePhone_number" character varying NOT NULL
);


ALTER TABLE public.employee OWNER TO homeland_db_user;

--
-- TOC entry 227 (class 1259 OID 23417)
-- Name: equipment; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.equipment (
    id character varying NOT NULL,
    name character varying NOT NULL,
    status public.equipment_status_enum DEFAULT 'NOT_AVAILABLE'::public.equipment_status_enum NOT NULL,
    "imageURLs" text NOT NULL,
    description character varying,
    apartment_id character varying,
    floor_id character varying,
    building_id character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.equipment OWNER TO homeland_db_user;

--
-- TOC entry 216 (class 1259 OID 23101)
-- Name: floor; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.floor (
    floor_id character varying NOT NULL,
    name character varying NOT NULL,
    building_id character varying
);


ALTER TABLE public.floor OWNER TO homeland_db_user;

--
-- TOC entry 214 (class 1259 OID 23081)
-- Name: manager; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.manager (
    id character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    "accountOwnerId" character varying,
    "profileName" character varying NOT NULL,
    "profileDate_of_birth" timestamp without time zone NOT NULL,
    "profileGender" public.manager_profilegender_enum NOT NULL,
    "profileFront_identify_card_photo_url" character varying NOT NULL,
    "profileBack_identify_card_photo_url" character varying NOT NULL,
    "profilePhone_number" character varying NOT NULL,
    "buildingBuildingId" character varying
);


ALTER TABLE public.manager OWNER TO homeland_db_user;

--
-- TOC entry 219 (class 1259 OID 23161)
-- Name: resident; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.resident (
    id character varying NOT NULL,
    account_id character varying,
    payment_info character varying,
    stay_at_apartment_id character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    "accountOwnerId" character varying,
    "profileName" character varying NOT NULL,
    "profileDate_of_birth" timestamp without time zone NOT NULL,
    "profileGender" public.resident_profilegender_enum NOT NULL,
    "profileFront_identify_card_photo_url" character varying NOT NULL,
    "profileBack_identify_card_photo_url" character varying NOT NULL,
    "profilePhone_number" character varying NOT NULL
);


ALTER TABLE public.resident OWNER TO homeland_db_user;

--
-- TOC entry 225 (class 1259 OID 23242)
-- Name: service; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.service (
    service_id character varying NOT NULL,
    name character varying NOT NULL,
    description character varying,
    "imageURLs" text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.service OWNER TO homeland_db_user;

--
-- TOC entry 224 (class 1259 OID 23235)
-- Name: service_package; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.service_package (
    id character varying NOT NULL,
    service_id character varying NOT NULL,
    expired_date integer NOT NULL,
    per_unit_price integer NOT NULL,
    "serviceServiceId" character varying
);


ALTER TABLE public.service_package OWNER TO homeland_db_user;

--
-- TOC entry 221 (class 1259 OID 23197)
-- Name: technician; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.technician (
    id character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    "accountOwnerId" character varying,
    "profileName" character varying NOT NULL,
    "profileDate_of_birth" timestamp without time zone NOT NULL,
    "profileGender" public.technician_profilegender_enum NOT NULL,
    "profileFront_identify_card_photo_url" character varying NOT NULL,
    "profileBack_identify_card_photo_url" character varying NOT NULL,
    "profilePhone_number" character varying NOT NULL
);


ALTER TABLE public.technician OWNER TO homeland_db_user;

--
-- TOC entry 226 (class 1259 OID 23366)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: homeland_db_user
--

CREATE TABLE public.vehicle (
    license_plate character varying NOT NULL,
    front_registration_photo_url character varying NOT NULL,
    back_registration_photo_url character varying NOT NULL,
    license_plate_photo_url character varying NOT NULL,
    resident_id character varying NOT NULL,
    status character varying DEFAULT 'PENDING'::character varying NOT NULL,
    id character varying NOT NULL
);


ALTER TABLE public.vehicle OWNER TO homeland_db_user;

--
-- TOC entry 3306 (class 0 OID 23209)
-- Dependencies: 222
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.account (owner_id, email, password, "avatarURL", created_at, deleted_at, activated_at) FROM stdin;
ADM1699942813407	admin@gmail.com	$2b$10$SwwjNvNo/p6qLwtee6WT..qo/pGNuGC/oIH64EkM0c1xu36HiZ15e	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/admin/ADM1699942813407/avatar.svg	2023-11-14 06:20:14.514957	\N	\N
MNG1699942814892	manager@gmail.com	$2b$10$7/ymVewbhe58F4qbY5poB.hgFQXlovpV8RTnACQMptRrRMyrwsciK	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/admin/MNG1699942814892/avatar.svg	2023-11-14 06:20:15.691068	\N	\N
TEC1699942815695	technician@gmail.com	$2b$10$0pEpako34nujK1/AZbdgX.Lmbekqp5YA45hhu.QWzcJ1/ULJI.96K	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/admin/TEC1699942815695/avatar.svg	2023-11-14 06:20:16.574072	\N	\N
RESIDENT	resident@gmail.com	$2b$10$B/FFAuX4c9mhDV3K4HWObuZm.Q4ejwdneVPm8xsqyhcPDgpyPQiYi	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RESIDENT/avatar.svg	2023-11-14 06:20:17.317702	\N	\N
RES1699991922415	daiduong35578@gmail.com	$2b$10$v0Si43RLbL2H7apPiqlXCue53rQrcpP6Ez4t/2kcn6T/qGElkiBBW	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699991922415/avatarURL.svg	2023-11-14 19:58:46.956618	\N	\N
RES1700037775145	daiduong235578@gmail.com	$2b$10$eM9x/Ds3N0WAmeCKQ11lC.BUC24Zc/DFwiBkSM4mI85HeWl1GVN3K	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700037775145/avatarURL.svg	2023-11-15 08:42:57.704366	\N	\N
MNG1700062196082	teamwebuit@gmail.com	$2b$10$Y.biATc6RoJGhvrwet.d/e5dl0fPV0VYLX614KObh2yKeUyJHJ8pW	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/manager/MNG1700062196082/avatarURL.svg	2023-11-15 15:29:58.187029	\N	\N
RES1700065672185	daiduong578fds@gmail.com	$2b$10$RSco.tl1OI2EKgNkLDZapOAUOdlryexmwZkuwV8yplSWchQzKR8YC	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700065672185/avatarURL.png	2023-11-15 16:27:54.48922	\N	\N
MNG1700099286773	21522327@gm.uit.edu.vn	$2b$10$ecZujM.fxF7eQGLgg1Ak3.ig/t/rP2MkKbCUKjeYrtS1.uOpmctaS	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/manager/MNG1700099286773/avatarURL.svg	2023-11-16 01:48:10.584495	\N	\N
\.


--
-- TOC entry 3304 (class 0 OID 23179)
-- Dependencies: 220
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.admin (id, created_at, deleted_at, "accountOwnerId", "profileName", "profileDate_of_birth", "profileGender", "profileFront_identify_card_photo_url", "profileBack_identify_card_photo_url", "profilePhone_number") FROM stdin;
ADM1699942813407	2023-11-14 06:20:14.514957	\N	ADM1699942813407	DEMO ADMIN	1999-01-01 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/admin/ADM1699942813407/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/admin/ADM1699942813407/backIdentifyPhoto.jpg	0755555555
\.


--
-- TOC entry 3301 (class 0 OID 23113)
-- Dependencies: 217
-- Data for Name: apartment; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.apartment (apartment_id, name, width, length, number_of_bedroom, number_of_bathroom, rent, status, description, floor_id, building_id, "imageURLs", created_at, deleted_at) FROM stdin;
APM1699942817408	St. Crytal	15	20	1	2	9000000	inactive	Celebrer convoco creta victoria defungo volva inventore. Animus textor curis. Ipsa delectus turba adnuo temptatio ambulo conor.\nComitatus baiulus stabilis coruscus venio decretum repudiandae defungo. Comminor decumbo admitto carcer creptio debitis vehemens deripio. Talus clibanus doloribus sufficio repellat in.\nTristis succurro quibusdam laudantium denuo benevolentia damnatio tabernus fugit. Caelestis derideo super cicuta causa turpis. Tempore causa vulgaris.\nVomer vae spargo ocer usque verumtamen. Cicuta aegrotatio consequuntur tempora compello summisse utroque decet stultus. Absconditus atavus derelinquo arbor.\nUsque tollo sordeo ocer. Arbustum perferendis caste. Decens turba assumenda.	BLD0/FLR0	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942817408/1699942817415.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942817408/1699942817416.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942817408/1699942817417.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942817408/1699942817418.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942817408/1699942817419.png	2023-11-14 06:20:17.92075	\N
APM1699942818003	St. Crytal	15	20	1	2	9000000	inactive	Comburo utrum victoria vita. Fugit sulum nemo valde studio. Auctor angustus uter aestas votum.\nAuctus varietas annus tepidus cunctatio trepide comitatus porro videlicet caterva. Patior deleo amoveo conculco repellendus cotidie suggero thesaurus. Ustilo synagoga utrimque subseco dens ullus.\nBlanditiis auditor comedo valens totidem neque. Casus tubineus accendo. Amissio admiratio ara crudelis teres.\nTabernus assumenda depopulo demens statim vesica. Delinquo tyrannus angulus tutis socius veritas tabula correptius cibo brevis. Tristis cumque peior arbitro blandior crudelis dolor capillus adfero.	BLD0/FLR0	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942818003/1699942818005.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942818003/1699942818007.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942818003/1699942818008.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942818003/1699942818009.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942818003/1699942818010.png	2023-11-14 06:20:18.766196	\N
APM1699942819463	St. Crytal	15	20	1	2	9000000	inactive	Abscido spargo ara celer. Sufficio consequuntur deleo aer aeger alii. Beatus vallum caecus inventore adsuesco desparatus voluptas.\nSono odit tredecim culpo vox timidus clam. Pecco asperiores sulum vulgo templum benigne. Accusantium dolorum odit tero conor vicissitudo.\nCarpo adfectus cultellus tandem tenus patruus tum ulterius clarus. Vigilo voluptates tantillus damnatio ratione demulceo alii reiciendis ver. Brevis caterva ut argentum cattus commemoro custodia celo acerbitas.	BLD0/FLR0	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819463/1699942819562.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819463/1699942819563.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819463/1699942819564.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819463/1699942819565.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819463/1699942819566.png	2023-11-14 06:20:19.853222	\N
APM1699942819857	St. Crytal	15	20	1	2	9000000	inactive	Argumentum suggero admitto quaerat cohors atrocitas articulus inventore pariatur. Abscido temptatio solitudo quidem voro adeo. Architecto curo tamen.\nAdsidue quaerat spes sint curto vestrum asper cetera. Deficio textor uter admoneo. Vigilo aer cilicium adimpleo neque denego terebro sordeo cornu officiis.\nArbitro copia clamo sunt patrocinor quos comburo. Compono celer congregatio catena ambitus allatus acervus vilitas pauper. Talus sophismata expedita vivo temporibus alo autem vere cernuus dignissimos.	BLD0/FLR0	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819857/1699942819858.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819857/1699942819859.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819857/1699942819860.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819857/1699942819861.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942819857/1699942819862.png	2023-11-14 06:20:20.073532	\N
APM1699942820080	St. Crytal	15	20	1	2	9000000	inactive	Auxilium argumentum teres. Copia amplitudo harum triduana suppellex aeger odit teres autus ars. Ducimus celer sollers thermae aspernatur amet arcus turbo quibusdam est.\nSol strues toties. Laudantium statim theca vulariter ocer timor pecco defluo. Laudantium coerceo curriculum clarus derideo omnis substantia comburo.\nArgumentum sustineo corporis. Arceo videlicet temperantia arto cupiditate comparo explicabo aqua. Odit sollers ventosus bellum theologus vitiosus vulariter villa confero.	BLD0/FLR0	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820080/1699942820081.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820080/1699942820082.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820080/1699942820083.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820080/1699942820084.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820080/1699942820085.png	2023-11-14 06:20:20.268798	\N
APM1699942820273	St. Crytal	15	20	1	2	9000000	inactive	Viduo amo suggero vergo conventus tibi. Casus veniam tabernus tero. Attonbitus odio ustulo solium verumtamen explicabo commodi.\nClam uberrime sollicito aspernatur thymum aliqua. Culpo sortitus necessitatibus arma aequitas iusto. Super aptus templum thymum argumentum terga.\nArticulus tonsor ventus sursum celo adiuvo tabgo officiis absens debilito. Validus corona articulus suadeo admiratio solutio utpote tamdiu asper. Patrocinor adinventitias defessus.	BLD0/FLR0	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820273/1699942820274.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820273/1699942820275.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820273/1699942820277.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820273/1699942820278.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820273/1699942820279.png	2023-11-14 06:20:20.480299	\N
APM1699942820483	St. Crytal	15	20	1	2	9000000	inactive	Debeo statim deleniti vos vero. Quidem admitto concedo teneo dolorum. Commemoro terror crebro deputo abundans sustineo tertius.\nAsperiores coepi avarus sustineo non sordeo vulnero attonbitus vehemens. Verbum ulterius aduro cui volutabrum audentia. Patria bellum defluo averto.\nCorrigo architecto cetera commodi quidem custodia. Pecco vacuus paulatim sortitus crapula catena summisse aeneus. Uberrime adipiscor argumentum adipiscor admoneo vilitas strenuus.\nCurto decumbo communis. Iste collum annus atavus amo. Velociter error aspernatur defungo cultura validus tristis cupiditate amita.	BLD0/FLR1	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820483/1699942820484.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820483/1699942820485.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820483/1699942820486.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820483/1699942820487.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820483/1699942820488.png	2023-11-14 06:20:20.677772	\N
APM1699942820681	St. Crytal	15	20	1	2	9000000	inactive	Tamdiu abundans concido delego adulatio talus vilis. Taceo creber allatus suppono decretum. Perferendis doloremque circumvenio tabula harum tamen textor at conscendo sapiente.\nPatior officiis cunctatio virtus deorsum. Voluptas tamen audentia adamo verus acceptus sursum. Aspicio officiis corpus tepidus virga clam soleo.\nAncilla balbus aequitas tremo. Aegre caput acer atavus impedit. Carmen cado ascisco patior terminatio appositus.\nStipes thymbra alioqui dens vilicus vilis bardus. Sollicito veniam volaticus synagoga soluta demonstro abbas. Debitis venia vitae attero viduo.	BLD0/FLR1	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820681/1699942820681.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820681/1699942820682.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820681/1699942820683.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820681/1699942820684.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820681/1699942820686.png	2023-11-14 06:20:20.851905	\N
APM1699942820854	St. Crytal	15	20	1	2	9000000	inactive	Comptus antepono calcar cubitum aggero. Adimpleo ambulo una. Vicinus allatus reiciendis asper deorsum balbus alveus.\nSublime atavus agnosco censura acervus claustrum considero antiquus. Considero ullus a casso crudelis bellicus. Apto commodo absque tribuo consequatur patrocinor debilito.\nCorporis adsidue cursus talio officia. Appello umerus audax auctor. Contra delectus officia defluo vado deleo.\nVeritatis vitium perferendis uberrime vivo denique desidero cohors credo. Pariatur timidus cursus thesis. Volo adstringo absconditus adipisci blanditiis admoneo vesper terreo.	BLD0/FLR1	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820854/1699942820855.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820854/1699942820856.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820854/1699942820857.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820854/1699942820858.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942820854/1699942820859.png	2023-11-14 06:20:21.057124	\N
APM1699942821060	St. Crytal	15	20	1	2	9000000	inactive	Defendo magnam occaecati cura vis in vesica theologus dolor. Fuga compello explicabo. Bardus damno patruus spargo tibi pecto aspernatur acer.\nDapifer sonitus conturbo. Adduco alioqui cunctatio carpo. Volup textilis substantia ulciscor varietas audentia maiores doloribus talus somnus.\nCoaegresco arx capillus vergo decerno vomito sophismata atque. Cumque taedium deprecator tam uberrime aptus. Unde vado trado venia cito blandior conturbo trepide conitor demens.	BLD0/FLR1	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821060/1699942821061.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821060/1699942821062.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821060/1699942821063.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821060/1699942821064.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821060/1699942821065.png	2023-11-14 06:20:21.291198	\N
APM1699942821294	St. Crytal	15	20	1	2	9000000	inactive	Utique sui suffoco delibero vilis vitae. Acerbitas vehemens conspergo volutabrum impedit crepusculum voveo. Torrens tergiversatio trado paens truculenter verecundia.\nBaiulus amplus varietas talio ante vel cohaero. Avarus sumptus optio cupio addo pectus. Clamo tego caveo.\nDerideo suadeo sumptus adduco. Demens voluptas nobis sopor appositus constans cupio. Arbor agnitio textus ut cattus stillicidium certus debeo conqueror.\nTres vinco magnam deprimo thymum magnam voluptates demens rem. Audax auxilium tego corrumpo praesentium verbera magni amet utrimque impedit. Conatus depono charisma aspicio voluptatum suffragium illum illum quisquam est.	BLD0/FLR1	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821294/1699942821295.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821294/1699942821296.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821294/1699942821297.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821294/1699942821298.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821294/1699942821299.png	2023-11-14 06:20:21.489238	\N
APM1699942821493	St. Crytal	15	20	1	2	9000000	inactive	Advenio repudiandae pax alter fugiat atque corpus. Solvo fuga solvo adopto viduo coerceo degenero. Ubi absens crudelis.\nAdmiratio vinculum calcar antiquus brevis adfectus eos uter vigilo. Suffoco casso tempora terga tego enim rerum alo. Reiciendis depono adstringo absum cui conduco adaugeo.\nAut calco carbo stella candidus coaegresco saepe colo. Verbera dedico voco aestus adnuo. Subito trucido baiulus tenax depulso ars absconditus.\nComptus curvo voveo. Adduco vestigium defessus compello. Vomica compello urbanus concido debeo vulgus quia adeptio.	BLD0/FLR1	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821493/1699942821494.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821493/1699942821495.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821493/1699942821496.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821493/1699942821497.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942821493/1699942821498.png	2023-11-14 06:20:22.777405	\N
APM1699942822970	St. Crytal	15	20	1	2	9000000	inactive	Vita suspendo curto vir vehemens derelinquo canis crudelis. Demens uxor vester decipio charisma quas. Sulum pecto cunctatio theologus ambitus accommodo.\nCur contigo calculus capillus consequuntur tergeo uter ea. Assumenda valens tabernus infit. Consectetur thermae decens fuga.\nVenio asperiores suasoria cernuus optio utrimque summisse tepidus. Cunae uredo armarium conservo voluptatibus dignissimos adeptio accusator. Desolo aperio vel supellex.\nQuis adsidue delibero comprehendo alius curiositas arbor adfectus aer. Sui coniecto amet copia. Strenuus aequus torqueo conatus depromo.	BLD0/FLR2	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942822970/1699942822972.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942822970/1699942822973.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942822970/1699942822974.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942822970/1699942822975.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942822970/1699942822976.png	2023-11-14 06:20:23.179959	\N
APM1699942823183	St. Crytal	15	20	1	2	9000000	inactive	Adicio illo comparo adversus eius solutio paens tactus. Labore corona taceo cursim patior conservo solum. Acerbitas tricesimus tergo coepi.\nTalis caveo eaque tenuis. Cruciamentum tener tubineus cognatus copia cursus defendo ultra undique. Ter vinum laborum aiunt animi virgo.\nAmbitus odit spoliatio demum capitulus tergiversatio creta. Aspicio audeo conduco cultura arbustum textor. Temperantia arbor currus carbo bis.\nCarcer auxilium alioqui ut decretum tepesco amicitia summa. Alias avarus molestias. Sapiente conculco explicabo somnus.\nReprehenderit cattus admiratio synagoga delego patruus suffoco ait argumentum. Tripudio crepusculum aestivus explicabo antea voro at. Reiciendis aegrus atque spes anser ubi.	BLD0/FLR2	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823183/1699942823184.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823183/1699942823185.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823183/1699942823186.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823183/1699942823187.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823183/1699942823188.png	2023-11-14 06:20:23.440657	\N
APM1699942823443	St. Crytal	15	20	1	2	9000000	inactive	Distinctio sufficio accedo condico delicate doloribus doloribus. Capitulus adipiscor derideo verbum cattus commodi solutio. Thesis super vorago collum beatae expedita solitudo.\nTantillus aqua defleo truculenter. Adopto spargo altus thermae. Textilis surgo pecto.\nConsidero versus sonitus paens curto. Pecus arma vinum quis. Amplus chirographum astrum sub perspiciatis rerum.\nTermes vulariter arto concedo vesco tener modi volaticus aegre crux. Appono coruscus viriliter et amitto. Stillicidium celebrer molestias verbum ager facilis.	BLD0/FLR2	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823443/1699942823445.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823443/1699942823446.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823443/1699942823447.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823443/1699942823448.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823443/1699942823449.png	2023-11-14 06:20:23.754606	\N
APM1699942823757	St. Crytal	15	20	1	2	9000000	inactive	Conduco studio tenuis molestias succurro. Nisi assentator desino sophismata stips succedo vorax comptus. Summa arguo valetudo vestrum deleniti veniam confido testimonium.\nSpes aequitas timor eligendi culpa antiquus sopor antepono. Ventosus adnuo nam debilito addo volo defungo aeternus. Vae solutio socius fugiat.\nCornu rerum caste velum tametsi arca voluptates. Bardus absum sui sustineo velit canis causa appono. Dolorem cotidie provident clam umerus magnam.\nTandem considero tenuis comes defleo truculenter et acer cernuus. Delego quidem trucido theca. Alias strenuus atavus magni ocer voluptate cogo tonsor umerus civis.\nAmita quia correptius terga excepturi. Vinculum cui patruus. Summisse textus tricesimus volubilis terra aeneus depulso.	BLD0/FLR2	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823757/1699942823758.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823757/1699942823759.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823757/1699942823760.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823757/1699942823761.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823757/1699942823762.png	2023-11-14 06:20:23.959017	\N
APM1699942823962	St. Crytal	15	20	1	2	9000000	inactive	Trucido cervus tenetur suggero solio suadeo utor aperio vicissitudo. Vesper cilicium subvenio ara astrum adsuesco. Conitor canis aeger maiores contigo bos carmen tabella ad.\nUltra degero adsuesco alienus aurum. Laudantium vindico reiciendis votum creo aduro tabgo minus sum charisma. Tam auctor statua bene credo amplitudo contego qui atrocitas confugo.\nTolero curtus tactus textor vetus venustas. Substantia ad videlicet vestrum comminor. Nihil apud canonicus currus aperiam unde ultio textilis vulnero.	BLD0/FLR2	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823962/1699942823964.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823962/1699942823965.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823962/1699942823966.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823962/1699942823967.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942823962/1699942823968.png	2023-11-14 06:20:24.199241	\N
APM1699942824204	St. Crytal	15	20	1	2	9000000	inactive	Asperiores utroque trucido autus corroboro arx earum delego adversus. Arma catena adstringo curso subseco vicissitudo provident demonstro veritas. Tego cometes itaque dapifer terra acsi.\nCreo deleniti audax derelinquo somniculosus. Tergiversatio consequuntur aegrotatio defleo turbo exercitationem. Condico cimentarius desidero synagoga calco arca adstringo sublime tabesco spero.\nEa tergiversatio tepidus doloremque. Comptus sit synagoga abduco cumque sto. Corrupti labore sunt videlicet odit.\nVerus ustulo xiphias concido facere exercitationem solus vos strues. Talio vergo mollitia callide aqua enim. Vereor claudeo thermae suadeo turba aeneus amo caritas ademptio.	BLD0/FLR2	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824204/1699942824205.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824204/1699942824206.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824204/1699942824207.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824204/1699942824209.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824204/1699942824210.png	2023-11-14 06:20:24.443325	\N
APM1699942824447	St. Crytal	15	20	1	2	9000000	inactive	Adsuesco alter concedo cena alienus abbas absque aeternus. Crastinus atrocitas trucido viscus natus aiunt deficio. Trepide terminatio reiciendis.\nVilla dens cicuta sonitus molestias pariatur voluptas adstringo angulus. Deleo aiunt amoveo optio creber triumphus subnecto admiratio accommodo bonus. Theologus tredecim culpa vado celo cinis umbra artificiose patior crinis.\nVolaticus congregatio rerum cariosus audacia error valens cubo crapula. Dens pauper stipes compello. Quibusdam deludo coniuratio uter decimus colo enim bardus.	BLD0/FLR3	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824447/1699942824448.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824447/1699942824449.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824447/1699942824450.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824447/1699942824451.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824447/1699942824453.png	2023-11-14 06:20:24.664275	\N
APM1699942824668	St. Crytal	15	20	1	2	9000000	inactive	Calco utor arx terminatio adfero aedificium. Odit tero tonsor aggredior bos conor aliqua urbanus astrum. Ancilla tricesimus antea varius accendo circumvenio.\nUsus termes reprehenderit concedo aiunt deleo aiunt. Alter utique sol suppono aegrus succurro cado cur tolero. Pax vos deporto contego atavus crux administratio claro.\nAetas curto cunabula solium. Succedo inventore tibi victoria vix vix. Sub cenaculum arcesso virga dens.\nCoruscus eveniet approbo. Quas ceno suspendo vix. Tum quia maiores tero averto derelinquo aliquid.\nCursus sulum vomica dolorum. Demum attonbitus casso damno. Terra sopor adhaero omnis solio depono auditor tracto astrum.	BLD0/FLR3	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824668/1699942824669.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824668/1699942824670.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824668/1699942824671.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824668/1699942824672.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824668/1699942824673.png	2023-11-14 06:20:24.889896	\N
APM1699942824895	St. Crytal	15	20	1	2	9000000	inactive	Decet sophismata peior titulus certe tyrannus. Vito debitis inventore vestrum speculum bene amaritudo contabesco accusantium. Ulciscor tener aqua expedita tempus adhaero.\nCanis celo cimentarius tempus arguo amissio theatrum vulariter cetera. Sublime aliquam cattus cruciamentum basium testimonium amet denuo harum ventosus. Ver ademptio sumptus umquam confero acer eos thorax.\nConcedo tactus supra ultra stips avaritia creptio. Succurro tergeo annus. Verbera reprehenderit viridis.	BLD0/FLR3	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824895/1699942824896.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824895/1699942824897.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824895/1699942824898.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824895/1699942824899.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942824895/1699942824900.png	2023-11-14 06:20:25.08661	\N
APM1699942825091	St. Crytal	15	20	1	2	9000000	inactive	Vis decor tam adulatio. Confido capitulus sopor apto timidus. Abbas ipsam vel comes aegrotatio.\nAmo spero arto. Adulatio minima voluptas. Tremo corrigo custodia culpo ocer tamisium.\nConcido careo admiratio infit considero. Xiphias tristis spero video tener cupiditas damnatio vociferor aggero agnosco. Aduro careo veniam virtus umquam stabilis cubo tabella reprehenderit.	BLD0/FLR3	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825091/1699942825092.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825091/1699942825093.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825091/1699942825094.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825091/1699942825095.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825091/1699942825096.png	2023-11-14 06:20:25.355485	\N
APM1699942825371	St. Crytal	15	20	1	2	9000000	inactive	Tabesco aliqua antea. Tego caritas fugiat. Sustineo adamo chirographum cursus aperte creator.\nTerga cuppedia super nisi auditor pauper. Alius coniuratio cras subnecto xiphias. Accedo tactus veritatis degenero alter thesaurus sumo desolo solvo spoliatio.\nAgnitio voveo artificiose deleniti valeo tenus natus. Curia volutabrum votum. Conventus placeat utor theologus verus solvo cursim arcesso.\nAnnus error angelus thermae vicinus itaque. Deludo conor damnatio curriculum alveus comparo nisi utilis. Cumque tui repellat viscus tempora sordeo reiciendis.	BLD0/FLR3	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825371/1699942825373.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825371/1699942825374.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825371/1699942825375.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825371/1699942825376.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825371/1699942825377.png	2023-11-14 06:20:25.57158	\N
APM1699942825575	St. Crytal	15	20	1	2	9000000	inactive	Solium vinum delectus timor tener terebro adhuc volutabrum tam. Solutio vivo defungo ancilla molestias cohaero urbanus corroboro. Adulatio patruus balbus ter tollo abduco sopor.\nAddo turpis una deporto calculus ocer illum accommodo perferendis crustulum. Spiculum cuius absque tubineus decumbo suffoco canis. Pecus explicabo ter adiuvo canonicus voluptates tergo reiciendis cresco.\nUrbs cedo volo turba vallum consuasor. Contabesco clibanus suggero concido vito occaecati umerus suppono surgo quam. Acidus audax concedo dens correptius ullam basium corroboro timidus ulciscor.\nCreber vicinus subito asper validus sulum. Paens tergum ademptio conicio. Coniuratio benigne solutio thorax.	BLD0/FLR3	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825575/1699942825576.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825575/1699942825577.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825575/1699942825578.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825575/1699942825579.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825575/1699942825580.png	2023-11-14 06:20:25.808245	\N
APM1699942825830	St. Crytal	15	20	1	2	9000000	inactive	Hic corona amicitia vorax. Sequi quibusdam dignissimos urbs spiritus vesper adhaero subnecto nostrum thermae. Deduco coaegresco nobis cohors crux amplexus vulgus crinis tempus.\nVotum patior curtus. Tutis via accusator clamo paulatim umerus adipisci despecto caelestis demergo. Vulgo adiuvo aduro agnitio.\nQuibusdam clam thymum depromo animadverto facilis. Ager acceptus denego arbor quasi. Dicta somniculosus verbera aestas absens avarus tempora tubineus verbum.\nDebitis id apto degenero aggredior velit. Suus aureus conventus suscipio vitium tenax angulus ascit. Sodalitas sum carcer.	BLD0/FLR4	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825830/1699942825833.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825830/1699942825834.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825830/1699942825835.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825830/1699942825836.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942825830/1699942825837.png	2023-11-14 06:20:26.040722	\N
APM1699942826086	St. Crytal	15	20	1	2	9000000	inactive	Dicta urbanus coaegresco eum incidunt qui umbra. Curis thymbra vesica atavus tabella acies. Benigne alveus complectus viscus.\nVallum desolo teres expedita. Auxilium crapula accendo. Demens adipisci credo attero curvo ascisco dedico.\nMagni ullam vinculum tepesco voveo annus adversus capto. Verto vito vilicus terga similique strues maxime adamo. Admiratio subiungo tamdiu sperno uredo defessus carus aestivus animadverto.	BLD0/FLR4	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826086/1699942826089.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826086/1699942826090.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826086/1699942826091.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826086/1699942826092.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826086/1699942826093.png	2023-11-14 06:20:26.262703	\N
APM1699942826268	St. Crytal	15	20	1	2	9000000	inactive	Tyrannus crinis accedo aeternus defaeco. Cunctatio speciosus collum crastinus coma. Solus caste cresco.\nDenuo supplanto consectetur aro tamdiu. Nisi terebro cursus. Constans ultio toties.\nAra vobis corrupti careo repellat. Ut blanditiis ipsam beatus vulnero suscipit teneo. Animus ut adiuvo.	BLD0/FLR4	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826268/1699942826270.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826268/1699942826271.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826268/1699942826272.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826268/1699942826273.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826268/1699942826274.png	2023-11-14 06:20:26.4562	\N
APM1699942826513	St. Crytal	15	20	1	2	9000000	inactive	Tum defleo condico accedo admitto ceno conduco. Arx considero vinco incidunt. Cibus libero ipsa cruentus calcar acidus illo ratione minima.\nCohors taedium veniam attero terra. Territo demens infit doloremque audeo. Confugo dolorem ducimus defendo deputo adeo adnuo.\nTriduana ceno debilito aperiam umerus beatae. Tero apto comitatus odit usus clementia. Temeritas molestias audentia aut vis saepe.	BLD0/FLR4	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826513/1699942826523.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826513/1699942826524.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826513/1699942826525.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826513/1699942826526.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826513/1699942826527.png	2023-11-14 06:20:26.768711	\N
APM1699942826816	St. Crytal	15	20	1	2	9000000	inactive	Alii tricesimus amo non corona cumque stips. Suffoco urbanus despecto tabgo tabernus sono conduco. Veritas aliquid tutis sit bis dolorum.\nConturbo angustus error avarus. Vitae coaegresco causa defero distinctio volutabrum depereo cognomen talis laudantium. Amor utrum vae.\nDepraedor truculenter aufero desparatus bos tam. Claro crastinus condico aliquam textor attollo. Sodalitas cinis cohors volutabrum vilitas vereor defendo administratio acervus.\nCuriositas ars ullus candidus caritas thymum. Texo studio cavus contigo denego. Vulgaris sub supplanto angustus clam tabula.	BLD0/FLR4	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826816/1699942826827.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826816/1699942826828.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826816/1699942826829.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826816/1699942826830.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942826816/1699942826831.png	2023-11-14 06:20:27.000567	\N
APM1699942827063	St. Crytal	15	20	1	2	9000000	inactive	Umbra amplus clementia canonicus bonus teneo dolorum defungo. Corona acquiro valens torqueo creo. Similique cognomen capio vesper ago ab.\nClarus utpote vado expedita voco. Admoneo ambulo voluptatibus utor umquam. Eveniet assentator deduco delinquo.\nCondico studio taedium. Quam abscido abeo benigne. Deludo cognomen tergo.\nDeporto deinde acidus adfectus repudiandae possimus ambitus appono statua facilis. Voluptatibus defetiscor admitto truculenter tergiversatio commodo. Advoco minus conculco.\nCetera centum uxor cogo velut atrocitas earum. Delicate vinco causa adimpleo suadeo adipiscor dicta. Ultra admoneo inventore tandem.	BLD0/FLR4	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827063/1699942827067.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827063/1699942827068.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827063/1699942827069.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827063/1699942827070.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827063/1699942827071.png	2023-11-14 06:20:27.400363	\N
APM1699942827407	St. Crytal	15	20	1	2	9000000	inactive	Absconditus trepide rem temeritas demoror hic sopor enim vulnus cauda. Ustulo praesentium demum xiphias sonitus aegrotatio quaerat. Annus sub tubineus truculenter clarus vis deorsum bos amitto.\nAbsorbeo studio conturbo cuppedia sto summa tener desino barba. Apostolus pel sol causa admiratio alias audeo confugo eligendi aurum. Surculus tres exercitationem culpa aperiam tredecim.\nCuriositas creator civis caste cultellus sed admoveo cenaculum audeo. Creta odio ambulo culpa tumultus avarus. Quo abscido arca stella clementia.	BLD1/FLR0	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827407/1699942827409.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827407/1699942827410.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827407/1699942827411.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827407/1699942827412.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827407/1699942827413.png	2023-11-14 06:20:27.654572	\N
APM1699942827708	St. Crytal	15	20	1	2	9000000	inactive	Tenus contra numquam solum decretum summisse. Vespillo cognomen aequitas vomica. Auxilium alter repellendus quisquam defetiscor termes urbs utilis.\nVetus coerceo calamitas vos caecus custodia urbs. Deludo adversus demens agnosco. Curis vulnus ultio aegre carcer sperno barba carbo aegrus cruentus.\nStillicidium arca vorago cupiditate thalassinus. Autem vivo cervus universe conicio temporibus utilis numquam denuncio. Amet vero astrum tergo abstergo.	BLD1/FLR0	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827708/1699942827709.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827708/1699942827710.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827708/1699942827711.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827708/1699942827712.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827708/1699942827713.png	2023-11-14 06:20:27.895361	\N
APM1699942827903	St. Crytal	15	20	1	2	9000000	inactive	Amor termes utilis contabesco vulgo adflicto illum. Spiculum dapifer harum nesciunt spiculum aut appositus adnuo. Tristis adeo atavus alter demo consectetur carus utrum.\nAliquid substantia esse ubi versus. Summopere capto vesica demonstro super desipio apto. Ubi amissio sono templum deludo.\nConculco valetudo ad. Bonus vulgivagus conatus decipio clamo capio acquiro pauper. Tot veritatis spectaculum pecto.\nVesper tantum compono. Compono aranea arbitro nihil vomer. Necessitatibus umbra cohaero.	BLD1/FLR0	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827903/1699942827905.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827903/1699942827906.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827903/1699942827907.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827903/1699942827908.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942827903/1699942827909.png	2023-11-14 06:20:28.144534	\N
APM1699942828148	St. Crytal	15	20	1	2	9000000	inactive	Voro sono aeternus dens tenetur. Clarus inventore terminatio color allatus trucido amplitudo. Averto clementia ultio depopulo quibusdam casus provident sonitus complectus accendo.\nCallide cicuta cuius excepturi vinculum. Tumultus timor eos pel depulso aptus degero tunc neque. Condico tantum vomer teres voluptatum antepono atavus damnatio.\nDeorsum doloremque nobis talis atque acidus atrox ciminatio fugiat. Adopto cultellus caste venio cura approbo vulariter caritas cimentarius acidus. Correptius comburo thermae adversus.\nSuscipit blanditiis territo. Auditor vergo ventus angustus vos tamdiu et sint. Thalassinus mollitia caritas truculenter.\nExcepturi conforto ducimus tamdiu templum. Amita dens fugit somniculosus aperio. Sulum cohaero vesper centum.	BLD1/FLR0	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828148/1699942828149.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828148/1699942828150.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828148/1699942828151.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828148/1699942828152.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828148/1699942828153.png	2023-11-14 06:20:28.368582	\N
APM1699942828372	St. Crytal	15	20	1	2	9000000	inactive	Quaerat conqueror angustus. Degero ante copia temporibus molestiae verus bis. Sequi numquam doloremque clementia cupio vobis coma antiquus ad cuppedia.\nAduro defaeco incidunt. Angustus cubo corporis sophismata absque. Supra clibanus deduco color solio tum.\nAufero sulum conventus confero vilis adicio coadunatio adamo. Aliqua argumentum tero complectus spero. Id vigilo vomica.	BLD1/FLR0	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828372/1699942828373.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828372/1699942828374.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828372/1699942828375.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828372/1699942828376.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828372/1699942828377.png	2023-11-14 06:20:28.662561	\N
APM1699942828665	St. Crytal	15	20	1	2	9000000	inactive	Abeo auctor bestia coadunatio odio dolore eum. Arbor spiritus tantum. Caterva totus subvenio adsum quia.\nTempore aer tutamen accusantium attero vaco. Adsidue laudantium a aliqua defluo. Adeptio ancilla vespillo claustrum voluptates.\nTui esse cunae ago candidus. Quasi tendo cursim adduco acquiro umerus audax usus. Terreo curso tergeo tardus somnus sum voveo illo.\nSonitus tam facere degero ut esse. Beneficium comprehendo modi sponte quasi decumbo curtus aiunt unde umbra. Aveho claro minima animadverto patruus abscido carbo tempus reprehenderit comprehendo.\nDerelinquo absque ater dolores sufficio patrocinor. Studio amo alo civitas. Complectus temporibus cumque thymbra calco aestus.	BLD1/FLR0	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828665/1699942828666.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828665/1699942828667.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828665/1699942828668.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828665/1699942828669.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828665/1699942828670.png	2023-11-14 06:20:28.869067	\N
APM1699942828872	St. Crytal	15	20	1	2	9000000	inactive	Talis tubineus ceno vinculum repellat auditor. Ver desino ambulo bene thorax. Vomica adsum denego.\nAcies vociferor officiis eaque validus cumque absque. Ulciscor cohibeo angulus compello speciosus dolore. Bibo harum caecus videlicet praesentium sol error.\nDenique ad ager. Benigne absum adsuesco tredecim doloribus auctus. Vilis currus facere turba deduco uter constans.\nVilla trado paens maiores ait voluptatum advenio ager rerum. Vicinus cibo tertius trepide cimentarius barba denique succurro catena provident. Dapifer minima vis acerbitas barba.\nCongregatio aequitas vis tui amiculum vomer. Claustrum cibo tabesco vallum conor timor. Umbra sordeo demitto audio abundans charisma.	BLD1/FLR1	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828872/1699942828873.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828872/1699942828874.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828872/1699942828875.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828872/1699942828876.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942828872/1699942828877.png	2023-11-14 06:20:29.186595	\N
APM1699942829265	St. Crytal	15	20	1	2	9000000	inactive	Adipisci vorax antea ut. Facilis voluptas textilis vado. Titulus confugo strues acer stillicidium bardus talio chirographum rerum.\nOcer textor vel tabesco tego cerno carpo necessitatibus comparo uter. Accusator repellat assentator nulla viridis cupiditate comprehendo acquiro sunt. Cedo aer sint.\nEarum paens deporto pecco commemoro cetera culpa. Cupiditas dens tego vesco civis totam utor caput. Adipisci vetus degero molestias considero eum.	BLD1/FLR1	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829265/1699942829266.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829265/1699942829267.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829265/1699942829268.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829265/1699942829269.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829265/1699942829270.png	2023-11-14 06:20:29.462498	\N
APM1699942829468	St. Crytal	15	20	1	2	9000000	inactive	Talis asporto alter auctus ait vacuus suspendo adhuc canto. Absconditus compello asperiores consequatur reiciendis crudelis arbitro adipisci angulus adeo. Denuo tabernus alioqui.\nTremo conscendo voco ex speculum conqueror. Utpote stabilis contabesco. Cedo contego voluptatum torqueo.\nBalbus thermae cibo sum. Calcar blandior curso soleo ambulo. Subvenio verecundia velit cursim victoria delego titulus campana tredecim demitto.\nSolvo voluptatibus concido cunabula tergum. Acquiro unde veniam cupio combibo cui optio cado pecco. Decumbo desipio defero.\nVulgivagus delectatio termes tracto ullam vulgo tamquam. Volo terga templum amplexus tempore sortitus virgo caste. Tempore tollo contigo coniuratio tribuo.	BLD1/FLR1	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829468/1699942829469.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829468/1699942829470.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829468/1699942829471.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829468/1699942829472.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829468/1699942829473.png	2023-11-14 06:20:29.640122	\N
APM1699942829643	St. Crytal	15	20	1	2	9000000	inactive	Valetudo ambitus deprecator thorax sit. Asporto deorsum comedo adficio universe creptio curvo. Exercitationem supellex arbustum dolorem ambulo stillicidium alo architecto sint numquam.\nArceo sperno contra coniecto admitto stabilis thymbra. Corporis texo tergiversatio appello neque velociter vobis abscido deficio. Contego adficio calcar sufficio.\nCoadunatio summopere tollo aureus doloribus tutamen delinquo. Apparatus consectetur praesentium. Depraedor copiose volup tolero tardus aperte quo apostolus.	BLD1/FLR1	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829643/1699942829644.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829643/1699942829645.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829643/1699942829646.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829643/1699942829647.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942829643/1699942829648.png	2023-11-14 06:20:30.266271	\N
APM1699942830364	St. Crytal	15	20	1	2	9000000	inactive	Ventito temperantia advenio colligo alii. Conspergo suspendo tametsi stabilis abundans facere atqui assentator. Strenuus cumque calculus vergo incidunt utpote cruciamentum casus basium temptatio.\nCavus cognomen consequuntur aspernatur civis nemo. Virga assumenda virgo tyrannus compono vallum. Tamdiu allatus aer praesentium vinum.\nAedificium colo calcar delego sursum angelus circumvenio ultra aperte. Consuasor pel adamo asper amissio statua volo. Decipio quod caelestis cerno creber artificiose adamo talus confido volubilis.	BLD1/FLR1	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830364/1699942830365.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830364/1699942830462.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830364/1699942830464.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830364/1699942830465.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830364/1699942830466.png	2023-11-14 06:20:30.868365	\N
APM1699942830871	St. Crytal	15	20	1	2	9000000	inactive	Aureus subiungo barba alo censura thymum comis substantia. Attonbitus turpis tribuo benevolentia asper ventosus victus. Defessus uxor deleniti perferendis armarium beatus tunc coniuratio cubo.\nAmissio arbitro adversus hic suspendo minima abeo absens voluptatum. Curo voluptate natus verecundia ustulo molestiae earum convoco. Accusamus aegrus tenetur collum tergeo cruciamentum.\nCorrupti thalassinus pariatur vapulus compello natus denego abscido. Sunt cavus fugiat terminatio caste conqueror thesaurus utrum depulso. Ipsa comes versus accendo.\nAperte paulatim tredecim quia cibo thesis amor vigor adipisci deleniti. Venia casus accommodo surculus. Capto cognatus vae cauda vulgo demoror est.\nClamo adeo consectetur testimonium curtus admiratio causa tubineus tersus tres. Depono volaticus verbera vinco approbo. Recusandae crapula libero.	BLD1/FLR1	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830871/1699942830872.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830871/1699942830873.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830871/1699942830874.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830871/1699942830875.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942830871/1699942830876.png	2023-11-14 06:20:31.269581	\N
APM1699942831272	St. Crytal	15	20	1	2	9000000	inactive	Vester despecto tenax soluta inventore accedo cibo rem. Cogito usus antea super cernuus soluta blanditiis. Cotidie crur ratione vulnus.\nAufero distinctio vox agnitio labore valeo consequuntur tametsi viscus. Volo claudeo curriculum anser aro textus vita urbanus delego comedo. Tribuo demergo curatio defessus infit.\nTurpis umbra stultus admiratio. Damnatio dolorem thesis. Tabula urbs voluptates condico adulescens contabesco alias.\nCubicularis communis tempus tumultus coniuratio canto cruciamentum alioqui animi tibi. Verus attero teneo solium. Ambulo surculus adulescens ab.	BLD1/FLR2	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831272/1699942831273.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831272/1699942831274.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831272/1699942831275.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831272/1699942831276.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831272/1699942831277.png	2023-11-14 06:20:31.442719	\N
APM1699942831445	St. Crytal	15	20	1	2	9000000	inactive	Aut similique vulnus aequitas corona. Celer sponte ambitus angulus cito antea sumo aegrus subito. Appono animadverto verbera dapifer.\nTalio thesaurus vito nemo textilis vitae. Ambulo vigilo facere libero. Strues adsidue conturbo casso talus tantum nulla curatio.\nDelinquo vinco vilicus voluptates bibo versus conqueror. Tempora sit dicta. Eos auctor demoror cohors spiritus aequus arca succurro.	BLD1/FLR2	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831445/1699942831446.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831445/1699942831447.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831445/1699942831448.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831445/1699942831449.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831445/1699942831450.png	2023-11-14 06:20:31.62326	\N
APM1699942831626	St. Crytal	15	20	1	2	9000000	inactive	Tot asporto baiulus depraedor cupiditas. Cognomen truculenter curto talis spes tempore adhaero ulciscor. Bardus soleo voveo aegre sint utpote cerno sustineo distinctio defungo.\nAdsuesco apparatus labore laudantium trepide. Cum impedit defessus cribro perspiciatis cedo cura. Utrum antiquus vox vapulus pectus.\nCrapula defendo patruus taceo. Tempore aliquam conatus aureus tempora avarus pecto capto. Stultus non aperiam omnis tabernus ver acervus testimonium maxime modi.	BLD1/FLR2	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831626/1699942831626.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831626/1699942831627.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831626/1699942831628.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831626/1699942831629.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831626/1699942831630.png	2023-11-14 06:20:31.809019	\N
APM1699942831812	St. Crytal	15	20	1	2	9000000	inactive	Crinis cibo arcus debilito error cuppedia aequus candidus dolores. Vilicus complectus centum patruus tam tum amiculum bos. Velociter aliquid abundans aspernatur.\nEaque tabella adicio somnus super dicta textilis. Vir cribro vaco volutabrum conqueror subnecto trado contabesco. Voluptatem reiciendis pecus accusamus usus adnuo curto centum apto bibo.\nCrux arbustum clam vivo tripudio caries creptio illum correptius. Tui comptus volutabrum corpus subvenio sumptus confido. Commodi ait debitis agnosco molestias adeptio terra vereor spargo.\nCaecus defungo aspernatur sto ara vociferor claudeo sustineo conduco voluptatibus. Ullam cibus tergeo tenuis cubo autus totidem volva. Accusator atrox caste molestiae cupio usque corrigo.\nTametsi vilicus alius voluptas stultus utroque unus triumphus. Thymbra talis accusantium admiratio carpo. Corona video capillus absorbeo.	BLD1/FLR2	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831812/1699942831813.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831812/1699942831814.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831812/1699942831815.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831812/1699942831816.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942831812/1699942831817.png	2023-11-14 06:20:32.010127	\N
APM1699942832013	St. Crytal	15	20	1	2	9000000	inactive	Odio cursim tumultus uter tempus caritas cur. Vulgivagus teres voluptas tantillus desolo paens vetus. Argumentum corpus quo territo voluptas.\nAmicitia amicitia compono aegre. Pel brevis clarus admiratio. Perspiciatis suppono recusandae voluntarius sunt inflammatio.\nAmoveo molestias cito truculenter adfero. Conservo adstringo suscipit corpus claro virga. Cauda audax adnuo.	BLD1/FLR2	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832013/1699942832014.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832013/1699942832015.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832013/1699942832016.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832013/1699942832017.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832013/1699942832018.png	2023-11-14 06:20:32.190476	\N
APM1699942832194	St. Crytal	15	20	1	2	9000000	inactive	Toties autem adipiscor pecto eius conculco. Hic absens acies. Angulus victoria comedo sodalitas.\nVos aureus audeo valetudo natus deprimo vae desidero alias suppono. Bardus texo desino vindico. Tersus recusandae ventosus fugit.\nCrebro eos tum denego fugit suasoria. Collum vehemens curvo conduco ara cupiditate impedit tredecim campana. Accusantium facere vulnus acer omnis voluptatum alo ceno.\nAdipiscor bonus cum inflammatio vilis unde tempore vicissitudo confero. Theatrum corporis soleo aliqua. Aggredior accendo coniuratio.	BLD1/FLR2	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832194/1699942832195.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832194/1699942832196.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832194/1699942832197.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832194/1699942832198.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832194/1699942832199.png	2023-11-14 06:20:32.408352	\N
APM1699942832420	St. Crytal	15	20	1	2	9000000	inactive	Error cariosus admoveo umquam depono natus vilicus. Caput aedificium subiungo iusto cito deleo clementia. Aut ipsa statim sumo urbanus audeo sopor tutamen.\nAptus sopor artificiose. Quibusdam aduro ustulo comminor delibero. Vomica candidus sonitus.\nAperte cupio succedo bardus. Decens dicta victoria arma paulatim. Confido somnus territo cena vere depopulo crux spoliatio.\nAmicitia terra vulariter aestus clamo tandem fugiat dolores uxor. Acerbitas super quis voluptatum timidus eum tandem. Complectus sufficio arx creptio vindico abscido ipsa aureus.	BLD1/FLR3	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832420/1699942832421.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832420/1699942832422.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832420/1699942832423.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832420/1699942832424.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832420/1699942832425.png	2023-11-14 06:20:32.611468	\N
APM1699942832614	St. Crytal	15	20	1	2	9000000	inactive	Confido auctor patrocinor caute vitae. Audio coma sublime amiculum tripudio assentator desipio auxilium ea vere. Aut praesentium toties supellex stultus calamitas vulticulus copiose verbera.\nIpsa claustrum nisi apparatus. Atrocitas addo triduana adversus. Assentator eaque defetiscor defessus defendo.\nTheca depulso avarus voluntarius canto pel natus. Cibo absorbeo supellex corroboro armarium. Coniuratio aiunt assumenda certe convoco clibanus voluptatibus depopulo cohors cultellus.	BLD1/FLR3	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832614/1699942832615.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832614/1699942832616.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832614/1699942832617.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832614/1699942832618.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832614/1699942832619.png	2023-11-14 06:20:32.822225	\N
APM1699942832825	St. Crytal	15	20	1	2	9000000	inactive	Ager explicabo commodi trepide cubitum trado. Victoria communis ventito. Absque veritatis alii coma tendo terror admitto spectaculum adopto.\nNam delego amplus defaeco thymum cavus solutio laboriosam acceptus. Vobis cibus sumo vilitas cilicium ascit. Vado demens terebro cohors articulus asperiores.\nCogo combibo trans amaritudo architecto. Aeternus condico via conatus somnus facilis subseco. Cunctatio vox argentum clarus absens quia arto calamitas bardus.	BLD1/FLR3	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832825/1699942832826.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832825/1699942832827.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832825/1699942832828.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832825/1699942832829.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942832825/1699942832830.png	2023-11-14 06:20:33.030649	\N
APM1699942833033	St. Crytal	15	20	1	2	9000000	inactive	Demo conspergo venustas dignissimos adstringo. Administratio defluo cibus. Crebro torqueo pecto victoria tenax considero.\nIllo defero addo cuppedia volo ipsa alienus sublime canto ante. Administratio taceo conculco. Vacuus crudelis allatus ullam.\nVorax valde combibo vigor sophismata viriliter. Aeger quis speciosus corpus. Uredo aeger terreo at curo curtus vestigium.	BLD1/FLR3	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833033/1699942833034.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833033/1699942833035.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833033/1699942833036.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833033/1699942833037.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833033/1699942833038.png	2023-11-14 06:20:33.281332	\N
APM1699942833285	St. Crytal	15	20	1	2	9000000	inactive	Volaticus sponte contego amet corroboro sol. Trepide sunt tamquam sequi verbum. Bonus damnatio nihil debilito doloribus denique.\nVomica dedico aggero annus deinde cum adsuesco. Animadverto ager varietas peior stips trepide caterva commemoro. Fugiat curiositas allatus cornu vallum vitae curatio.\nLibero crepusculum consectetur accommodo nesciunt aeternus surculus. Alioqui curso alias nisi ullam vis turpis. Termes velit tutamen ultio arceo cupressus utroque quas aveho tersus.\nVerbum censura traho vesco articulus tersus creo auctor. Defleo correptius bellum vulgo celer autus. Pectus tolero necessitatibus celo cultura chirographum theologus blandior inflammatio.	BLD1/FLR3	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833285/1699942833286.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833285/1699942833287.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833285/1699942833288.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833285/1699942833289.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833285/1699942833290.png	2023-11-14 06:20:33.458252	\N
APM1699942833461	St. Crytal	15	20	1	2	9000000	inactive	Cena autus id. Eligendi utor contabesco voluptas. Coerceo appositus caput comprehendo.\nVia sponte praesentium vetus audeo. Curatio tumultus spes demitto. Denique delicate appono tribuo harum amiculum caterva comitatus sono decipio.\nVulgivagus baiulus derideo atqui deficio beatae veritatis. Voluptatum a termes carmen studio campana acquiro. Bestia validus tantum texo alias victoria tero.\nEveniet debitis tergum deporto defendo canonicus fugit. Arceo vis abbas ratione tenetur adipisci. Comprehendo bibo pectus iusto atrox callide.\nCollum demum venio trado alter chirographum triumphus curiositas denego utique. Amplitudo nemo antiquus denique decumbo. Constans umbra nemo vulnero debitis temporibus synagoga speculum cubitum victoria.	BLD1/FLR3	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833461/1699942833462.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833461/1699942833463.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833461/1699942833464.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833461/1699942833465.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833461/1699942833466.png	2023-11-14 06:20:33.640587	\N
APM1699942833666	St. Crytal	15	20	1	2	9000000	inactive	Vehemens aduro appositus beatae vilitas valetudo abstergo possimus. Ipsam thesaurus venia denuo vis subito tergo suscipio enim error. Cervus depereo talus architecto teres dolore verumtamen earum a colo.\nAnimi tremo solium tergeo. Ver totus tardus utrimque caput verus carmen. Spoliatio provident amiculum tantillus circumvenio.\nDefero eos vorago sum adduco ubi cras consectetur claudeo balbus. Articulus curto dolores damno cetera cotidie ambulo callide sponte. Tunc canonicus pauci nemo adipiscor admitto vergo aegrus.\nConspergo vulnus delibero correptius pax maxime vaco uxor totam. Ea repudiandae vesper combibo sopor adeptio villa. Aequus sumo sonitus aspicio convoco nobis tego.	BLD1/FLR4	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833666/1699942833667.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833666/1699942833668.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833666/1699942833669.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833666/1699942833670.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833666/1699942833671.png	2023-11-14 06:20:33.822243	\N
APM1699942833825	St. Crytal	15	20	1	2	9000000	inactive	Thesis paens vapulus tantillus thorax tabesco stultus reprehenderit cogito. Cultellus atqui ultra vere. Textilis cibus capio thymum deleo.\nAeneus desipio audacia vivo vulticulus constans incidunt convoco tertius defungo. Optio cruentus cribro cupio nihil sub thalassinus cenaculum. Creber usus advoco adipiscor quaerat tam spiritus appello.\nSubiungo suggero auctus bellum tantillus debeo assumenda spiculum thesis. Tonsor thema volo. Absque titulus aetas libero decretum stabilis suppellex textus comprehendo subito.\nVix uterque claro sub arbitro tricesimus tamisium. Adulatio cibo tamdiu vester brevis consectetur trucido cunae terra. Compono illo repellendus.\nMolestiae amaritudo solium patruus. Vinum paens crinis consequatur ulciscor vinitor trucido beneficium. Defaeco odio subiungo fuga saepe degero.	BLD1/FLR4	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833825/1699942833826.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833825/1699942833827.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833825/1699942833828.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833825/1699942833829.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942833825/1699942833830.png	2023-11-14 06:20:34.000007	\N
APM1699942834002	St. Crytal	15	20	1	2	9000000	inactive	Aedificium sulum solutio quasi. Facere depereo verto deripio rerum quis absorbeo angustus. Cupiditate corrupti adfectus virtus itaque vinculum stipes.\nAccusamus utique similique tutamen viridis et trans. Nisi custodia libero terreo hic velit. Cursim dens clarus cunabula careo natus.\nSimilique curo officiis stillicidium arcus adsidue. Depereo aestas tabula. Conculco utilis nihil aro magni quae argumentum.\nAdduco cupio thalassinus debitis. Amplexus claudeo thorax depulso terror optio. Derelinquo officia vilitas aestivus cornu vir.\nThalassinus admiratio viscus patruus. Explicabo virtus tabesco adipisci denique conculco comburo attollo vicissitudo deleo. Voluptatum bonus tamen abutor.	BLD1/FLR4	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834002/1699942834003.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834002/1699942834004.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834002/1699942834005.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834002/1699942834006.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834002/1699942834007.png	2023-11-14 06:20:34.206452	\N
APM1699942834209	St. Crytal	15	20	1	2	9000000	inactive	Alveus tenax quaerat. Acies viduo coadunatio thema patria solitudo collum. Iste eaque conscendo.\nSoluta ventosus cavus admoveo apto tutis nihil tepesco ipsa stella. Amplus animi cur alii trado tolero alienus cognomen demergo. Cultellus argumentum calcar aiunt cur veritas voro soleo arx ubi.\nAntiquus tunc tenuis curo quod. Supplanto cunabula strenuus aggero. Casus terreo torrens voluptatem optio.	BLD1/FLR4	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834209/1699942834210.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834209/1699942834211.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834209/1699942834212.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834209/1699942834213.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834209/1699942834214.png	2023-11-14 06:20:34.436917	\N
APM1699942834439	St. Crytal	15	20	1	2	9000000	inactive	Acidus xiphias contra accendo conspergo corporis vix vere pariatur canis. Tepidus cohors centum umbra. Spes soleo ustilo admiratio vilitas brevis.\nVelum ultio confido curiositas arbitro. Celebrer tepesco absorbeo numquam tredecim cilicium cunctatio bibo est tantum. Pax nobis bis.\nSit suppono ara abundans provident. Sit veritas suus adsuesco despecto denique aperio annus. Aduro debitis adnuo.	BLD1/FLR4	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834439/1699942834440.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834439/1699942834441.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834439/1699942834442.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834439/1699942834443.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834439/1699942834444.png	2023-11-14 06:20:34.653103	\N
APM1699942834656	St. Crytal	15	20	1	2	9000000	inactive	Dolore conduco canis paulatim utique stella. Vulgus temptatio capio. Valetudo aedificium torqueo tutis degero maxime tempore sperno.\nAstrum cupiditas crustulum desparatus perspiciatis desidero theologus audacia cui. Benevolentia venia aggero tego uter cohibeo. Spectaculum ullam utor decipio.\nPraesentium terror delinquo blanditiis sub derelinquo avarus totus. Culpa virga cenaculum solitudo aiunt verbum tergeo derelinquo balbus baiulus. Omnis abduco caelum volup toties ante depopulo callide.\nAbsum alii combibo patior conscendo voluptates. Aurum bellicus accusantium. Delectus cognatus omnis cibus anser.\nVerto theologus incidunt. Cibus adulatio voluptatibus vado unus nihil. Adeptio animadverto quibusdam vespillo coadunatio.	BLD1/FLR4	BLD1	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834656/1699942834656.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834656/1699942834657.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834656/1699942834658.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834656/1699942834659.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834656/1699942834660.png	2023-11-14 06:20:34.826268	\N
APM1699942834829	St. Crytal	15	20	1	2	9000000	inactive	Utpote tui alienus. Tres alius voveo tot utpote summopere arbitro suasoria antepono campana. Quibusdam quas dedecor admoveo substantia vomica voco consequuntur tero.\nCuius vivo vesper auctus. Demitto carus vetus super depulso thema varius concido. Amplexus laboriosam cavus.\nTerreo thymum porro voluptatem. Timor explicabo tamquam deprecator cunabula sperno ultio conitor texo. Creber delectus tot laboriosam molestias circumvenio.\nPraesentium incidunt substantia crebro. Crinis ara tamquam pecto solum consuasor. Aegrus conspergo caterva amoveo.\nAntea substantia quis triumphus. Virgo harum caute caveo denego doloremque cur cinis surgo. Ustulo canto voluptatum acervus toties balbus deleniti comitatus vinculum.	BLD2/FLR0	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834829/1699942834861.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834829/1699942834863.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834829/1699942834864.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834829/1699942834865.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942834829/1699942834866.png	2023-11-14 06:20:35.165817	\N
APM1699942835169	St. Crytal	15	20	1	2	9000000	inactive	Avarus eveniet aurum vinco voluptates. Vere crudelis tepesco. Speculum censura acerbitas vulticulus arma accusator conqueror verto quasi statim.\nAnimus conqueror ut verbum utrimque ars decipio deleo cicuta apud. Strues spectaculum adeptio tamquam aro suggero. Capto deripio uredo acies circumvenio voluptatum solium condico.\nCurto officia adulatio conor tabula. Deserunt ancilla vicissitudo bellum suppono creator. Voluptate valetudo vinitor auditor.\nSupra tondeo armarium subnecto sodalitas cado. Vulnus surculus delectus. Acerbitas sollicito dolore.	BLD2/FLR0	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835169/1699942835170.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835169/1699942835171.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835169/1699942835172.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835169/1699942835173.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835169/1699942835174.png	2023-11-14 06:20:35.389686	\N
APM1699942835393	St. Crytal	15	20	1	2	9000000	inactive	Cilicium amissio abscido tergum attero pecus summa amissio carbo. Basium socius unus correptius alias tui cubo a abutor. Anser aeger aequitas ipsam suscipit perferendis abbas casso.\nVaco quis carmen. Ater sui adduco tristis vindico ago depono cerno vacuus. Cursus volo deludo soleo.\nComedo colligo vilis ager sodalitas. Vita turbo caste charisma coma crastinus vaco debitis. Harum aperte cultellus repudiandae laborum.\nAb coerceo fuga volup demitto temeritas sperno damnatio teneo crur. Doloribus sed suadeo tego conforto teres cunae. Damnatio tergeo optio amplitudo cubicularis.\nVero adficio accusantium apto. Suffragium ventito ventus constans laudantium sordeo agnosco tunc. Candidus desino vero cotidie spero thalassinus accusator.	BLD2/FLR0	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835393/1699942835394.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835393/1699942835395.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835393/1699942835396.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835393/1699942835397.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835393/1699942835398.png	2023-11-14 06:20:35.772647	\N
APM1699942835776	St. Crytal	15	20	1	2	9000000	inactive	Aptus certus pecto demens appello. Derideo exercitationem taceo. Trepide subseco canonicus tergo aperio beneficium.\nCarmen coniecto conor deripio cerno ullus abstergo ad pectus. Soluta veniam tam comis suscipio patria. Socius conservo consuasor victus causa agnitio in vaco summopere caterva.\nPauci expedita uberrime ara victus cornu. Maxime comprehendo culpa expedita. Vulariter comis ater.\nVehemens armarium excepturi reiciendis veniam. Canis catena arto rem. Tam tyrannus derelinquo laborum.\nOccaecati sol stipes abbas defetiscor creber. Adulescens sapiente considero temptatio. Quod deludo accendo baiulus recusandae solio itaque quos.	BLD2/FLR0	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835776/1699942835777.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835776/1699942835778.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835776/1699942835779.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835776/1699942835780.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835776/1699942835781.png	2023-11-14 06:20:35.977274	\N
APM1699942835980	St. Crytal	15	20	1	2	9000000	inactive	Appono calamitas labore vinum umquam cattus bestia. Cohaero sursum clarus accusator acsi deleo. Repellat vitae viscus accusantium vulticulus uterque stips doloremque blanditiis.\nSpero adeptio trans tumultus caecus. Suscipio usus doloremque bellum crepusculum vaco. Altus sordeo deleniti.\nVoco nemo compono porro cernuus nemo. Cotidie angelus conqueror atrox videlicet velum centum auditor quis timidus. Reiciendis communis tunc aegrotatio crepusculum virtus viduo venustas nisi caritas.\nDebilito beatus vestigium ceno vehemens cruciamentum dolores debitis comes. Vorago cubitum quos at pauci crinis acsi. Viridis cerno caelestis aggredior in creta tres autem dolorum.\nTextilis defungo vapulus crastinus dolorem curvo appello quod utrum caelum. Vaco conatus quam comis uredo admiratio debilito. Casus carpo ullam.	BLD2/FLR0	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835980/1699942835981.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835980/1699942835982.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835980/1699942835983.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835980/1699942835984.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942835980/1699942835985.png	2023-11-14 06:20:36.268698	\N
APM1699942839678	St. Crytal	15	20	1	2	9000000	inactive	Ante aetas tero expedita victus uberrime alius acies. Cupiditate taedium vae termes. Corona agnitio adeptio avarus.\nAut super caste aegrus ter. Testimonium aestas arbustum tepidus. Vinco velut deorsum.\nVenio pecus turbo vomito beatae. Similique rem compello deripio vel. Corroboro curo accusantium cur vallum talio decumbo blandior peior appello.	BLD2/FLR2	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839678/1699942839679.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839678/1699942839680.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839678/1699942839681.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839678/1699942839682.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839678/1699942839683.png	2023-11-14 06:20:39.924561	\N
APM1699942836283	St. Crytal	15	20	1	2	9000000	inactive	Civis sollicito carcer cinis cohibeo dolorem vero auxilium ad tristis. Ademptio templum decor. Vigilo soluta inflammatio porro.\nConduco aegrotatio versus vester suasoria sollicito conscendo. Tempus odio valde vito deinde. Distinctio claustrum vitae contabesco creator sollicito aro.\nSulum vilis viscus cetera illum optio deripio aestas commemoro. Adulescens vulgaris conculco tricesimus via canis conscendo volutabrum voco venio. Averto curtus desino atrox derideo comptus spargo umbra.\nAdiuvo demoror denuncio pariatur vindico cribro triumphus. Ulciscor auctor agnosco voluptatem corroboro alveus dedico censura. Credo abstergo curtus aut.	BLD2/FLR0	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942836283/1699942836287.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942836283/1699942836288.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942836283/1699942836289.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942836283/1699942836290.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942836283/1699942836291.png	2023-11-14 06:20:36.5718	\N
APM1699942837299	St. Crytal	15	20	1	2	9000000	inactive	Curriculum consectetur deduco corrumpo. Cultellus valeo autem capto apostolus peior solium arceo. Usque demonstro tempore totam aurum eveniet.\nDespecto curto tego abbas cattus recusandae. Trepide caste bibo culpo aestus. Solitudo addo curriculum tabgo.\nCras tolero eaque eligendi balbus benigne tergo ullus spectaculum. Sint celebrer thalassinus vere quam. Voluptas adipisci copiose appono auxilium territo nam audax usus.\nCaute truculenter pecto addo debitis summisse conor. Corrumpo depono absque ea ullus arma. Cohibeo undique molestias.\nDefero dolores iure ambitus turbo una accedo iure. Sapiente eum cavus tam arcus usus vergo tener dolorum cena. Tutamen deserunt speculum ager ago itaque totam arma.	BLD2/FLR1	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837299/1699942837306.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837299/1699942837307.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837299/1699942837308.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837299/1699942837309.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837299/1699942837310.png	2023-11-14 06:20:37.604313	\N
APM1699942837703	St. Crytal	15	20	1	2	9000000	inactive	Reiciendis abundans aranea ubi. Vereor callide vulnero curatio asperiores decerno. Maxime deprecator alveus utor cunabula.\nAlioqui degero illum coepi asporto optio cubicularis impedit crudelis tantum. Corpus tergiversatio calcar numquam. Esse temeritas animi ago deludo comminor recusandae ulciscor ancilla.\nAeger arcus thema sint vester tui. Caste doloribus officia acquiro nesciunt balbus cunctatio tolero vulticulus victus. Valetudo eveniet adulatio summisse speciosus summisse summa dolorum.	BLD2/FLR1	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837703/1699942837704.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837703/1699942837705.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837703/1699942837706.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837703/1699942837707.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837703/1699942837708.png	2023-11-14 06:20:37.908351	\N
APM1699942837912	St. Crytal	15	20	1	2	9000000	inactive	Sto ago truculenter quibusdam exercitationem. Vorago argumentum abeo beatae. Vehemens abbas peccatus cur depromo tero cresco vulnero.\nBardus delibero celebrer ager certus adflicto vitiosus. Ars decerno celer. Sol terebro caput acceptus at vir abstergo architecto.\nThesis ea utpote copia totus deripio apostolus distinctio ventus. Vomica volva delibero. Taedium vomito conforto civis.\nVilis velut tero. Sed vulariter explicabo. Tripudio theatrum ultra.	BLD2/FLR1	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837912/1699942837913.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837912/1699942837914.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837912/1699942837915.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837912/1699942837916.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942837912/1699942837917.png	2023-11-14 06:20:38.123789	\N
APM1699942838126	St. Crytal	15	20	1	2	9000000	inactive	Suscipit voluptates acervus trucido capillus. Dolor apto rerum uberrime. Cibo autus distinctio crinis suppono copia veniam quam cibo spiculum.\nOccaecati aro molestias viridis delectus. Urbanus tui accusantium solus deludo cibus bellicus taceo adduco. Amaritudo absque tepidus comprehendo capio.\nCur ascisco dolores cupiditate. Quia recusandae debitis vinum coepi dolorem coepi copia. Aequitas xiphias decens copiose sunt.\nAbsens nam vitiosus cubitum valde apparatus concedo ager curso natus. Decens culpa quo vobis decipio tibi eius. Cetera quas cubicularis contra adstringo tergiversatio causa patria totidem capitulus.	BLD2/FLR1	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838126/1699942838127.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838126/1699942838128.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838126/1699942838129.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838126/1699942838130.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838126/1699942838131.png	2023-11-14 06:20:38.317481	\N
APM1699942838320	St. Crytal	15	20	1	2	9000000	inactive	Tergeo collum voluptas cavus conculco deprimo quas. Audacia ocer conculco amitto confugo. Catena vinculum necessitatibus cerno dapifer sophismata sollicito ait.\nSynagoga contigo deporto quaerat arcus acer vinculum excepturi sortitus succurro. Stips conspergo bis. Tero cursim torqueo aveho aperio animadverto doloremque.\nArcus verbera aduro caveo caritas aestivus valde aeneus. Agnitio textilis tandem somniculosus verbum. Caries atque carcer thermae absorbeo patria dolorum.\nTandem ocer cupio atqui callide canonicus. Aedificium crinis tabella vester tripudio. Suasoria vaco auctor deserunt viscus casso barba suscipit amplitudo.\nAd amoveo minus blanditiis tredecim. Cogo bellicus vero. Verto aeternus ancilla at laborum.	BLD2/FLR1	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838320/1699942838321.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838320/1699942838322.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838320/1699942838323.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838320/1699942838324.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838320/1699942838325.png	2023-11-14 06:20:38.488707	\N
APM1699942838491	St. Crytal	15	20	1	2	9000000	inactive	Impedit curo vulgus modi claudeo corroboro assentator. Taceo somniculosus animus crastinus quas tamdiu vulnus. Temptatio porro ago amiculum pariatur optio derelinquo.\nCervus vis vallum degero congregatio utor vereor. Venio acceptus ceno cimentarius valens adsidue auctus sopor sum. Pauci casus claro cohaero apostolus verus coerceo.\nSui tener ipsum defendo abeo audio creber vere. Sit porro cubicularis deduco peccatus. Audacia arcus architecto adaugeo voluptatibus.\nAlter textor vulgo vomica patria vergo. Conspergo cattus terminatio cur caute apostolus subiungo vinco. Curia dolore aliquam cumque vigor dapifer corrumpo trucido dicta.	BLD2/FLR1	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838491/1699942838495.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838491/1699942838496.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838491/1699942838497.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838491/1699942838498.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838491/1699942838499.png	2023-11-14 06:20:38.656045	\N
APM1699942838658	St. Crytal	15	20	1	2	9000000	inactive	Aufero recusandae voluptate adiuvo beatae volva curatio velum. Curso aegrus amissio nesciunt crastinus conservo defluo civitas. Paens vestigium umquam caute nam thesis attonbitus decor terga.\nEarum aveho vetus clibanus vinculum copiose compello cursim celo coruscus. Via tersus voluptatibus. Compono sono tabula molestias fugit considero ratione amplitudo crudelis.\nTer via demitto admitto asperiores odio paens mollitia voluntarius civitas. Explicabo aqua corrumpo talis corporis nisi curia. Terror defluo a demonstro ustilo.\nProvident depromo tempus conatus verto. Theatrum clibanus atavus. Cado in totidem adficio valens delinquo autem sulum aggredior agnosco.	BLD2/FLR2	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838658/1699942838659.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838658/1699942838660.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838658/1699942838661.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838658/1699942838662.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838658/1699942838663.png	2023-11-14 06:20:38.86438	\N
APM1699942838867	St. Crytal	15	20	1	2	9000000	inactive	Suspendo pax desolo vorago. Volo conscendo brevis turba vulpes soleo. Vester verto vicissitudo pecto cupio aurum tantum.\nExcepturi dolorum arbustum aequitas delinquo ambitus. Cogito talus decimus crustulum suppellex vita ago derideo. Cattus coadunatio argentum timor aperio viridis atque.\nVoro aeger porro apud. Quibusdam adimpleo libero. Tondeo cibo officiis.	BLD2/FLR2	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838867/1699942838868.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838867/1699942838869.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838867/1699942838870.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838867/1699942838871.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942838867/1699942838872.png	2023-11-14 06:20:39.048913	\N
APM1699942839051	St. Crytal	15	20	1	2	9000000	inactive	Textor suscipit verus averto aestus ullam tamdiu libero. Statua certe asper subnecto celebrer ultra. Soleo quod arguo aequus sublime templum altus.\nViscus casso pauper celebrer error temeritas tam acer omnis. Campana termes absum tertius depereo officiis carcer amor socius. Cognatus utor comburo aliquam utique tabella creta depraedor collum.\nConservo aggredior tenuis currus inventore. Admitto cattus iste deludo paulatim tumultus. Decretum culpa eaque turbo.	BLD2/FLR2	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839051/1699942839052.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839051/1699942839053.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839051/1699942839054.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839051/1699942839055.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839051/1699942839056.png	2023-11-14 06:20:39.247299	\N
APM1699942839250	St. Crytal	15	20	1	2	9000000	inactive	Absens comprehendo certus thesaurus auxilium averto. Spiculum deficio expedita concido demens vereor atrox subvenio tredecim. Venia iure voluptas videlicet vinum aut cunae testimonium adamo valeo.\nVestigium despecto timor. Verumtamen desidero ara ocer. Modi eaque conatus degenero tego bonus vindico timidus creo animus.\nTero articulus depromo sulum sapiente. Suscipit chirographum depulso deserunt natus. Valde arcesso demens.\nCruentus sub amet alii ad. Sunt voro basium odio suffragium solvo. Demonstro ubi spes arma benigne defluo curvo ustilo suggero.	BLD2/FLR2	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839250/1699942839251.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839250/1699942839252.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839250/1699942839253.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839250/1699942839254.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839250/1699942839255.png	2023-11-14 06:20:39.468136	\N
APM1699942839471	St. Crytal	15	20	1	2	9000000	inactive	Bardus vel uterque cernuus sublime crudelis deleo sit nesciunt. Curo vilicus nesciunt supplanto optio umquam cilicium tandem allatus argentum. Tredecim caecus victus repudiandae defero comprehendo quod vae defluo adflicto.\nDolor statim caelestis vivo quod cado templum ullus tredecim. Stultus virtus aliqua suspendo barba laborum quasi summa admoneo viscus. Creptio stella spero tepidus caecus quibusdam talis.\nAestus adflicto varius varius corrupti. Adamo crustulum velociter deprimo voco triumphus. Aer utroque communis vulgus aufero quam texo.\nVoveo creta nam victus error. Viriliter trepide temeritas capto. Sono caelum congregatio.	BLD2/FLR2	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839471/1699942839471.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839471/1699942839472.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839471/1699942839473.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839471/1699942839474.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839471/1699942839475.png	2023-11-14 06:20:39.668354	\N
APM1699942839936	St. Crytal	15	20	1	2	9000000	inactive	Certus capio curis deinde cuius. Ad tricesimus carbo. Textilis cruentus absens uredo aro.\nCohors argentum corrumpo capillus provident assentator apud pectus deleo copia. Comitatus ultio vae tum vulnus saepe crur clamo delinquo. Acervus sulum supplanto cauda curis convoco appositus cubicularis decerno caste.\nVolaticus taceo peccatus occaecati. Cursim sui spoliatio vulariter tricesimus demum necessitatibus. Compello ater sponte.\nTerra apud defessus venio. Rem at alter arcus subito tandem unus ustilo. Laudantium repellendus comprehendo ea.\nConsuasor vix caelum commodo ascit sulum benigne. Condico cogito vigilo ager velum atqui aperio. Ulciscor coniecto alienus bos venio stips deserunt conatus beatus.	BLD2/FLR3	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839936/1699942839937.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839936/1699942839938.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839936/1699942839939.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839936/1699942839940.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942839936/1699942839941.png	2023-11-14 06:20:40.210571	\N
APM1699942840219	St. Crytal	15	20	1	2	9000000	inactive	Cognomen ullam totus uter. Tredecim delectus claro spero calcar arbitro occaecati taceo harum adinventitias. Autem amplus deduco absque.\nVerecundia rerum conventus cohibeo sophismata admoveo aranea. Claustrum cupiditas verbera tener curatio doloribus dedecor contra non. Doloremque bonus tendo contabesco temeritas.\nCrudelis verto colo deripio sopor urbanus sui animadverto cetera. Volo labore enim cupio ventito. Venia suppono vita audacia libero.	BLD2/FLR3	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840219/1699942840221.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840219/1699942840222.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840219/1699942840223.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840219/1699942840224.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840219/1699942840225.png	2023-11-14 06:20:40.476454	\N
APM1699942840480	St. Crytal	15	20	1	2	9000000	inactive	Contabesco approbo alienus sustineo. Animi sint accedo soleo. Ante uter derideo.\nAngelus pax taedium. Cupiditas umquam comminor nobis. Tubineus odit toties.\nDefetiscor denique beatus aduro veritatis. Earum voluptatum cursus vicissitudo bellum admiratio aetas blanditiis vilicus. Vox peccatus civis commodo doloremque tolero velociter statua quasi.\nCapto verumtamen coniuratio carmen tergiversatio tamdiu adduco solium. Spiritus suadeo charisma demo vinculum stultus urbanus averto. Bardus ustulo quo pecus summa.	BLD2/FLR3	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840480/1699942840480.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840480/1699942840481.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840480/1699942840483.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840480/1699942840484.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840480/1699942840485.png	2023-11-14 06:20:40.670054	\N
APM1699942840673	St. Crytal	15	20	1	2	9000000	inactive	Unde sed adicio. Suffragium claustrum canto sed condico demens cognomen derelinquo vacuus officiis. Earum caste consuasor canto paens.\nAbsorbeo adhuc decimus. Bene tres denuncio sui sortitus tres argentum ulciscor. Audacia alienus turpis adulatio tandem tamen.\nUrbs fugit ars teres vilis comedo bellicus cupressus. Conforto tenus vulgus aureus. Stultus cornu quibusdam acceptus.	BLD2/FLR3	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840673/1699942840674.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840673/1699942840675.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840673/1699942840676.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840673/1699942840677.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942840673/1699942840678.png	2023-11-14 06:20:41.073297	\N
APM1699942841094	St. Crytal	15	20	1	2	9000000	inactive	Suadeo quae defaeco acer caries. Soluta aveho ascit ubi fugit civitas solum. Venia iste auctor vae talis vilis comedo victoria acervus.\nPaens ipsam sol suscipio tandem acies utrimque. Aggredior communis terror accedo vesco. Considero vulnero comminor triumphus approbo et creber utpote umquam uredo.\nCaries constans culpo. Calcar voluptatem tero creptio crustulum perferendis suus. Aegrotatio apud sufficio carcer auxilium.\nAlias tui contabesco. Animus odit utrimque ventus comburo vomica. Amet summa subnecto ancilla aestus eos corrupti.\nContego demoror tondeo creator cogo ex. Stipes vespillo tumultus adaugeo. Deleniti aequitas solum adopto suasoria vel somniculosus casso.	BLD2/FLR3	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841094/1699942841095.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841094/1699942841107.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841094/1699942841108.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841094/1699942841109.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841094/1699942841110.png	2023-11-14 06:20:41.275424	\N
APM1699942841279	St. Crytal	15	20	1	2	9000000	inactive	Conspergo suppellex ut. Defleo catena delinquo capio deinde. Carcer caecus officiis cupressus voluptate.\nTantum curiositas bos aro adimpleo summopere suscipio. Canis votum certe deleo minima vulticulus aequitas. Teneo ante tabgo deinde eos.\nAppello torqueo confido compono verbum thema animadverto. Tunc voco dolor trucido terreo valeo. Speculum ducimus cur armarium vicinus ustulo patria caveo.\nCaelestis campana earum dens tactus curiositas alius nobis vorago dignissimos. Ver coniecto denique demoror valens. Astrum veritas conturbo tempora error audentia deprimo vos.\nTeneo aptus delectatio aetas at creptio. Studio spargo dicta defungo reprehenderit vinitor tepidus toties iusto amaritudo. Quae aequitas comes acceptus vomito comis verbera sto.	BLD2/FLR3	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841279/1699942841280.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841279/1699942841281.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841279/1699942841282.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841279/1699942841283.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841279/1699942841284.png	2023-11-14 06:20:41.486901	\N
APM1699942841490	St. Crytal	15	20	1	2	9000000	inactive	Absens conforto universe natus tepidus admoveo. Absum cubo patior adhuc. Curatio crudelis spiculum caelum arca unde.\nVinitor adnuo paulatim sordeo ager degusto copiose suppono. Absum adeptio repellendus admoveo auditor amaritudo aestivus cimentarius assumenda vado. Terra verecundia valens demitto admoveo censura surculus decretum arcus.\nFugiat excepturi tui praesentium spes celer. Concido vigilo corrumpo solum stips tutis tenuis angustus acies. Caries cura ademptio inventore quam.\nCur centum carmen. Condico aspicio amissio. Absens acies peccatus eveniet omnis et carus tenax sui.\nBeatae dapifer despecto suppono usque adipisci amiculum eius. Super cuppedia aedificium amaritudo stipes colligo. Pecus doloremque curtus aqua ab artificiose carus cras.	BLD2/FLR4	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841490/1699942841491.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841490/1699942841492.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841490/1699942841493.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841490/1699942841494.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841490/1699942841495.png	2023-11-14 06:20:41.689371	\N
APM1699942841693	St. Crytal	15	20	1	2	9000000	inactive	Crur subnecto vae brevis thymbra. Necessitatibus cinis saepe carmen peccatus cursim quisquam amor curtus damnatio. Dolores acidus curis.\nTimor tactus dens turbo. Amicitia ater vociferor cruciamentum pecco. Corrupti pectus celo viscus deorsum cibo varius totidem.\nTribuo assumenda depereo tabgo vehemens abutor caritas tamdiu cubitum. Convoco fuga cohibeo perspiciatis natus. Comburo aliqua agnosco arma.\nDerideo textor cibo. Sollicito supra tui acquiro et venustas. Antea universe delibero soluta curriculum in defaeco arma.	BLD2/FLR4	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841693/1699942841694.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841693/1699942841695.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841693/1699942841696.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841693/1699942841697.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841693/1699942841698.png	2023-11-14 06:20:41.900842	\N
APM1699942841904	St. Crytal	15	20	1	2	9000000	inactive	Desidero aegrotatio aetas. Certus appello approbo aeger audacia creta cresco distinctio solus. Fugiat civitas vulgus quaerat optio adhaero cito comburo vinculum.\nSortitus acquiro tamquam recusandae. Crebro aurum conatus caecus desino. Tametsi desipio aurum accusator adhuc utique ante vesica.\nAudeo sed villa triumphus argumentum collum. Acquiro verumtamen cupio tamdiu torqueo. Stella vereor sol abeo trucido confero alias.	BLD2/FLR4	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841904/1699942841905.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841904/1699942841906.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841904/1699942841907.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841904/1699942841908.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942841904/1699942841909.png	2023-11-14 06:20:42.162581	\N
APM1699942842175	St. Crytal	15	20	1	2	9000000	inactive	Ver spargo umbra abundans vulnus aequus ante aeternus cruentus. Celer utilis spes vulnus sublime caecus reiciendis deleniti auctus admitto. Acerbitas calcar comptus corrumpo.\nAttero certe ater thema terebro curiositas corona debitis vester. Video admitto sub totidem adhaero arceo. Acceptus dolore vetus quisquam ambitus numquam tubineus.\nAdiuvo varietas pauper confero timidus pecco denuo. Tersus curiositas capio. Vorax caveo altus corrigo consequatur vir terreo.\nReiciendis aliquid aranea curia apparatus arcesso. Cena depopulo tenetur timor. Cohors viridis acquiro derideo aspicio.\nAttero deputo colo. Cuius desino arma architecto aspicio vobis thesis campana a. Aqua surgo balbus confido curis temporibus.	BLD2/FLR4	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842175/1699942842176.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842175/1699942842178.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842175/1699942842179.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842175/1699942842180.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842175/1699942842181.png	2023-11-14 06:20:42.363813	\N
APM1699942842373	St. Crytal	15	20	1	2	9000000	inactive	Voco sui cinis cribro tergum. Adopto dapifer videlicet dolorum via volva. Celer comis tego.\nAliquid vorago admitto viduo ab dedecor vitae. Casus compono aestas accendo patrocinor ver. Argumentum debeo venia aut denuo cubicularis cubicularis.\nArmarium ut deprecator demoror condico spoliatio adiuvo. Stabilis tondeo totus terminatio odio conqueror cur somniculosus vaco. Ceno somnus solvo modi aranea correptius conturbo cicuta.	BLD2/FLR4	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842373/1699942842375.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842373/1699942842376.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842373/1699942842377.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842373/1699942842378.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842373/1699942842379.png	2023-11-14 06:20:42.554732	\N
APM1699942842559	St. Crytal	15	20	1	2	9000000	inactive	Tripudio aegre cras vesper curis tergum. Somniculosus desino quos civitas. Timor tandem totus.\nPectus spes peior utrum adstringo temporibus suppellex. Confero facere assentator. Approbo autus velit.\nTempore odio tametsi sequi cohibeo cohibeo annus apparatus. Defero concedo cavus inventore voluptatem. Curatio vito impedit.\nDemulceo traho bis urbanus esse alveus thermae urbanus claudeo. Succedo triumphus cilicium. Cattus vesica aestas solum accedo cogo assentator.\nUterque nemo alius deleo paulatim. Spiculum ut cedo cubo custodia cura volo dolorum aestivus. Confugo bellum deserunt tandem consequuntur summa.	BLD2/FLR4	BLD2	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842559/1699942842561.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842559/1699942842562.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842559/1699942842563.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842559/1699942842564.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842559/1699942842565.png	2023-11-14 06:20:42.744349	\N
APM1699942842753	St. Crytal	15	20	1	2	9000000	inactive	Uredo adstringo subnecto blandior eligendi summisse dens solus. Deputo voco beatae cado super animi occaecati canis. Vesica depono demulceo vicissitudo.\nAlter decens minima dicta verto ascit sordeo. Carus suspendo ver. Error demo quisquam speciosus collum claudeo surculus campana teneo consectetur.\nSupra torqueo conitor inventore crustulum defleo sto callide amor. Tergum molestiae quis cogo. Abduco vorago aqua cohaero timidus vulnero tactus.	BLD3/FLR0	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842753/1699942842755.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842753/1699942842756.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842753/1699942842757.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842753/1699942842758.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842753/1699942842759.png	2023-11-14 06:20:42.932361	\N
APM1699942842939	St. Crytal	15	20	1	2	9000000	inactive	Quisquam utrimque conqueror admitto necessitatibus. Illum id adsuesco substantia bonus cibus amiculum vociferor. Ducimus via urbanus arma subnecto atque urbs vos.\nSordeo cogo statua illo surgo deripio. Bellicus virtus succedo vox absconditus sonitus desipio. Centum cruentus adflicto adulatio tricesimus admitto brevis vacuus.\nUnde tenus tametsi comprehendo aegre adulatio delibero aggero. Vitium nisi teneo cohors super quidem aegrus vos. Correptius verbera desidero contigo decet vito suppono.\nCur sapiente conturbo quod statua. Conturbo antepono conventus hic thymbra et supra dens. Decerno dicta abstergo.\nConiuratio sum tamisium nam vere tubineus desparatus tergiversatio ipsam. Amet clementia cilicium. Thorax utilis rem patior ter.	BLD3/FLR0	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842939/1699942842940.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842939/1699942842941.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842939/1699942842942.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842939/1699942842943.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942842939/1699942842944.png	2023-11-14 06:20:43.134675	\N
APM1699942843147	St. Crytal	15	20	1	2	9000000	inactive	Pectus supplanto vereor trans. Ultio crudelis defungo. Tenetur argentum cicuta clarus neque corroboro amitto pauci quis.\nCollum creo copiose caveo canis. Tabernus vilicus caute calamitas amor molestiae. Tubineus tamisium solvo corrigo complectus cultellus artificiose tempore.\nUltra tenax amoveo utor trans repudiandae subnecto. Creta cursim absconditus cornu concedo aveho modi sint deinde. Tibi cervus stabilis consuasor excepturi accusamus adimpleo valetudo.\nCorreptius sursum error balbus nisi degenero coerceo tamquam. Centum stabilis suggero. Ventosus blanditiis curiositas conqueror truculenter coaegresco taedium aufero video antiquus.	BLD3/FLR0	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843147/1699942843162.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843147/1699942843163.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843147/1699942843164.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843147/1699942843165.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843147/1699942843166.png	2023-11-14 06:20:43.467624	\N
APM1699942843473	St. Crytal	15	20	1	2	9000000	inactive	In censura curis spero apparatus tunc. Adulescens architecto tepesco summisse officiis socius cubicularis. Nesciunt consuasor supellex.\nAsporto debitis aufero. Conitor denuncio vox confero confido cras una aliqua atrox crapula. Depulso testimonium adaugeo.\nDegenero amissio astrum. Umbra trans patruus bestia conculco confero tepesco carpo taceo. Suscipio voco cado vitiosus beneficium adulatio.	BLD3/FLR0	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843473/1699942843474.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843473/1699942843476.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843473/1699942843477.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843473/1699942843478.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843473/1699942843479.png	2023-11-14 06:20:43.732874	\N
APM1699942843737	St. Crytal	15	20	1	2	9000000	inactive	Volutabrum abundans vulnero sortitus. Admitto doloribus repellendus baiulus volup canonicus vitae eveniet tergeo solio. Cribro venio thalassinus.\nAqua claudeo deputo aro. Volo cohaero cuius aperte subito attollo suus crux. Denuo cupiditate volutabrum cavus vehemens.\nLaudantium thermae sequi. Damno nostrum tantillus urbanus urbanus thymum cetera vulticulus fugiat. Coadunatio avarus demonstro patrocinor exercitationem adstringo cultura amitto tabella subnecto.\nSubvenio depulso aetas. Cohors iure aiunt verto debilito recusandae conduco. Corroboro denique tubineus creber vitae voluptatibus delibero suppellex voluntarius substantia.\nAequus una eum. Provident adhuc tenus turbo. Vomito tempus stabilis tracto vinitor via claustrum.	BLD3/FLR0	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843737/1699942843738.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843737/1699942843739.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843737/1699942843740.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843737/1699942843741.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843737/1699942843742.png	2023-11-14 06:20:43.938996	\N
APM1699942843948	St. Crytal	15	20	1	2	9000000	inactive	Vesper cicuta sperno. Sollers pectus tabula quidem amaritudo via absque. Demum ipsum tumultus attonbitus alveus centum thymbra.\nCuria asporto ademptio uberrime concido vicinus urbs. Depono adfectus utpote aliqua laborum corrumpo. Vinculum sunt illo.\nTemperantia maiores est aestas titulus depraedor bellicus casso tribuo vaco. Callide asporto sublime tres. Videlicet cogito thorax facere similique adfectus.	BLD3/FLR0	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843948/1699942843948.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843948/1699942843950.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843948/1699942843951.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843948/1699942843952.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942843948/1699942843953.png	2023-11-14 06:20:44.157731	\N
APM1699942844191	St. Crytal	15	20	1	2	9000000	inactive	Apud volutabrum beneficium arguo quibusdam. Est annus claro vilitas corrigo corporis termes. Viriliter agnosco alienus atavus tantillus tamdiu tergeo porro.\nSaepe curto arcesso recusandae alioqui. Utroque ambitus balbus cuius traho curatio tui tamisium recusandae amoveo. Creptio desidero brevis cimentarius.\nAdvenio arbitro sono autem consectetur summisse contra. Aveho ademptio absum vergo est vester acidus civis textus sublime. Cras apud cornu reiciendis supplanto.\nVigilo cibus tersus varius aliquid vobis calamitas. Pauci conturbo admoveo vulariter nemo. Accusamus admoneo velut.	BLD3/FLR1	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844191/1699942844195.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844191/1699942844196.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844191/1699942844197.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844191/1699942844198.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844191/1699942844199.png	2023-11-14 06:20:44.362519	\N
APM1699942844365	St. Crytal	15	20	1	2	9000000	inactive	Tumultus aqua anser cito virga vulnero atrox. Utique umquam delectatio cedo coerceo tamdiu reiciendis. Umquam apostolus mollitia creber.\nNisi bonus balbus cunctatio votum ulterius cursus corporis vicinus. Acsi corrigo coepi conitor suppellex cimentarius amet alo. Curatio amoveo provident.\nAnte vulticulus succurro cetera. Condico conitor color titulus comedo tertius quia amicitia copiose neque. Bonus bellicus thymum temperantia sum excepturi deleo.	BLD3/FLR1	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844365/1699942844366.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844365/1699942844367.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844365/1699942844368.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844365/1699942844369.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844365/1699942844370.png	2023-11-14 06:20:44.538447	\N
APM1699942844546	St. Crytal	15	20	1	2	9000000	inactive	Bis denuo tardus synagoga dolor super beatae a. Ratione arma certe adhaero absque angulus. Confugo corona chirographum apparatus fuga brevis utroque assumenda adeo appello.\nDistinctio taedium apparatus contigo admitto vitiosus stultus benigne deleniti. Demergo speciosus tergo cura. Dolores quidem mollitia vita deleo thema.\nTaedium sonitus demitto ipsum cito clam. Valens abeo vito asper temporibus aestivus caelum attero. Audio tempora tam hic stipes viriliter vox ubi provident.\nVotum tenus ocer repudiandae cornu ex animus varius. Adfero absconditus civitas vallum deleo adfero undique correptius conitor. Ademptio astrum demens audeo tergum claudeo odio verbera via.	BLD3/FLR1	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844546/1699942844547.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844546/1699942844548.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844546/1699942844549.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844546/1699942844550.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844546/1699942844551.png	2023-11-14 06:20:44.741248	\N
APM1699942844744	St. Crytal	15	20	1	2	9000000	inactive	Deprimo explicabo asporto demulceo turba desipio. Sursum tergo sublime peccatus amita ultio stips arbustum. Vomica volup dedecor molestias adsidue commodi creo cruentus temperantia.\nCursim delego culpo. Viduo nostrum suppono accusamus antea depono. Despecto uredo non varius.\nUredo veritatis corporis victus sumo a ustulo cupressus quod aureus. Tamen consectetur velit. Sperno culpa vomito torqueo spoliatio celer astrum curatio defluo velut.\nAt vis paens commemoro. Approbo trucido templum decet venia thesis. Suscipio vorago traho aggredior ceno stips.	BLD3/FLR1	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844744/1699942844745.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844744/1699942844746.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844744/1699942844747.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844744/1699942844748.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844744/1699942844749.png	2023-11-14 06:20:44.910821	\N
APM1699942844914	St. Crytal	15	20	1	2	9000000	inactive	Est auctor officiis iusto vergo. Suffoco collum studio curiositas defaeco vallum. Tam ea temeritas aptus sono teres corpus soleo cibo.\nRepudiandae tabesco depono argumentum ver. Comptus acsi ante ciminatio vomito territo deludo amicitia eaque. Tener ocer curo defendo charisma.\nAestas curis timidus voluntarius cognomen porro amplitudo quam corrupti summa. Vulpes maxime adulatio. Amo vulticulus quas dolorem conatus carpo.\nVeritatis alienus asperiores pecus villa vis. Vis abstergo undique cervus color terreo. Theologus absum ver turbo.\nSustineo aufero cursim neque valens cornu assumenda textilis thesaurus. Quam ex asporto combibo cinis tantillus autus conqueror umquam curatio. Apto velit adstringo delego asperiores amoveo ago neque.	BLD3/FLR1	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844914/1699942844914.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844914/1699942844915.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844914/1699942844916.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844914/1699942844918.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942844914/1699942844919.png	2023-11-14 06:20:45.133598	\N
APM1699942845137	St. Crytal	15	20	1	2	9000000	inactive	Cena decet addo correptius quae spiritus. Urbs curvo torrens expedita arbor. Molestias laborum neque colo aspicio clam.\nCoepi vicinus corporis animi. Voluptate sumptus benevolentia atqui defaeco triduana. Depromo cum voluptatem deleo voluptatibus deprecator torqueo ut.\nAdversus tricesimus deleo. Timidus aetas admoneo. Tamdiu copiose celo communis ago.	BLD3/FLR1	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845137/1699942845138.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845137/1699942845139.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845137/1699942845140.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845137/1699942845141.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845137/1699942845142.png	2023-11-14 06:20:45.665806	\N
APM1699942845964	St. Crytal	15	20	1	2	9000000	inactive	Verbera confero nihil audentia xiphias cimentarius attero spero traho cetera. Abstergo audax ademptio praesentium pauci. Amicitia degero cunabula denique adduco desino depromo suggero aggero teneo.\nUtpote attollo terga stips cur cernuus. Tantum toties ager cui cultellus umerus confido terminatio comedo. Sollicito conscendo talus ultra possimus crinis claro demens summopere varietas.\nNumquam pecto aeneus. Tot desolo quia. Defungo dolores corrigo porro copiose solus tandem tergum.\nConscendo quod varius tot. Alienus exercitationem vilicus acervus tam desino uberrime vinco. Utpote succedo aliquid sequi ratione.	BLD3/FLR2	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845964/1699942845965.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845964/1699942845966.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845964/1699942845967.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845964/1699942846064.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942845964/1699942846065.png	2023-11-14 06:20:46.521816	\N
APM1699942846565	St. Crytal	15	20	1	2	9000000	inactive	Alioqui aestas vestrum nostrum traho arcus debeo vindico ait tyrannus. Cogo alveus admitto impedit neque voluntarius censura bellicus vesco hic. Libero crur admoneo calcar viridis pecto defetiscor.\nSubito voluptas stipes compono adnuo cilicium vallum canto unus. Denego ascit curia sperno absque. Stillicidium cernuus auctor desparatus clamo artificiose infit.\nVitae certus stips auditor solutio timor civis. Corrigo templum acervus auctor vulnus sed venio. Verecundia adversus vigilo demum blanditiis admiratio turba uxor ducimus umerus.\nSolio antea arbitro odio vomito. Repellat tubineus viscus angulus capio. Adopto turpis thalassinus conservo officia.	BLD3/FLR2	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846565/1699942846568.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846565/1699942846569.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846565/1699942846570.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846565/1699942846571.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846565/1699942846572.png	2023-11-14 06:20:46.758415	\N
APM1699942846823	St. Crytal	15	20	1	2	9000000	inactive	Adamo suscipio compono. Paens valetudo cupiditate villa stabilis deduco desipio turba tendo undique. Cruciamentum spectaculum corrumpo conturbo suscipit non vorax coniuratio teres cuppedia.\nTemplum vulgus triumphus. Confugo adfero conicio aegrus decerno alias. Corpus pariatur vilitas baiulus.\nSocius canonicus dignissimos eum defessus aliquid. Possimus quidem venia vacuus quae testimonium convoco thesaurus civitas tibi. Cras artificiose conturbo pecco traho aggero tergum.\nArticulus tabula commemoro ara arca candidus carcer placeat uter. Absum bestia bos cavus patria congregatio cogo natus ocer. Patrocinor quibusdam amplexus viridis compono sodalitas verbum spiritus corrupti.	BLD3/FLR2	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846823/1699942846827.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846823/1699942846828.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846823/1699942846829.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846823/1699942846830.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942846823/1699942846831.png	2023-11-14 06:20:47.103222	\N
APM1699942847140	St. Crytal	15	20	1	2	9000000	inactive	Validus deserunt ceno amo. Curto certe caelum. Vinum ulterius minima.\nVitiosus texo expedita subito aduro crustulum fuga cunctatio tantum. Peccatus pecus totidem cognomen creber cursus ager curis conforto. Ambitus trepide tamdiu nam curto id.\nLibero traho maxime causa carpo tergo reprehenderit. Terminatio in absum. Voluptatibus cubicularis caritas sustineo artificiose neque sublime cogito advenio.\nTabesco tubineus ait coerceo spiritus subseco. Adhaero caste paens terror una. Vulgo tremo censura nam acervus denego speciosus.	BLD3/FLR2	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847140/1699942847140.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847140/1699942847141.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847140/1699942847142.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847140/1699942847144.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847140/1699942847145.png	2023-11-14 06:20:47.42189	\N
APM1699942847443	St. Crytal	15	20	1	2	9000000	inactive	Ipsa sed cibo altus amissio amicitia clam bestia tricesimus. Desino aduro crur. Delicate vito vilicus demum aestas.\nConfido amissio tenuis addo thesaurus alii demonstro cibus argentum vivo. Astrum ipsum admoneo xiphias vilicus. Optio cui quidem cavus adhuc consequatur modi subito.\nCarbo depromo vox virga alveus aperio supplanto vulgaris adnuo calamitas. Sol concido ratione. Mollitia dens officiis condico baiulus suppono tolero alius audax.	BLD3/FLR2	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847443/1699942847447.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847443/1699942847448.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847443/1699942847449.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847443/1699942847450.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847443/1699942847451.png	2023-11-14 06:20:47.704707	\N
APM1699942847716	St. Crytal	15	20	1	2	9000000	inactive	Aestivus quasi advoco denego venia triumphus urbs tabernus. Nesciunt angelus possimus stillicidium umerus copiose vulnero. Curriculum magni volo aperio.\nDecerno cumque clibanus autus testimonium talio adfero caterva combibo verumtamen. Cresco suffragium deleniti. Termes celebrer corpus.\nCompello defetiscor conqueror certus vaco. Deorsum comprehendo deficio viriliter altus argumentum vaco. Defungo iure textus avaritia volutabrum ciminatio temperantia compono sunt adfero.	BLD3/FLR2	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847716/1699942847719.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847716/1699942847720.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847716/1699942847721.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847716/1699942847722.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847716/1699942847723.png	2023-11-14 06:20:47.955757	\N
APM1699942847960	St. Crytal	15	20	1	2	9000000	inactive	Tutamen aegre desidero abbas blanditiis sollers timidus statua. Curvo ager absum alioqui suscipio suspendo. Rem beatae comptus vitae agnitio conturbo absque natus clarus deputo.\nArma terebro vinculum minima auctus neque demens velut tempora. Temeritas utrum dignissimos sono speculum soleo vigilo ventosus animi. Totidem illo curto.\nTabula contra suffragium attero ventus acer tres. Termes conor saepe conduco vero tantum absorbeo reprehenderit pauci. Torrens amplitudo auditor charisma versus voluptatem abundans.	BLD3/FLR3	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847960/1699942847964.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847960/1699942847965.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847960/1699942847966.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847960/1699942847967.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942847960/1699942847968.png	2023-11-14 06:20:48.243762	\N
APM1699942848362	St. Crytal	15	20	1	2	9000000	inactive	Stultus solutio cedo vox ars arx. Depulso tibi speciosus terga circumvenio voluptas voluptate tego sto. Venio vigor ventito tutis quidem.\nQuod toties totidem decens curriculum bonus adamo. Decretum vinum auctus esse carbo molestiae sumptus. Deputo adstringo suppono dignissimos pecus texo optio ex.\nClibanus aurum canis dapifer adduco arbitro adiuvo dolorum. Defluo vomica iusto claudeo voluptas adficio. Terminatio autem cavus acsi subito pel molestias administratio vivo.\nAmiculum vulnero tres carbo alii. Vetus apud umerus stipes. Concido demulceo desino quaerat dolores deduco consuasor ratione thymum.\nCornu absorbeo curia videlicet. Cura adinventitias audentia titulus curia commodo aliquid vis clam terreo. Tondeo adimpleo adaugeo.	BLD3/FLR3	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848362/1699942848364.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848362/1699942848365.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848362/1699942848366.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848362/1699942848367.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848362/1699942848368.png	2023-11-14 06:20:48.532451	\N
APM1699942848536	St. Crytal	15	20	1	2	9000000	inactive	Agnitio subnecto vobis. Suus viduo somnus acies cuius demonstro peior solus adiuvo molestias. Thermae decor vicissitudo truculenter vox vinum vitiosus vulariter.\nPlaceat sopor laboriosam clarus appono. Strenuus spargo absum inventore amor subseco crux. Eius abduco defessus catena canonicus facilis damnatio officiis timidus.\nUtique vero quo ascit speciosus consequuntur suffoco spectaculum. Quasi audax succurro facilis desino quaerat catena. Depereo eligendi laborum utroque coadunatio defungo.\nAb utrimque dolorem aestus ventosus tenus aggero custodia aranea alias. Conturbo tonsor aut quis omnis corona. Sto colligo deputo aufero virgo complectus verto.	BLD3/FLR3	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848536/1699942848536.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848536/1699942848537.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848536/1699942848538.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848536/1699942848539.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848536/1699942848540.png	2023-11-14 06:20:48.738017	\N
APM1699942848743	St. Crytal	15	20	1	2	9000000	inactive	Angustus vitium utroque. Candidus asperiores temperantia sapiente. Blanditiis claro vulnus cauda verto utroque.\nAliqua laudantium tertius bellicus. Sum aeneus animadverto sit. Consequatur cohibeo turpis color aeternus abbas pauci paulatim.\nCenaculum auctus exercitationem absum spargo auctor. Sophismata cruentus tunc doloribus expedita solium inventore. Attero ratione degenero paulatim cursim sum theca vester.\nClibanus curvo nulla ex quaerat. Deficio cohibeo dicta amoveo alius corroboro. Peccatus terga sursum tutis suus accommodo.	BLD3/FLR3	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848743/1699942848744.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848743/1699942848745.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848743/1699942848746.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848743/1699942848747.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848743/1699942848748.png	2023-11-14 06:20:48.923307	\N
APM1699942848928	St. Crytal	15	20	1	2	9000000	inactive	Color annus advoco ultio vinco avarus demo. Cubitum bonus substantia coruscus somnus. Stillicidium caste sperno terga caelum.\nClam capio adicio toties. Conculco adficio pecus vigor. Nesciunt vespillo curia vehemens comparo.\nAperio iusto cornu tumultus illo defleo. Succedo utroque clamo aqua conventus denuo. Vae placeat sub tempora subseco arbustum cernuus possimus suscipio.	BLD3/FLR3	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848928/1699942848929.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848928/1699942848930.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848928/1699942848931.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848928/1699942848932.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942848928/1699942848933.png	2023-11-14 06:20:49.097039	\N
APM1699942849109	St. Crytal	15	20	1	2	9000000	inactive	Teres autus calcar sufficio cursus aetas ver. Peior vociferor vallum defessus. Esse aegrotatio cupiditate creator amor aliqua careo.\nSperno terga stabilis carbo. Suffoco explicabo ventito quam velum. Conduco virga solum ad soleo statua creptio patria sonitus vere.\nVerecundia certus contabesco consectetur. Voveo ambulo rem alveus. Alioqui statua averto volutabrum defluo.	BLD3/FLR3	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849109/1699942849111.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849109/1699942849112.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849109/1699942849113.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849109/1699942849114.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849109/1699942849115.png	2023-11-14 06:20:49.30693	\N
APM1699942849316	St. Crytal	15	20	1	2	9000000	inactive	Alias tener credo cruentus cras. Allatus spargo aeger undique. Cupressus debitis pecco suadeo recusandae carcer stips.\nAssumenda velociter virga soleo deduco delego cura. Terror vis subvenio debitis voluptatem comparo clibanus verecundia umbra subseco. Perspiciatis suadeo derelinquo usitas sumptus ubi speculum.\nAcervus convoco tandem audax videlicet. Pecco minima patrocinor concido explicabo. Desino curvo copiose calculus canonicus deserunt.\nItaque tamquam cohors sperno canto. Contigo benigne vos vesco vomito laborum super vesper substantia. Admitto deripio sortitus cultura tardus tantum testimonium aestivus ullam tenuis.	BLD3/FLR4	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849316/1699942849319.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849316/1699942849320.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849316/1699942849321.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849316/1699942849322.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849316/1699942849323.png	2023-11-14 06:20:49.489403	\N
APM1699942849576	St. Crytal	15	20	1	2	9000000	inactive	Vereor comptus vilicus cura beneficium adhaero. Amitto viduo numquam sequi strues aspicio. Benevolentia cohibeo aqua debeo arbitro verto.\nVirgo altus vesica decor succurro ventus ipsa deinde doloribus administratio. Admiratio tot tergo corona. Voco aequus aetas vero degero trans tunc causa tracto.\nViscus absorbeo provident. Subito angelus degero paulatim defessus contego aliquid. Defleo varius demonstro creo spiculum trado ducimus inflammatio.\nTunc vigilo subseco voluptas volo. Ustilo succurro comptus crepusculum suscipit speciosus. Viriliter cogito caritas maxime advenio curso aequitas desidero.\nSpeciosus decipio aegrus dolores nesciunt solutio numquam patria vulticulus. Spero supra allatus sed absens curso absconditus. Causa validus ademptio ventus tergum demergo pectus chirographum audentia.	BLD3/FLR4	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849576/1699942849577.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849576/1699942849578.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849576/1699942849579.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849576/1699942849581.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849576/1699942849582.png	2023-11-14 06:20:49.832505	\N
APM1699942849836	St. Crytal	15	20	1	2	9000000	inactive	Soluta thermae varietas. Cena corrumpo ullus auctus conscendo apto. Tenuis aspicio tribuo velum caterva stella animus subito aedificium verecundia.\nArmarium absens incidunt audentia tunc asperiores. Eum adimpleo thalassinus vulgaris suscipio approbo copia quisquam. Cognomen alter enim colo voluptatem.\nQuibusdam brevis eaque. Consectetur arguo audeo ducimus facere. Vulnus volubilis tumultus.	BLD3/FLR4	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849836/1699942849837.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849836/1699942849838.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849836/1699942849839.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849836/1699942849840.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942849836/1699942849841.png	2023-11-14 06:20:50.086619	\N
APM1699942850089	St. Crytal	15	20	1	2	9000000	inactive	Consequuntur non uberrime maiores cicuta thesis. Assentator placeat vel sint sub sum. Usque viridis centum alienus.\nTemptatio velum quod avaritia degero aggredior dolores. Tribuo delicate angustus conservo aptus vehemens ara maiores surgo concido. Tremo ipsum adflicto.\nSolium brevis distinctio testimonium vindico tot suffoco. Terra careo vorago demum aperte cui. Virga artificiose tener coma ademptio aurum thymbra vir corona.\nQuaerat vulticulus tergo ademptio animus accusamus audentia varius. Cogo conforto aer demo adaugeo. Impedit bonus aliqua amplitudo termes curriculum adsum.\nSuadeo depono tollo ager peccatus summisse. Impedit socius adulescens vesica beatae cunctatio despecto tergo. Pauper totam voluptatum versus auctus ultra somniculosus desipio soluta candidus.	BLD3/FLR4	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850089/1699942850090.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850089/1699942850091.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850089/1699942850092.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850089/1699942850093.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850089/1699942850094.png	2023-11-14 06:20:50.278472	\N
APM1699942850286	St. Crytal	15	20	1	2	9000000	inactive	Curiositas inflammatio soluta bis amplitudo crur. Administratio tam socius vulnero ubi solvo accusamus commodo addo solitudo. Delectus adaugeo spoliatio campana cetera crustulum.\nDoloribus error valetudo thesaurus templum vere tersus. Damno cetera alienus. Vicinus capillus aspicio toties.\nSummisse similique capillus dicta ascisco somniculosus. Volaticus ascit vomica clam defessus testimonium vetus facere crepusculum. Temporibus vulgivagus temeritas ambulo adipiscor patior coma vilitas.	BLD3/FLR4	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850286/1699942850288.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850286/1699942850289.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850286/1699942850290.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850286/1699942850291.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850286/1699942850292.png	2023-11-14 06:20:50.4842	\N
APM1699942850502	St. Crytal	15	20	1	2	9000000	inactive	Ceno cursus in autem tergiversatio summisse. Crinis summisse statua terga adaugeo spero deserunt corrupti caritas. Recusandae tutis aranea tolero ut.\nCohors corrumpo bene studio agnitio. Cunae depromo velum desipio communis accendo eaque. Accedo nemo hic curriculum.\nAmplexus cotidie ulciscor. Delectatio virtus clibanus tardus dolor tremo uredo. Depereo deorsum tertius amplitudo caterva.\nAcies acerbitas quo. Dolore nesciunt despecto capillus corporis tactus. Quis socius umquam.\nAudentia autus comptus ultra vesper arbitro avarus dolore concedo cedo. Admitto careo vulgivagus patior. Aperio sublime caste celo totus vito.	BLD3/FLR4	BLD3	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850502/1699942850506.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850502/1699942850507.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850502/1699942850508.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850502/1699942850509.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850502/1699942850510.png	2023-11-14 06:20:50.769099	\N
APM1699942850775	St. Crytal	15	20	1	2	9000000	inactive	Stips enim tergiversatio veniam testimonium. Theca caveo sed consequatur soluta spargo tabgo tergiversatio sponte. Congregatio sponte acer.\nTitulus vitiosus aqua conatus attonbitus admoneo adamo decipio valetudo tersus. Dignissimos fugit decens veritas acer velum surculus civis civis utrimque. Capitulus thymum desipio.\nLaborum tenuis theca vaco maxime tabula nostrum derideo denuncio molestias. Cornu tabesco paens clam ultio color ustilo antepono spectaculum addo. Cohors pecto vitium acceptus caput curiositas vester ratione corporis.	BLD4/FLR0	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850775/1699942850776.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850775/1699942850777.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850775/1699942850779.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850775/1699942850780.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850775/1699942850781.png	2023-11-14 06:20:50.96624	\N
APM1699942850969	St. Crytal	15	20	1	2	9000000	inactive	Rerum solutio tergiversatio bardus verumtamen congregatio usitas vilis capitulus impedit. Spero currus turbo tremo auctor aeneus deludo. Trepide despecto aetas.\nCorpus tendo bos vitiosus. Curatio sublime soluta suscipit quidem conturbo toties vilicus. Arguo denego celer spectaculum cultura vomer tergum.\nNulla non creber. Truculenter doloremque tremo apostolus doloremque tollo cedo uter. Taceo cerno maxime capillus aspernatur clementia bos brevis quam.\nConfugo torrens cribro tamisium solutio cupio stella copia articulus. Aveho vaco unus adaugeo est vulariter campana suasoria. Ipsum ultio vociferor ab taceo sperno textor campana.\nDemulceo cunae id. Clamo copia id est coma considero. Patior basium quis antea.	BLD4/FLR0	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850969/1699942850970.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850969/1699942850971.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850969/1699942850972.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850969/1699942850973.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942850969/1699942850974.png	2023-11-14 06:20:51.163646	\N
APM1699942851167	St. Crytal	15	20	1	2	9000000	inactive	Versus crux atque itaque sordeo succedo. Thymum ipsa doloremque deinde ipsam defluo pectus aperiam viridis corroboro. Bibo abduco arx collum celer ambulo abeo.\nAbeo ultra vomito. Verumtamen perspiciatis aggredior deludo natus arcesso dolor umerus. Sordeo aeternus talio.\nAdicio vesica dedico. Triduana tonsor abbas vilicus. Cognomen cerno debeo arca alii caritas cupio.\nCapto ultra accusator. Astrum civitas amissio numquam dolores caelestis admoveo vomer crustulum pariatur. Sustineo arbustum abscido amplitudo.	BLD4/FLR0	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851167/1699942851168.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851167/1699942851169.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851167/1699942851170.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851167/1699942851171.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851167/1699942851172.png	2023-11-14 06:20:51.44412	\N
APM1699942851446	St. Crytal	15	20	1	2	9000000	inactive	Apostolus vulgivagus adversus cognomen uredo advenio virga cubicularis. Correptius pax consequatur candidus vulgaris magni vero vivo capillus. Vester capto demitto decimus ex turba suscipit deprecator.\nAgo arx adicio adopto eos vulgivagus. Minima delectus verumtamen vulticulus conspergo tyrannus. Voluntarius umquam sufficio minima universe admitto adimpleo suspendo.\nIllum bene voluptates modi. Aestivus laborum urbs verus. Terror spiritus teneo trans.\nCasso expedita uxor annus caelestis tollo explicabo creta alienus vociferor. Depulso videlicet magni vindico. Aetas adimpleo vulnus tero adflicto coerceo.	BLD4/FLR0	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851446/1699942851447.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851446/1699942851448.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851446/1699942851449.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851446/1699942851450.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851446/1699942851451.png	2023-11-14 06:20:51.63463	\N
APM1699942851637	St. Crytal	15	20	1	2	9000000	inactive	Demo aegrotatio uter deduco molestiae expedita triduana clamo. Derideo advoco tergeo tabesco volaticus vaco apostolus centum audeo ambulo. Virga advoco cubo adficio assumenda speculum arbor deporto.\nAetas umbra sono vinco crinis adaugeo argumentum abduco. Vulnero suppellex suggero totam carbo vestigium thalassinus possimus. Artificiose cernuus blandior spectaculum degenero.\nDerideo confero curvo utrum. Aggero suus nihil clibanus coma. Voluptatum comprehendo timidus illum neque.\nVorago caterva depulso accusamus anser suus argentum. Demens depromo crinis curiositas volubilis caveo. Aperiam attonbitus suasoria peior.\nDecretum cum theatrum defleo. Vado tenetur dolores turpis vapulus comprehendo causa sortitus. Tertius vesper apostolus cetera.	BLD4/FLR0	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851637/1699942851638.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851637/1699942851639.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851637/1699942851640.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851637/1699942851641.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851637/1699942851642.png	2023-11-14 06:20:51.912161	\N
APM1699942851915	St. Crytal	15	20	1	2	9000000	inactive	Cribro vinum adsum arcesso tres comptus. Temptatio carcer tristis clam arcesso ab vulnero verumtamen. Aestus summisse adeptio vinum celo sperno praesentium.\nAperio debeo ceno dedico harum aliquid pecto truculenter universe tyrannus. Centum theologus alius dolorum tres. Crepusculum vestigium studio utrimque absorbeo comparo.\nAddo aspernatur tabesco ars caute dicta architecto. Studio crinis aeternus iusto vox paens fugit tabella suscipit vomica. Vel sophismata avarus tricesimus delinquo vallum casso.\nNam ubi peccatus verto creptio. Adipisci theca angustus sto cubo clamo odio. Usus tot voluptatibus.	BLD4/FLR0	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851915/1699942851916.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851915/1699942851917.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851915/1699942851918.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851915/1699942851919.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942851915/1699942851920.png	2023-11-14 06:20:52.202693	\N
APM1699942852206	St. Crytal	15	20	1	2	9000000	inactive	Comptus thermae soluta defaeco tracto ea temeritas vergo demo tristis. Sollicito arma officiis delinquo ultra cresco. Caries deripio voluptate spoliatio.\nSordeo commodo adicio exercitationem ara. Corrigo combibo cohibeo statua sortitus ancilla confido sono cotidie. Quod corporis vigor tot color ea.\nContego sunt admoveo supra synagoga capto bos bellicus valetudo. Voluptatibus adstringo quo bibo sono contego animadverto aeneus decumbo. Sum aro validus peccatus iusto solus.\nAccedo vobis adfero celebrer. Cursus tremo auxilium spectaculum sustineo. Casso statim blanditiis virtus delibero circumvenio deprimo.	BLD4/FLR1	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852206/1699942852207.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852206/1699942852208.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852206/1699942852209.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852206/1699942852210.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852206/1699942852211.png	2023-11-14 06:20:52.401782	\N
APM1699942852439	St. Crytal	15	20	1	2	9000000	inactive	Arcus summisse viduo tracto comprehendo vitium. Conduco aptus abutor. Creber abscido ulciscor velociter audacia spectaculum tenuis volutabrum decretum talus.\nBrevis amissio xiphias. A arto campana terga labore adiuvo temperantia. Cedo sint adhaero thesis damno.\nCurvo talis earum curia quidem copia quis porro. Torrens vester certus tamisium canonicus coadunatio cogo ver. Tametsi carmen cariosus temporibus adsidue vehemens bardus torqueo conitor doloribus.	BLD4/FLR1	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852439/1699942852461.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852439/1699942852462.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852439/1699942852463.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852439/1699942852464.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852439/1699942852465.png	2023-11-14 06:20:52.658135	\N
APM1699942852666	St. Crytal	15	20	1	2	9000000	inactive	Maiores blandior adeptio cito atque solvo. Canis peccatus ea aetas asporto. Arceo subvenio attollo civis bene ex dolorem delectus.\nCaste dignissimos facilis sit aufero venio voluptate. Abduco caries paens. Asperiores cultura casus tubineus ascisco.\nDelibero cresco cauda. Abeo depopulo tertius solum deficio acer tendo. Calco ea stipes vulticulus crustulum aliquid calcar sunt.\nClementia voluptatum decens tumultus corporis coepi sono distinctio centum. Aedificium saepe cornu. Occaecati commodi altus condico creptio.\nCatena sum aperio credo umerus cedo vado nesciunt. Defendo somnus animi non. Repellendus auxilium adulatio defetiscor quis stipes quos.	BLD4/FLR1	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852666/1699942852667.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852666/1699942852668.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852666/1699942852669.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852666/1699942852670.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852666/1699942852671.png	2023-11-14 06:20:52.968346	\N
APM1699942852981	St. Crytal	15	20	1	2	9000000	inactive	Vulariter adamo ipsa demulceo dolores spes. Capitulus itaque curvo acceptus conventus quaerat corporis ustulo volo. Complectus sto deficio.\nApprobo suspendo decipio patruus. Appono provident cum subito cribro ciminatio. Studio uberrime vapulus beatus sollicito conitor tabesco totam sperno enim.\nXiphias adipisci eius vinitor desino. Suscipit cruentus aveho. Cohaero comparo crebro surculus uxor soluta coerceo calculus cicuta somnus.\nVesica quaerat capillus ab concido tunc comprehendo amissio abeo necessitatibus. Cariosus color sunt decens. Amissio compello synagoga ater sequi armarium suasoria absconditus stipes necessitatibus.\nModi aegre spes advenio. Caute altus solium ultra conservo tumultus pel xiphias magnam attero. Libero soleo veritatis sufficio utilis quia.	BLD4/FLR1	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852981/1699942852991.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852981/1699942852992.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852981/1699942852993.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852981/1699942852994.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942852981/1699942852995.png	2023-11-14 06:20:53.172354	\N
APM1699942853184	St. Crytal	15	20	1	2	9000000	inactive	Quis tabella aeger. Cura aeger apostolus exercitationem tabella bellum cariosus creo animi depereo. Demonstro cognomen cohors voco consectetur virga cibus capio volubilis denuncio.\nCras carus callide volo quos vulticulus demergo. Video decens id vulticulus degenero ultra. Cunabula solutio debitis atque.\nDepraedor causa sordeo tabgo nostrum verbum. Sum victoria defendo adinventitias venustas abbas curatio viduo conqueror. Admoveo facere atqui aetas urbs.\nCornu currus delicate convoco. Cras vergo calco. Ascit cuppedia sopor mollitia calco alo arto arma amicitia.	BLD4/FLR1	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853184/1699942853186.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853184/1699942853187.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853184/1699942853188.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853184/1699942853189.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853184/1699942853190.png	2023-11-14 06:20:53.38454	\N
APM1699942853392	St. Crytal	15	20	1	2	9000000	inactive	Ciminatio demum sequi templum cupressus attollo timor auxilium adulescens. Depopulo demulceo aliqua adversus. Adimpleo pectus adnuo tergo.\nDefluo tracto quia verbera vorax solus verecundia tabernus cura aliquam. Cupiditas praesentium cum asporto copia ter abundans. Confido vociferor antea ascisco consuasor quo adflicto deporto color aegre.\nDefetiscor nostrum terminatio conforto basium usitas inflammatio. Tam exercitationem admoveo. Tersus vae caveo architecto corrumpo conturbo torqueo.	BLD4/FLR1	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853392/1699942853395.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853392/1699942853396.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853392/1699942853397.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853392/1699942853398.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853392/1699942853399.png	2023-11-14 06:20:53.628356	\N
APM1699942853643	St. Crytal	15	20	1	2	9000000	inactive	Coepi at arbustum bonus. Beneficium aut officiis vito baiulus correptius porro veniam creptio. Subnecto suffoco pecus.\nAvaritia vulariter amicitia spero vix strues debeo. Varietas temeritas sursum fuga commemoro excepturi sit verus calamitas soluta. Atavus corrumpo angustus advoco.\nTorqueo tyrannus deleniti doloribus arceo usitas consectetur video. Arcus asperiores conturbo casus. Tabgo admoveo dolores.	BLD4/FLR2	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853643/1699942853647.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853643/1699942853648.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853643/1699942853649.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853643/1699942853650.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853643/1699942853651.png	2023-11-14 06:20:53.849084	\N
APM1699942853853	St. Crytal	15	20	1	2	9000000	inactive	Ager ceno confero. Pectus vulticulus artificiose ad admiratio infit vigilo. Somniculosus certe vulgus suggero adopto.\nAmissio distinctio audeo aiunt cubo ait tamquam odit abstergo. Soluta occaecati venustas crapula stella adamo utrum sollicito vallum. Aureus paens collum.\nValetudo blanditiis amplus veritas trado tantillus sed magnam curto quas. Villa subnecto vulgo voluptas comminor baiulus cognatus usque doloribus. Valde supellex aptus debilito adaugeo solus.\nAdipiscor suspendo statua suppellex caelestis bellum allatus sto. Atavus expedita sustineo pecto consuasor demoror cometes verbera. Utrimque cotidie vorago quae cavus admoveo.	BLD4/FLR2	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853853/1699942853859.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853853/1699942853860.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853853/1699942853861.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853853/1699942853862.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942853853/1699942853863.png	2023-11-14 06:20:54.047064	\N
APM1699942854050	St. Crytal	15	20	1	2	9000000	inactive	Sublime deprimo vulpes conturbo volaticus. Socius surgo in sono. Decet appello velum.\nArticulus timor delibero. Conspergo asper tamen suasoria adimpleo cetera desparatus vulticulus barba aspernatur. Asperiores socius solio aptus.\nPeccatus stultus depraedor. Cometes defleo cado. Timidus suppellex villa articulus victoria tamdiu balbus aggredior coma unus.\nCrapula adhaero cenaculum. Porro ratione carbo. Succedo sulum atavus depraedor auctus.\nClaudeo adfectus ustulo depulso cupiditas ad. Uter desolo repellendus clibanus denuo deleo sunt. Reiciendis attonbitus cinis.	BLD4/FLR2	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854050/1699942854051.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854050/1699942854052.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854050/1699942854053.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854050/1699942854054.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854050/1699942854055.png	2023-11-14 06:20:54.290723	\N
APM1699942854294	St. Crytal	15	20	1	2	9000000	inactive	Iste theatrum quis aqua amo vallum conduco. Depromo sol aperio aetas pel crapula iusto avaritia dolorum. Tabella tribuo verto.\nVix sumo crur ago paulatim sufficio. Sulum conspergo calculus accendo volva coerceo repudiandae vir beatae averto. Saepe adicio adopto eveniet nostrum.\nVoluptas caecus taceo demulceo defendo cohaero. Tertius arma theologus crux unde vetus curatio candidus subseco. Speciosus demergo umquam congregatio quam tergeo possimus vesper derideo.\nUmquam civis peior. Solus virgo canis tunc acceptus censura dedecor. Debitis demo angustus inflammatio.	BLD4/FLR2	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854294/1699942854295.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854294/1699942854296.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854294/1699942854297.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854294/1699942854298.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854294/1699942854299.png	2023-11-14 06:20:54.467143	\N
APM1699942854470	St. Crytal	15	20	1	2	9000000	inactive	Callide suasoria unus ipsa conduco. Argumentum tenuis credo. Clarus atque vulgivagus tenax.\nCetera vae thorax tabesco contego degenero vigor adipisci inflammatio aspernatur. Ratione contego tactus desidero vivo argumentum attero substantia quae. Sufficio torrens animi utique venia catena celer.\nSodalitas pauper valetudo civis deleo advenio vapulus dedecor denique perspiciatis. Vereor ait altus spero. Supplanto sollicito aiunt tergeo.\nUniverse sequi attonbitus vulnus. Unde vinco calculus consectetur stella voluptatum casso varius. Vapulus saepe sum consequuntur vomica.	BLD4/FLR2	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854470/1699942854475.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854470/1699942854476.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854470/1699942854477.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854470/1699942854478.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854470/1699942854479.png	2023-11-14 06:20:54.656414	\N
APM1699942854659	St. Crytal	15	20	1	2	9000000	inactive	Vitium culpa defessus tego stabilis denique. Video quisquam coaegresco cunctatio atqui. Defungo delectus odio attonbitus apto.\nArceo careo cultura pecco. Cum aqua vomer avarus. Velum auctus decor adfero possimus versus.\nCorroboro succurro damnatio vetus. Combibo viridis terreo cursus demo conicio cito tremo deorsum corrupti. Inflammatio damno valens tenuis vomer quod acceptus vallum.	BLD4/FLR2	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854659/1699942854660.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854659/1699942854661.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854659/1699942854662.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854659/1699942854663.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854659/1699942854664.png	2023-11-14 06:20:54.852727	\N
APM1699942854857	St. Crytal	15	20	1	2	9000000	inactive	Aspernatur spiculum qui amita harum temperantia nostrum attero. Video valeo vespillo modi ab. Sustineo dolorum audio.\nAegrotatio adeptio crinis dedico coaegresco amitto. Deporto ventito modi alter quos cursus usus coniecto tremo. Defleo sophismata tum curriculum minus adduco quas adinventitias corrumpo.\nAuditor canis ascisco. Cubicularis ager culpa supellex strenuus. Summisse consectetur desino fugit solvo.	BLD4/FLR3	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854857/1699942854859.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854857/1699942854860.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854857/1699942854861.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854857/1699942854862.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942854857/1699942854863.png	2023-11-14 06:20:55.4648	\N
APM1699942855662	St. Crytal	15	20	1	2	9000000	inactive	Consuasor unus aegrus aetas ultra maiores somniculosus vicinus eveniet. Absorbeo assumenda desolo. Aurum carus calcar ubi terreo adeptio alii decor.\nNeque laboriosam paulatim. Ater adimpleo decor ipsam voluntarius abduco laboriosam denique. Adimpleo sortitus fugit blanditiis umerus terror.\nStabilis acceptus autem adinventitias argumentum ascit vulpes vester cui. Non pariatur cerno deinde acsi iusto sollers defluo amo cuius. Arbustum accendo audax tepesco acies cibo copiose dedecor.\nTersus celebrer carmen. Vicinus deludo volva. Carpo volaticus audio basium velut combibo tabula.\nAcerbitas umquam adhaero tametsi subito varietas uberrime deprimo crinis. Angulus validus antea consequuntur cervus celebrer sui suspendo. Amitto unus demonstro amor allatus autus calco illum numquam sumptus.	BLD4/FLR3	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942855662/1699942855762.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942855662/1699942855763.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942855662/1699942855764.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942855662/1699942855765.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942855662/1699942855766.png	2023-11-14 06:20:56.375165	\N
APM1699942856391	St. Crytal	15	20	1	2	9000000	inactive	Deserunt supra asperiores autem. Defessus traho concido. Pauci voluptate earum corpus vetus cupressus.\nEius volo dolore nostrum spes tibi cinis. Voluptatum mollitia commemoro auxilium conicio celer sodalitas circumvenio teres defaeco. Voluntarius temeritas vacuus.\nCredo velociter incidunt triduana. Tergo dapifer alienus depulso molestias argentum vicinus. Desino quod beatae vomito stips attollo caput triumphus cernuus.	BLD4/FLR3	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856391/1699942856392.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856391/1699942856393.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856391/1699942856394.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856391/1699942856395.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856391/1699942856396.png	2023-11-14 06:20:56.611893	\N
APM1699942856627	St. Crytal	15	20	1	2	9000000	inactive	Tremo cruciamentum cumque. Synagoga talio theca natus quos. Usus ante curso curiositas et vitium angulus.\nDenego trado conqueror itaque thesaurus sulum. Tertius solutio soleo vigor. Ullus textor quia adfectus agnitio nisi debilito aliquam censura.\nVoco corrupti vorago ullam cubo tergeo architecto calculus. Comburo turpis derelinquo tactus. Abstergo velit amo vacuus solum tergeo aperiam vigor constans torrens.	BLD4/FLR3	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856627/1699942856629.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856627/1699942856630.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856627/1699942856631.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856627/1699942856632.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856627/1699942856633.png	2023-11-14 06:20:56.91109	\N
APM1699942856925	St. Crytal	15	20	1	2	9000000	inactive	Arceo chirographum uberrime ratione. Alo suggero possimus. Sonitus coniuratio vivo perspiciatis comptus tredecim ultio.\nDistinctio supra ciminatio tertius truculenter deduco vilis. Aeger audio sophismata quidem. Ea supplanto tui capio.\nConspergo commodi bardus casus unus ipsa cupiditate. Cresco texo demens. Infit terra soluta casus adversus amplitudo deinde.\nCapitulus vesper synagoga at allatus curso ustulo comminor. Tabula decerno causa certus eligendi decimus apostolus corporis nulla. Vado deduco circumvenio architecto nihil.\nPectus patria communis civis delicate vigilo tardus adaugeo timor abutor. Ubi creptio sed aperio caecus cimentarius tabula facilis taceo veritas. Coruscus adsum depono demo comminor villa capitulus fuga.	BLD4/FLR3	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856925/1699942856926.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856925/1699942856927.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856925/1699942856928.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856925/1699942856930.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942856925/1699942856931.png	2023-11-14 06:20:57.30313	\N
APM1699942857310	St. Crytal	15	20	1	2	9000000	inactive	Suasoria basium vestrum ventito turba teres. Acsi doloribus denique copiose maxime compono aranea possimus beneficium vulgaris. Temperantia ipsa despecto.\nOfficiis bene caterva adipisci caries demonstro supra vacuus tenax tergiversatio. Mollitia contego adduco audax conitor termes claustrum conturbo bibo. Subvenio adiuvo conventus nesciunt voluptatum numquam varietas uter.\nTotus auctor ademptio comprehendo cura non. Ver complectus crur. Advoco color valetudo velut socius stella cornu temporibus tabernus caelestis.	BLD4/FLR3	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857310/1699942857315.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857310/1699942857316.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857310/1699942857317.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857310/1699942857318.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857310/1699942857319.png	2023-11-14 06:20:57.50836	\N
APM1699942857512	St. Crytal	15	20	1	2	9000000	inactive	Carmen tum arcesso illo. Defendo argentum aperte nemo curriculum demens. Corona vergo abstergo contego undique theca vere facilis.\nCasus placeat trans creo. Admitto vereor statim. Ceno voveo viscus crapula corpus theologus.\nCoaegresco suspendo adhaero. Veritas speculum bellicus aiunt supra blanditiis aureus adaugeo armarium. Amoveo alioqui officiis.\nQuaerat truculenter asporto absconditus spiculum. Timidus volaticus denego tot. Currus aetas cras voluptates certe adhuc.	BLD4/FLR4	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857512/1699942857513.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857512/1699942857514.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857512/1699942857515.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857512/1699942857516.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857512/1699942857517.png	2023-11-14 06:20:57.674217	\N
APM1699942857703	St. Crytal	15	20	1	2	9000000	inactive	Quibusdam arbitro vitiosus reprehenderit appello animadverto conservo. Cumque desidero assumenda ait damno. Vulgo asperiores vilicus volva aut.\nAeneus stipes summa. Cado vox aspernatur rem cupiditas minus cenaculum tredecim viridis. Repellat thesis desino aeger coaegresco sequi.\nVociferor vicissitudo sumo amiculum virga. Absens utrimque aut a. Aspicio usitas teneo solum carmen pecus commodi.\nAtqui cito thymbra bestia textor impedit voluptates cruentus considero atavus. Barba ad adulatio nostrum. Cum ara quam animi conor.\nDepulso decipio utilis blandior dedico adinventitias suasoria. Cupiditas amplexus absum victus abduco officiis terror curriculum. Solvo vilicus sit viriliter suggero veniam vereor aqua.	BLD4/FLR4	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857703/1699942857706.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857703/1699942857707.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857703/1699942857708.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857703/1699942857709.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857703/1699942857710.png	2023-11-14 06:20:57.900362	\N
APM1699942857911	St. Crytal	15	20	1	2	9000000	inactive	Deinde abstergo animi. Aveho desino spoliatio creator crepusculum. Acervus sophismata autus conspergo infit crur talio caries voluptatibus.\nSpeciosus ustilo deleniti carmen viscus alienus ter vaco benevolentia cogito. Stipes iste sopor alter triumphus color. Addo utrum universe enim vis explicabo absens ademptio coadunatio thermae.\nAmiculum voluptates usus defungo tres dolores quidem ubi. Expedita supplanto urbs vivo conduco videlicet thesaurus. Cetera qui perferendis deporto doloribus.	BLD4/FLR4	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857911/1699942857911.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857911/1699942857912.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857911/1699942857913.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857911/1699942857914.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942857911/1699942857915.png	2023-11-14 06:20:58.105674	\N
APM1699942858108	St. Crytal	15	20	1	2	9000000	inactive	Cruentus comparo adicio. At ter trans deserunt sodalitas auxilium quibusdam vicinus delicate. Ventus viriliter sui varietas dolores.\nUsque anser iste deludo usque stultus subnecto. Dolorum caute virtus tabgo talus laborum antiquus quae amiculum. Amitto vinculum atrox terga adsidue decens tripudio soluta socius speciosus.\nPeior canto caries perspiciatis cogito. Sit vestrum credo vae vociferor cupio. Collum cresco tyrannus.\nVitae rem harum termes tondeo aeneus denuncio studio. Pecus versus subseco curvo nam in amicitia fugit appono. Deripio delicate ago traho cognomen adiuvo calco expedita.	BLD4/FLR4	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858108/1699942858109.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858108/1699942858110.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858108/1699942858111.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858108/1699942858112.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858108/1699942858113.png	2023-11-14 06:20:58.276396	\N
APM1699942858279	St. Crytal	15	20	1	2	9000000	inactive	Adinventitias audentia sperno ea confugo curis curiositas terga succurro. Tutis terga terror tum spoliatio aegre. Crustulum vox depraedor vomica supellex solus vorago apostolus.\nAsperiores dolor universe culpo ustilo. Ambitus curso texo. Peior vado inflammatio.\nConculco inventore quae. Cunae voluntarius triumphus. Depopulo patria combibo cicuta caveo eaque.\nAequus comes accusantium cohors usus repellendus. Accusator arto sublime acquiro abstergo quia. Adfectus ustulo despecto umbra.\nValeo clam aegrotatio currus maiores texo basium peccatus talus. Talis turpis coniecto ambulo aperte atque deinde demum numquam arto. Cibus vinitor delicate vir vado taedium spargo socius copia spiritus.	BLD4/FLR4	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858279/1699942858279.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858279/1699942858280.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858279/1699942858281.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858279/1699942858283.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858279/1699942858284.png	2023-11-14 06:20:58.478395	\N
APM1699942858481	St. Crytal	15	20	1	2	9000000	inactive	Concido commodo tertius terra usque tui creptio ars derelinquo. Vesica cursus cogo. Abundans crebro commodo angustus custodia depulso.\nDeserunt tredecim terga venia auditor cognatus asperiores non. Distinctio cruciamentum alioqui testimonium alii apud sono desino ciminatio delego. Valetudo congregatio sollers substantia ullam bestia inflammatio comes harum cibus.\nSubito mollitia admoveo. Stella deprimo ipsa. Comparo corporis spectaculum molestiae blanditiis.\nAlienus comprehendo trans minima. Toties cruentus itaque. Deficio corrigo strues suscipio cui soleo sumptus testimonium vitium.	BLD4/FLR4	BLD4	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858481/1699942858482.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858481/1699942858483.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858481/1699942858484.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858481/1699942858485.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1699942858481/1699942858486.png	2023-11-14 06:20:58.66444	\N
APM1698502960091	St. Crytal	15	20	1	2	9000000	inactive	Victus subito ancilla. Tego crebro iure summa velit defungo. Surculus comis victoria.\nStultus dolore aufero cibo. Eum umquam voluptatem sonitus eum urbanus ducimus ratione audax. Tristis tubineus degusto aptus amissio victoria taceo trado artificiose admoneo.\nCreta amaritudo volutabrum vir rem. Coruscus conqueror quo. Credo nam conventus desparatus contego.\nAter amplus contego adhuc labore. Abscido quaerat acervus corona dolore voro coepi bonus tardus placeat. Demo virgo sodalitas tergo commemoro usque deinde caecus.	BLD0/FLR0	BLD0	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1698502960091/1699942873613.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1698502960091/1699942873615.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1698502960091/1699942873616.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1698502960091/1699942873617.png,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/apartment/APM1698502960091/1699942873618.png	2023-11-14 06:21:13.999929	\N
\.


--
-- TOC entry 3299 (class 0 OID 23093)
-- Dependencies: 215
-- Data for Name: building; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.building (building_id, name, max_floor, address, deleted_at) FROM stdin;
BLD0	Building 0	0	945 Douglas Lakes	\N
BLD1	Building 1	0	5210 Zieme Overpass	\N
BLD2	Building 2	0	9108 Tobin Spur	\N
BLD3	Building 3	0	164 Garden Street	\N
BLD4	Building 4	0	5400 16th Street	\N
\.


--
-- TOC entry 3302 (class 0 OID 23133)
-- Dependencies: 218
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.contract (contract_id, resident_id, apartment_id, role, status, created_at, expire_at, deleted_at, "contract_with_signature_photo_URL", "previousContractContractId", "nextContractContractId") FROM stdin;
Contract1699942874005	RES123	APM1698502960091	rent	inactive	2023-11-14 06:21:14.010406	2030-01-01 00:00:00	\N	\N	\N	\N
\.


--
-- TOC entry 3307 (class 0 OID 23225)
-- Dependencies: 223
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.employee (id, activated_at, "profilePictureURL", created_at, deleted_at, "profileName", "profileDate_of_birth", "profileGender", "profileFront_identify_card_photo_url", "profileBack_identify_card_photo_url", "profilePhone_number") FROM stdin;
EMP1699987235361	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987235361/avatarURL.svg	2023-11-14 18:40:38.225772	2023-11-14 18:40:48.442648	Võ Thị Mỹ Lệ	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987235361/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987235361/back_identify_card_photo_URL.jpg	0326465555
EMP1699987656830	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987656830/avatarURL.svg	2023-11-14 18:47:38.034389	2023-11-14 18:48:24.080154	Võ Thị Mỹ Lệ	2203-02-03 00:00:00	female	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987656830/front_identify_card_photo_URL.png	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987656830/back_identify_card_photo_URL.png	0326465525
EMP1699987761795	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987761795/avatarURL.svg	2023-11-14 18:49:22.545625	2023-11-14 18:49:31.016415	Võ Thị Mỹ Lệ	2003-02-03 00:00:00	female	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987761795/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987761795/back_identify_card_photo_URL.jpg	0326465558
EMP1699987853051	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987853051/avatarURL.svg	2023-11-14 18:50:54.663363	2023-11-14 18:51:01.256395	Võ Thị Mỹ Lệ	2001-02-03 00:00:00	female	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987853051/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699987853051/back_identify_card_photo_URL.jpg	0326465599
EMP1699988101177	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988101177/avatarURL.svg	2023-11-14 18:55:03.066297	2023-11-14 18:55:10.091096	Võ Thị Mỹ L	2003-02-03 00:00:00	female	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988101177/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988101177/back_identify_card_photo_URL.jpg	0326465523
EMP1699988192594	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988192594/avatarURL.svg	2023-11-14 18:56:34.385318	2023-11-14 18:56:41.633613	Võ Thị Mỹ Lệ	2002-03-01 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988192594/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988192594/back_identify_card_photo_URL.jpg	0326465524
EMP1699988362314	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988362314/avatarURL.svg	2023-11-14 18:59:23.919659	2023-11-14 18:59:39.185579	Võ Thị Mỹ Lệ	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988362314/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988362314/back_identify_card_photo_URL.jpg	0326465564
EMP1699988496191	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988496191/avatarURL.svg	2023-11-14 19:01:37.217802	\N	Võ Thị Mỹ Lệ	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988496191/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988496191/back_identify_card_photo_URL.jpg	0326465512
EMP1700038260642	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700038260642/avatarURL.svg	2023-11-15 08:51:02.838708	\N	Tran Binh An	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700038260642/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700038260642/back_identify_card_photo_URL.jpg	0326645874
EMP1700064408660	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700064408660/avatarURL.svg	2023-11-15 16:06:50.928594	\N	Bui Cong Huy	2002-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700064408660/front_identify_card_photo_URL.png	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700064408660/back_identify_card_photo_URL.png	02998883475
EMP1700069356103	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700069356103/avatarURL.png	2023-11-15 17:29:18.88036	\N	Phan Dinh Hien	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700069356103/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700069356103/back_identify_card_photo_URL.jpg	0124586572
EMP1699988563308	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988563308/avatarURL.svg	2023-11-14 19:02:45.166147	\N	Bui Cong Trư	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988563308/front_identify_card_photo_URL.png	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699988563308/back_identify_card_photo_URL.png	0326465588
EMP1699975533561	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699975533561/avatarURL.svg	2023-11-14 15:25:35.730801	\N	DINH DAI	2002-03-02 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699975533561/front_identify_card_photo_URL.png	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1699975533561/back_identify_card_photo_URL.png	0326465531
EMP1700062712739	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700062712739/avatarURL.svg	2023-11-15 15:38:35.122444	2023-11-17 04:25:30.992723	Duong Cong	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700062712739/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700062712739/back_identify_card_photo_URL.jpg	0326455520
EMP1700129029576	\N	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700129029576/avatarURL.jpg	2023-11-16 10:03:53.712444	\N	LÊ QUÝ ĐÔN	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700129029576/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/employee/EMP1700129029576/back_identify_card_photo_URL.jpg	0145628765
\.


--
-- TOC entry 3311 (class 0 OID 23417)
-- Dependencies: 227
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.equipment (id, name, status, "imageURLs", description, apartment_id, floor_id, building_id, created_at, deleted_at) FROM stdin;
EQM1700148298576	Manh Test	AVAILABLE		Spiritus magni eos totus accusator vulariter fugit cariosus.	\N	\N	BLD0	2023-11-17 04:41:58.645819	\N
EQM1700148305869	Manh Test	AVAILABLE		Spiritus magni eos totus accusator vulariter fugit cariosus.	\N	\N	BLD0	2023-11-17 04:41:58.645819	\N
EQM1700148330382	Manh Test	AVAILABLE	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/equipment/EQM1700148330382/01700148330382	Spiritus magni eos totus accusator vulariter fugit cariosus.	\N	\N	BLD0	2023-11-17 04:41:58.645819	\N
\.


--
-- TOC entry 3300 (class 0 OID 23101)
-- Dependencies: 216
-- Data for Name: floor; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.floor (floor_id, name, building_id) FROM stdin;
BLD0/FLR0	Floor 0	BLD0
BLD0/FLR1	Floor 1	BLD0
BLD0/FLR2	Floor 2	BLD0
BLD0/FLR3	Floor 3	BLD0
BLD0/FLR4	Floor 4	BLD0
BLD1/FLR0	Floor 0	BLD1
BLD1/FLR1	Floor 1	BLD1
BLD1/FLR2	Floor 2	BLD1
BLD1/FLR3	Floor 3	BLD1
BLD1/FLR4	Floor 4	BLD1
BLD2/FLR0	Floor 0	BLD2
BLD2/FLR1	Floor 1	BLD2
BLD2/FLR2	Floor 2	BLD2
BLD2/FLR3	Floor 3	BLD2
BLD2/FLR4	Floor 4	BLD2
BLD3/FLR0	Floor 0	BLD3
BLD3/FLR1	Floor 1	BLD3
BLD3/FLR2	Floor 2	BLD3
BLD3/FLR3	Floor 3	BLD3
BLD3/FLR4	Floor 4	BLD3
BLD4/FLR0	Floor 0	BLD4
BLD4/FLR1	Floor 1	BLD4
BLD4/FLR2	Floor 2	BLD4
BLD4/FLR3	Floor 3	BLD4
BLD4/FLR4	Floor 4	BLD4
\.


--
-- TOC entry 3298 (class 0 OID 23081)
-- Dependencies: 214
-- Data for Name: manager; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.manager (id, created_at, deleted_at, "accountOwnerId", "profileName", "profileDate_of_birth", "profileGender", "profileFront_identify_card_photo_url", "profileBack_identify_card_photo_url", "profilePhone_number", "buildingBuildingId") FROM stdin;
MNG1699942814892	2023-11-14 06:20:15.691068	\N	MNG1699942814892	DEMO MANAGER	1999-01-01 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/admin/MNG1699942814892/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/admin/MNG1699942814892/backIdentifyPhoto.jpg	0677778787	\N
MNG1700062196082	2023-11-15 15:29:57.808442	\N	MNG1700062196082	Võ Công Bình	2023-11-29 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/manager/MNG1700062196082/front_identify_card_photo_URL.webp	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/manager/MNG1700062196082/back_identify_card_photo_URL.webp	12312131	BLD0
MNG1700099286773	2023-11-16 01:48:10.095553	\N	MNG1700099286773	Manh Ho Dinh	2023-11-16 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/manager/MNG1700099286773/front_identify_card_photo_URL.webp	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/manager/MNG1700099286773/back_identify_card_photo_URL.webp	0582192103	\N
\.


--
-- TOC entry 3303 (class 0 OID 23161)
-- Dependencies: 219
-- Data for Name: resident; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.resident (id, account_id, payment_info, stay_at_apartment_id, created_at, deleted_at, "accountOwnerId", "profileName", "profileDate_of_birth", "profileGender", "profileFront_identify_card_photo_url", "profileBack_identify_card_photo_url", "profilePhone_number") FROM stdin;
RES1699942814523	\N	\N	\N	2023-11-14 06:20:14.887893	\N	\N	Marlon Keebler	1996-08-21 03:51:30.88	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942814523/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942814523/backIdentifyPhoto.jpg	(981) 493-6968 x505
RESIDENT	\N	\N	\N	2023-11-14 06:20:17.317702	\N	RESIDENT	Dr. Clay Wiegand	1983-02-07 10:03:39.155	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RESIDENT/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RESIDENT/backIdentifyPhoto.jpg	1-570-405-1295 x166
RES1699942858667	\N	\N	\N	2023-11-14 06:20:58.938223	\N	\N	Ben Kohler	1994-07-19 15:16:04.889	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942858667/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942858667/backIdentifyPhoto.jpg	735.227.2716 x966
RES1699942858940	\N	\N	\N	2023-11-14 06:20:59.219245	\N	\N	Doyle Blick-Kertzmann	1996-07-22 13:19:53.71	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942858940/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942858940/backIdentifyPhoto.jpg	640-500-1289 x214
RES1699942859226	\N	\N	\N	2023-11-14 06:20:59.489162	\N	\N	Mr. Alton Kunde	1958-07-25 09:00:51.583	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942859226/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942859226/backIdentifyPhoto.jpg	631.553.3633
RES1699942859492	\N	\N	\N	2023-11-14 06:20:59.750179	\N	\N	Melody Dicki Sr.	1945-08-16 22:16:47.568	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942859492/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942859492/backIdentifyPhoto.jpg	1-864-976-8817 x383
RES1699942859752	\N	\N	\N	2023-11-14 06:21:00.076165	\N	\N	Joey Bailey	1993-05-17 21:41:06.421	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942859752/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942859752/backIdentifyPhoto.jpg	(785) 381-1857 x75018
RES1699942860077	\N	\N	\N	2023-11-14 06:21:00.386111	\N	\N	Cristina Huels	1999-02-20 19:33:23.841	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942860077/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942860077/backIdentifyPhoto.jpg	719-204-5881
RES1699942860387	\N	\N	\N	2023-11-14 06:21:00.68937	\N	\N	Francisco Wolf	1997-06-05 09:39:54.994	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942860387/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942860387/backIdentifyPhoto.jpg	(743) 658-0567 x33616
RES1699942860691	\N	\N	\N	2023-11-14 06:21:00.970799	\N	\N	Melvin Blanda	1959-09-01 09:25:24.402	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942860691/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942860691/backIdentifyPhoto.jpg	638.213.2398 x51710
RES1699942860972	\N	\N	\N	2023-11-14 06:21:01.291169	\N	\N	Doyle Olson V	1949-04-17 01:27:49.9	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942860972/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942860972/backIdentifyPhoto.jpg	(766) 217-0460
RES1699942861293	\N	\N	\N	2023-11-14 06:21:01.549742	\N	\N	Elizabeth Bednar	1992-09-16 19:46:14.825	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942861293/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942861293/backIdentifyPhoto.jpg	737-565-3811
RES1699942861551	\N	\N	\N	2023-11-14 06:21:01.795423	\N	\N	Jan Marks	1977-07-23 14:50:00.401	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942861551/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942861551/backIdentifyPhoto.jpg	1-450-304-1963
RES1699942861797	\N	\N	\N	2023-11-14 06:21:02.237622	\N	\N	Mr. Rufus Predovic	1977-10-05 16:44:32.384	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942861797/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942861797/backIdentifyPhoto.jpg	585-827-6668 x4519
RES1699942862243	\N	\N	\N	2023-11-14 06:21:02.520732	\N	\N	Rene McKenzie	1979-02-14 18:28:14.326	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942862243/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942862243/backIdentifyPhoto.jpg	1-857-683-1959 x71835
RES1699942862523	\N	\N	\N	2023-11-14 06:21:02.810464	\N	\N	Tracy McCullough	1988-10-10 04:14:42.129	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942862523/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942862523/backIdentifyPhoto.jpg	835.723.5880 x303
RES1699942862815	\N	\N	\N	2023-11-14 06:21:03.074577	\N	\N	Mrs. Shawna Jones	1985-09-22 13:27:50.977	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942862815/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942862815/backIdentifyPhoto.jpg	1-810-391-6826 x28081
RES1699942863078	\N	\N	\N	2023-11-14 06:21:03.322359	\N	\N	Dr. Vincent Gusikowski	1951-01-12 23:09:23.111	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942863078/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942863078/backIdentifyPhoto.jpg	(651) 203-2050 x054
RES1699942863324	\N	\N	\N	2023-11-14 06:21:03.561556	\N	\N	Silvia Hodkiewicz	1946-06-30 11:16:28.906	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942863324/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942863324/backIdentifyPhoto.jpg	(533) 790-5149
RES1699942863563	\N	\N	\N	2023-11-14 06:21:03.808235	\N	\N	Nathaniel Frami	1950-11-10 17:05:06.818	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942863563/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942863563/backIdentifyPhoto.jpg	(946) 776-7807
RES1699942863817	\N	\N	\N	2023-11-14 06:21:04.250762	\N	\N	Winston Reichel	1987-11-01 21:19:57.499	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942863817/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942863817/backIdentifyPhoto.jpg	(507) 931-2362
RES1699942864252	\N	\N	\N	2023-11-14 06:21:04.578952	\N	\N	Silvia Swift	1975-01-20 10:40:31.932	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942864252/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942864252/backIdentifyPhoto.jpg	413-930-2216
RES1699942864580	\N	\N	\N	2023-11-14 06:21:04.834201	\N	\N	Darin Halvorson	1975-09-27 04:56:55.23	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942864580/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942864580/backIdentifyPhoto.jpg	(874) 481-0051
RES1699942864835	\N	\N	\N	2023-11-14 06:21:05.090889	\N	\N	Betsy Lehner	1959-04-17 01:16:57.573	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942864835/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942864835/backIdentifyPhoto.jpg	906-906-0614 x5410
RES1699942865092	\N	\N	\N	2023-11-14 06:21:05.358903	\N	\N	Kimberly Ullrich	1997-12-06 15:18:46.573	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942865092/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942865092/backIdentifyPhoto.jpg	950.750.7940 x5684
RES1699942865365	\N	\N	\N	2023-11-14 06:21:05.640845	\N	\N	Pamela Volkman	1967-12-27 11:34:43.043	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942865365/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942865365/backIdentifyPhoto.jpg	1-782-946-2716 x5753
RES1699942865642	\N	\N	\N	2023-11-14 06:21:05.917003	\N	\N	Christian Grimes	1966-09-02 17:52:44.907	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942865642/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942865642/backIdentifyPhoto.jpg	475-686-0078 x1597
RES1699942865923	\N	\N	\N	2023-11-14 06:21:06.377335	\N	\N	Jesus Metz	1958-06-14 03:35:07.586	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942865923/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942865923/backIdentifyPhoto.jpg	1-575-861-0730 x90073
RES1699942866386	\N	\N	\N	2023-11-14 06:21:06.72193	\N	\N	Enrique Rosenbaum	2004-04-10 19:18:34.656	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942866386/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942866386/backIdentifyPhoto.jpg	(694) 959-9754 x448
RES1699942866748	\N	\N	\N	2023-11-14 06:21:07.015117	\N	\N	Sheldon Murazik	1974-08-18 01:59:12.942	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942866748/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942866748/backIdentifyPhoto.jpg	489.632.2492 x4813
RES1699942867050	\N	\N	\N	2023-11-14 06:21:07.318077	\N	\N	Lee Walker V	1998-08-20 21:33:33.674	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942867050/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942867050/backIdentifyPhoto.jpg	781.493.5705 x75277
RES1699942867331	\N	\N	\N	2023-11-14 06:21:07.60107	\N	\N	Kerry Gerlach Jr.	1946-07-31 14:35:58.396	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942867331/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942867331/backIdentifyPhoto.jpg	967-209-1803 x624
RES1699942867609	\N	\N	\N	2023-11-14 06:21:07.901696	\N	\N	Oscar Mohr V	1960-09-04 09:42:06.733	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942867609/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942867609/backIdentifyPhoto.jpg	937-644-8631 x8003
RES1699942867904	\N	\N	\N	2023-11-14 06:21:08.172881	\N	\N	Rene Senger	1962-04-22 16:27:52.026	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942867904/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942867904/backIdentifyPhoto.jpg	(309) 225-0781 x0746
RES1699942868179	\N	\N	\N	2023-11-14 06:21:08.472278	\N	\N	Ms. Debbie Renner	1987-06-04 15:48:26.785	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942868179/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942868179/backIdentifyPhoto.jpg	(847) 500-8137 x95050
RES1699942868474	\N	\N	\N	2023-11-14 06:21:08.755942	\N	\N	Hattie Olson DVM	2002-04-27 03:20:35.285	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942868474/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942868474/backIdentifyPhoto.jpg	273-839-4781 x3466
RES1699942868765	\N	\N	\N	2023-11-14 06:21:09.16837	\N	\N	Woodrow Blick	1953-08-27 16:37:30.669	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942868765/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942868765/backIdentifyPhoto.jpg	(238) 767-6681 x1887
RES1699942869180	\N	\N	\N	2023-11-14 06:21:09.474734	\N	\N	Kelley Rice I	1959-05-07 07:54:37.273	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942869180/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942869180/backIdentifyPhoto.jpg	426.748.2629 x643
RES1699942869479	\N	\N	\N	2023-11-14 06:21:09.748378	\N	\N	Jamie Gibson	1978-09-14 13:45:16.433	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942869479/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942869479/backIdentifyPhoto.jpg	(546) 857-8277
RES1699942869750	\N	\N	\N	2023-11-14 06:21:10.006721	\N	\N	Bonnie Sipes	1965-07-25 14:06:01.823	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942869750/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942869750/backIdentifyPhoto.jpg	773-528-0080 x37211
RES1699942870012	\N	\N	\N	2023-11-14 06:21:10.282351	\N	\N	Lorenzo Borer	1949-07-21 13:06:26.725	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942870012/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942870012/backIdentifyPhoto.jpg	(663) 795-7570 x90941
RES1699942870284	\N	\N	\N	2023-11-14 06:21:10.52436	\N	\N	Marion Tremblay	2004-02-19 05:08:11.753	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942870284/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942870284/backIdentifyPhoto.jpg	(902) 915-7450
RES1699942870533	\N	\N	\N	2023-11-14 06:21:10.816102	\N	\N	Melody Mraz	1978-04-26 15:48:16.365	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942870533/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942870533/backIdentifyPhoto.jpg	1-651-657-3364 x6315
RES1699942870818	\N	\N	\N	2023-11-14 06:21:11.098527	\N	\N	Ada Huels MD	1958-08-17 13:04:24.47	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942870818/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942870818/backIdentifyPhoto.jpg	1-384-304-8626 x6421
RES1699942871100	\N	\N	\N	2023-11-14 06:21:11.337403	\N	\N	Sidney Bednar	1997-02-17 14:12:23.553	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942871100/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942871100/backIdentifyPhoto.jpg	1-242-648-0534
RES1699942871339	\N	\N	\N	2023-11-14 06:21:11.611731	\N	\N	Fred Dietrich	1946-05-08 03:51:32.773	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942871339/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942871339/backIdentifyPhoto.jpg	936-605-9789 x435
RES1699942871620	\N	\N	\N	2023-11-14 06:21:11.917344	\N	\N	Janie Glover IV	1970-02-13 04:22:09.766	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942871620/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942871620/backIdentifyPhoto.jpg	1-840-808-9923 x0364
RES1699942871927	\N	\N	\N	2023-11-14 06:21:12.212401	\N	\N	Clarence Nikolaus	1987-08-02 04:52:34.13	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942871927/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942871927/backIdentifyPhoto.jpg	(624) 550-8403 x769
RES1699942872223	\N	\N	\N	2023-11-14 06:21:12.468872	\N	\N	Pedro Gleason	1987-04-10 00:55:58.669	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942872223/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942872223/backIdentifyPhoto.jpg	783-810-7555 x97574
RES123	\N	\N	\N	2023-11-14 06:21:13.604359	\N	\N	Dr. Laverne Conn	1999-01-24 07:56:08.956	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES123/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES123/backIdentifyPhoto.jpg	846-504-7533 x7076
RES1699942873039	\N	\N	APM1699942823757	2023-11-14 06:21:13.329823	\N	\N	Jason Konopelski	1990-04-16 06:41:31.535	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942873039/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942873039/backIdentifyPhoto.jpg	474-788-0096 x2646
RES1699991922415	\N	gkghk	\N	2023-11-14 19:58:46.272385	2023-11-14 19:58:54.356605	RES1699991922415	DINH DAI DUONG	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699991922415/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699991922415/back_identify_card_photo_URL.jpg	0326465520
RES1700037775145	\N	eq	\N	2023-11-15 08:42:57.324411	\N	RES1700037775145	DINH DAI DUON	2003-02-03 00:00:00	female	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700037775145/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700037775145/back_identify_card_photo_URL.jpg	0326465556
RES1700065500486	\N		\N	2023-11-15 16:25:03.334836	\N	\N	DINH DAI pDUONG	2003-02-03 00:00:00	female	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700065500486/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700065500486/back_identify_card_photo_URL.jpg	0326465589
RES1700065528385	\N		\N	2023-11-15 16:25:30.774085	\N	\N	DINH DAI pDUONG	2003-02-03 00:00:00	female	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700065528385/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700065528385/back_identify_card_photo_URL.jpg	0326465989
RES1700065672185	\N	gưegwe	\N	2023-11-15 16:27:54.111034	\N	RES1700065672185	Le Hong Phong qunag	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700065672185/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700065672185/back_identify_card_photo_URL.jpg	0326468989
RES1700037736717	\N		APM1699942821294	2023-11-15 08:42:18.436387	\N	\N	DINH DAI DUONG	2003-02-03 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700037736717/front_identify_card_photo_URL.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1700037736717/back_identify_card_photo_URL.jpg	0326465527
RES1699942872470	\N	\N	APM1699942821294	2023-11-14 06:21:12.790667	\N	\N	Salvador Volkman Sr.	1965-04-04 02:08:19.575	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942872470/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942872470/backIdentifyPhoto.jpg	1-905-272-8303 x0643
RES1699942872793	\N	\N	APM1699942821294	2023-11-14 06:21:13.037867	\N	\N	Shelia Strosin	1968-10-05 21:28:29.649	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942872793/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/resident/RES1699942872793/backIdentifyPhoto.jpg	898.632.8759 x76996
\.


--
-- TOC entry 3309 (class 0 OID 23242)
-- Dependencies: 225
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.service (service_id, name, description, "imageURLs", created_at, deleted_at) FROM stdin;
SER1699944725974	Example Service	Example Service		2023-11-14 06:52:05.990471	\N
SER1700063667357	Example Service 2	Example Service	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/service/SER1700063667357/1700063667508.webp,https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/service/SER1700063667357/1700063667508.webp	2023-11-15 15:54:28.06165	\N
\.


--
-- TOC entry 3308 (class 0 OID 23235)
-- Dependencies: 224
-- Data for Name: service_package; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.service_package (id, service_id, expired_date, per_unit_price, "serviceServiceId") FROM stdin;
\.


--
-- TOC entry 3305 (class 0 OID 23197)
-- Dependencies: 221
-- Data for Name: technician; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.technician (id, created_at, deleted_at, "accountOwnerId", "profileName", "profileDate_of_birth", "profileGender", "profileFront_identify_card_photo_url", "profileBack_identify_card_photo_url", "profilePhone_number") FROM stdin;
TEC1699942815695	2023-11-14 06:20:16.574072	\N	TEC1699942815695	DEMO TECHNICIAN	1999-01-01 00:00:00	male	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/admin/TEC1699942815695/frontIdentifyPhoto.jpg	https://yrvlexzxorbubqpvytkm.supabase.co/storage/v1/object/public/homeland/admin/TEC1699942815695/backIdentifyPhoto.jpg	0896666666
\.


--
-- TOC entry 3310 (class 0 OID 23366)
-- Dependencies: 226
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: homeland_db_user
--

COPY public.vehicle (license_plate, front_registration_photo_url, back_registration_photo_url, license_plate_photo_url, resident_id, status, id) FROM stdin;
\.


--
-- TOC entry 3091 (class 2606 OID 23100)
-- Name: building PK_03b4a92f4aaa6114958969b6a9c; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.building
    ADD CONSTRAINT "PK_03b4a92f4aaa6114958969b6a9c" PRIMARY KEY (building_id);


--
-- TOC entry 3137 (class 2606 OID 23424)
-- Name: equipment PK_0722e1b9d6eb19f5874c1678740; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT "PK_0722e1b9d6eb19f5874c1678740" PRIMARY KEY (id);


--
-- TOC entry 3129 (class 2606 OID 23241)
-- Name: service_package PK_1275e8aa6ef5b9cd78906ea53d3; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.service_package
    ADD CONSTRAINT "PK_1275e8aa6ef5b9cd78906ea53d3" PRIMARY KEY (id);


--
-- TOC entry 3133 (class 2606 OID 23396)
-- Name: vehicle PK_187fa17ba39d367e5604b3d1ec9; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT "PK_187fa17ba39d367e5604b3d1ec9" PRIMARY KEY (id);


--
-- TOC entry 3095 (class 2606 OID 23121)
-- Name: apartment PK_1b3223b3ffa6791f83b58951611; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.apartment
    ADD CONSTRAINT "PK_1b3223b3ffa6791f83b58951611" PRIMARY KEY (apartment_id);


--
-- TOC entry 3097 (class 2606 OID 23140)
-- Name: contract PK_2f25fae55a3bd80337501b310e3; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "PK_2f25fae55a3bd80337501b310e3" PRIMARY KEY (contract_id);


--
-- TOC entry 3125 (class 2606 OID 23232)
-- Name: employee PK_3c2bc72f03fd5abbbc5ac169498; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT "PK_3c2bc72f03fd5abbbc5ac169498" PRIMARY KEY (id);


--
-- TOC entry 3093 (class 2606 OID 23107)
-- Name: floor PK_45e4850aab53c1130ba72995e74; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.floor
    ADD CONSTRAINT "PK_45e4850aab53c1130ba72995e74" PRIMARY KEY (floor_id);


--
-- TOC entry 3115 (class 2606 OID 23204)
-- Name: technician PK_465640daf2153d02a5114c86e95; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.technician
    ADD CONSTRAINT "PK_465640daf2153d02a5114c86e95" PRIMARY KEY (id);


--
-- TOC entry 3131 (class 2606 OID 23249)
-- Name: service PK_48c5a0e13da2b2948fb7f3a0c4a; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT "PK_48c5a0e13da2b2948fb7f3a0c4a" PRIMARY KEY (service_id);


--
-- TOC entry 3121 (class 2606 OID 23216)
-- Name: account PK_7e86daab9d155ec4cc3fd654454; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT "PK_7e86daab9d155ec4cc3fd654454" PRIMARY KEY (owner_id);


--
-- TOC entry 3085 (class 2606 OID 23088)
-- Name: manager PK_b3ac840005ee4ed76a7f1c51d01; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "PK_b3ac840005ee4ed76a7f1c51d01" PRIMARY KEY (id);


--
-- TOC entry 3109 (class 2606 OID 23186)
-- Name: admin PK_e032310bcef831fb83101899b10; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "PK_e032310bcef831fb83101899b10" PRIMARY KEY (id);


--
-- TOC entry 3103 (class 2606 OID 23168)
-- Name: resident PK_f1a321823d6f69d0e348535fd37; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "PK_f1a321823d6f69d0e348535fd37" PRIMARY KEY (id);


--
-- TOC entry 3105 (class 2606 OID 23170)
-- Name: resident REL_0405db8663fd4529a487e3c032; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "REL_0405db8663fd4529a487e3c032" UNIQUE ("accountOwnerId");


--
-- TOC entry 3111 (class 2606 OID 23188)
-- Name: admin REL_7403ac47c3a65ad475bb9704fe; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "REL_7403ac47c3a65ad475bb9704fe" UNIQUE ("accountOwnerId");


--
-- TOC entry 3087 (class 2606 OID 23090)
-- Name: manager REL_766b0df54007cf8b91d659f8b0; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "REL_766b0df54007cf8b91d659f8b0" UNIQUE ("accountOwnerId");


--
-- TOC entry 3099 (class 2606 OID 23142)
-- Name: contract REL_95c24778f5158039a6fa8f8976; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "REL_95c24778f5158039a6fa8f8976" UNIQUE ("previousContractContractId");


--
-- TOC entry 3117 (class 2606 OID 23206)
-- Name: technician REL_a5cc9be700210211a07aad3f52; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.technician
    ADD CONSTRAINT "REL_a5cc9be700210211a07aad3f52" UNIQUE ("accountOwnerId");


--
-- TOC entry 3101 (class 2606 OID 23144)
-- Name: contract REL_f7838bbfaca1c13e5791e63520; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "REL_f7838bbfaca1c13e5791e63520" UNIQUE ("nextContractContractId");


--
-- TOC entry 3107 (class 2606 OID 23172)
-- Name: resident UQ_06b083ffda1f617880fbf602c99; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "UQ_06b083ffda1f617880fbf602c99" UNIQUE ("profilePhone_number");


--
-- TOC entry 3135 (class 2606 OID 23398)
-- Name: vehicle UQ_08f5ab49f428e2090a434623a86; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT "UQ_08f5ab49f428e2090a434623a86" UNIQUE (license_plate);


--
-- TOC entry 3089 (class 2606 OID 23092)
-- Name: manager UQ_0bf0cc7e84d95c46c051a57aa5a; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "UQ_0bf0cc7e84d95c46c051a57aa5a" UNIQUE ("profilePhone_number");


--
-- TOC entry 3123 (class 2606 OID 23218)
-- Name: account UQ_4c8f96ccf523e9a3faefd5bdd4c; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT "UQ_4c8f96ccf523e9a3faefd5bdd4c" UNIQUE (email);


--
-- TOC entry 3113 (class 2606 OID 23190)
-- Name: admin UQ_8d6044ea49c7363e7329737351b; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "UQ_8d6044ea49c7363e7329737351b" UNIQUE ("profilePhone_number");


--
-- TOC entry 3127 (class 2606 OID 23234)
-- Name: employee UQ_97bbfba3a57621a204f5874e6a3; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT "UQ_97bbfba3a57621a204f5874e6a3" UNIQUE ("profilePhone_number");


--
-- TOC entry 3119 (class 2606 OID 23208)
-- Name: technician UQ_d103b5bce8de1a3df32002c8c93; Type: CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.technician
    ADD CONSTRAINT "UQ_d103b5bce8de1a3df32002c8c93" UNIQUE ("profilePhone_number");


--
-- TOC entry 3147 (class 2606 OID 23300)
-- Name: resident FK_0405db8663fd4529a487e3c0327; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "FK_0405db8663fd4529a487e3c0327" FOREIGN KEY ("accountOwnerId") REFERENCES public.account(owner_id);


--
-- TOC entry 3140 (class 2606 OID 23260)
-- Name: floor FK_1565850c51d1cc30e896101fa77; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.floor
    ADD CONSTRAINT "FK_1565850c51d1cc30e896101fa77" FOREIGN KEY (building_id) REFERENCES public.building(building_id);


--
-- TOC entry 3153 (class 2606 OID 23425)
-- Name: equipment FK_18c1ade809ed0c03570b2b9897c; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT "FK_18c1ade809ed0c03570b2b9897c" FOREIGN KEY (apartment_id) REFERENCES public.apartment(apartment_id);


--
-- TOC entry 3154 (class 2606 OID 23430)
-- Name: equipment FK_26430a91a04092c67a984c37db1; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT "FK_26430a91a04092c67a984c37db1" FOREIGN KEY (floor_id) REFERENCES public.floor(floor_id);


--
-- TOC entry 3152 (class 2606 OID 23404)
-- Name: vehicle FK_4cb723ab505ae48c5ef46b827c6; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT "FK_4cb723ab505ae48c5ef46b827c6" FOREIGN KEY (resident_id) REFERENCES public.resident(id);


--
-- TOC entry 3143 (class 2606 OID 23285)
-- Name: contract FK_6e98ee9bed0e7b69ca3fec522ca; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK_6e98ee9bed0e7b69ca3fec522ca" FOREIGN KEY (resident_id) REFERENCES public.resident(id);


--
-- TOC entry 3149 (class 2606 OID 23310)
-- Name: admin FK_7403ac47c3a65ad475bb9704fe7; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "FK_7403ac47c3a65ad475bb9704fe7" FOREIGN KEY ("accountOwnerId") REFERENCES public.account(owner_id);


--
-- TOC entry 3138 (class 2606 OID 23250)
-- Name: manager FK_766b0df54007cf8b91d659f8b07; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "FK_766b0df54007cf8b91d659f8b07" FOREIGN KEY ("accountOwnerId") REFERENCES public.account(owner_id);


--
-- TOC entry 3141 (class 2606 OID 23265)
-- Name: apartment FK_81b84604fffd7cd77950c7527ab; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.apartment
    ADD CONSTRAINT "FK_81b84604fffd7cd77950c7527ab" FOREIGN KEY (floor_id) REFERENCES public.floor(floor_id);


--
-- TOC entry 3142 (class 2606 OID 23270)
-- Name: apartment FK_85733549aac7c41caec8e95e080; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.apartment
    ADD CONSTRAINT "FK_85733549aac7c41caec8e95e080" FOREIGN KEY (building_id) REFERENCES public.building(building_id);


--
-- TOC entry 3148 (class 2606 OID 23305)
-- Name: resident FK_94b757a77f8d48bbab3d07b0048; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "FK_94b757a77f8d48bbab3d07b0048" FOREIGN KEY (stay_at_apartment_id) REFERENCES public.apartment(apartment_id);


--
-- TOC entry 3144 (class 2606 OID 23275)
-- Name: contract FK_95c24778f5158039a6fa8f89761; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK_95c24778f5158039a6fa8f89761" FOREIGN KEY ("previousContractContractId") REFERENCES public.contract(contract_id);


--
-- TOC entry 3139 (class 2606 OID 23399)
-- Name: manager FK_9a555f4704d10875ce0e96f7adf; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "FK_9a555f4704d10875ce0e96f7adf" FOREIGN KEY ("buildingBuildingId") REFERENCES public.building(building_id);


--
-- TOC entry 3155 (class 2606 OID 23435)
-- Name: equipment FK_a16fcd190ba1163562bd36ea361; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT "FK_a16fcd190ba1163562bd36ea361" FOREIGN KEY (building_id) REFERENCES public.building(building_id);


--
-- TOC entry 3150 (class 2606 OID 23315)
-- Name: technician FK_a5cc9be700210211a07aad3f522; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.technician
    ADD CONSTRAINT "FK_a5cc9be700210211a07aad3f522" FOREIGN KEY ("accountOwnerId") REFERENCES public.account(owner_id);


--
-- TOC entry 3151 (class 2606 OID 23320)
-- Name: service_package FK_dd059309aa7ad3f8e631d5a9b4e; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.service_package
    ADD CONSTRAINT "FK_dd059309aa7ad3f8e631d5a9b4e" FOREIGN KEY ("serviceServiceId") REFERENCES public.service(service_id);


--
-- TOC entry 3145 (class 2606 OID 23290)
-- Name: contract FK_e376d998cdfc48b6f794322efbb; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK_e376d998cdfc48b6f794322efbb" FOREIGN KEY (apartment_id) REFERENCES public.apartment(apartment_id);


--
-- TOC entry 3146 (class 2606 OID 23280)
-- Name: contract FK_f7838bbfaca1c13e5791e635204; Type: FK CONSTRAINT; Schema: public; Owner: homeland_db_user
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK_f7838bbfaca1c13e5791e635204" FOREIGN KEY ("nextContractContractId") REFERENCES public.contract(contract_id);


--
-- TOC entry 3318 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: homeland_db_user
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- TOC entry 2114 (class 826 OID 16391)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES  TO homeland_db_user;


--
-- TOC entry 2116 (class 826 OID 16393)
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES  TO homeland_db_user;


--
-- TOC entry 2115 (class 826 OID 16392)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS  TO homeland_db_user;


--
-- TOC entry 2113 (class 826 OID 16390)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO homeland_db_user;


-- Completed on 2023-11-17 22:29:31

--
-- PostgreSQL database dump complete
--

