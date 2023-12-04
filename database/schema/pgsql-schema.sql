--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- Name: admin_profilegender_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.admin_profilegender_enum AS ENUM (
    'male',
    'female'
);


--
-- Name: apartment_status_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.apartment_status_enum AS ENUM (
    'active',
    'inactive'
);


--
-- Name: contract_role_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.contract_role_enum AS ENUM (
    'buy',
    'rent'
);


--
-- Name: contract_status_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.contract_status_enum AS ENUM (
    'active',
    'inactive'
);


--
-- Name: employee_profilegender_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.employee_profilegender_enum AS ENUM (
    'male',
    'female'
);


--
-- Name: equipment_status_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.equipment_status_enum AS ENUM (
    'AVAILABLE',
    'NOT_AVAILABLE',
    'MAINTENANCE'
);


--
-- Name: manager_profilegender_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.manager_profilegender_enum AS ENUM (
    'male',
    'female'
);


--
-- Name: resident_profilegender_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.resident_profilegender_enum AS ENUM (
    'male',
    'female'
);


--
-- Name: technician_profilegender_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.technician_profilegender_enum AS ENUM (
    'male',
    'female'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: admin; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: apartment; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: building; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.building (
    building_id character varying NOT NULL,
    name character varying NOT NULL,
    max_floor integer DEFAULT 0 NOT NULL,
    address character varying NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: contract; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: employee; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: equipment; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: floor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.floor (
    floor_id character varying NOT NULL,
    name character varying NOT NULL,
    building_id character varying
);


--
-- Name: manager; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: resident; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: service; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service (
    service_id character varying NOT NULL,
    name character varying NOT NULL,
    description character varying,
    "imageURLs" text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: service_package; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service_package (
    id character varying NOT NULL,
    service_id character varying NOT NULL,
    expired_date integer NOT NULL,
    per_unit_price integer NOT NULL,
    "serviceServiceId" character varying
);


--
-- Name: technician; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: vehicle; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: building PK_03b4a92f4aaa6114958969b6a9c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.building
    ADD CONSTRAINT "PK_03b4a92f4aaa6114958969b6a9c" PRIMARY KEY (building_id);


--
-- Name: equipment PK_0722e1b9d6eb19f5874c1678740; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT "PK_0722e1b9d6eb19f5874c1678740" PRIMARY KEY (id);


--
-- Name: service_package PK_1275e8aa6ef5b9cd78906ea53d3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_package
    ADD CONSTRAINT "PK_1275e8aa6ef5b9cd78906ea53d3" PRIMARY KEY (id);


--
-- Name: vehicle PK_187fa17ba39d367e5604b3d1ec9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT "PK_187fa17ba39d367e5604b3d1ec9" PRIMARY KEY (id);


--
-- Name: apartment PK_1b3223b3ffa6791f83b58951611; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.apartment
    ADD CONSTRAINT "PK_1b3223b3ffa6791f83b58951611" PRIMARY KEY (apartment_id);


--
-- Name: contract PK_2f25fae55a3bd80337501b310e3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "PK_2f25fae55a3bd80337501b310e3" PRIMARY KEY (contract_id);


--
-- Name: employee PK_3c2bc72f03fd5abbbc5ac169498; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT "PK_3c2bc72f03fd5abbbc5ac169498" PRIMARY KEY (id);


--
-- Name: floor PK_45e4850aab53c1130ba72995e74; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.floor
    ADD CONSTRAINT "PK_45e4850aab53c1130ba72995e74" PRIMARY KEY (floor_id);


--
-- Name: technician PK_465640daf2153d02a5114c86e95; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.technician
    ADD CONSTRAINT "PK_465640daf2153d02a5114c86e95" PRIMARY KEY (id);


--
-- Name: service PK_48c5a0e13da2b2948fb7f3a0c4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT "PK_48c5a0e13da2b2948fb7f3a0c4a" PRIMARY KEY (service_id);


--
-- Name: account PK_7e86daab9d155ec4cc3fd654454; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT "PK_7e86daab9d155ec4cc3fd654454" PRIMARY KEY (owner_id);


--
-- Name: manager PK_b3ac840005ee4ed76a7f1c51d01; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "PK_b3ac840005ee4ed76a7f1c51d01" PRIMARY KEY (id);


--
-- Name: admin PK_e032310bcef831fb83101899b10; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "PK_e032310bcef831fb83101899b10" PRIMARY KEY (id);


--
-- Name: resident PK_f1a321823d6f69d0e348535fd37; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "PK_f1a321823d6f69d0e348535fd37" PRIMARY KEY (id);


--
-- Name: resident REL_0405db8663fd4529a487e3c032; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "REL_0405db8663fd4529a487e3c032" UNIQUE ("accountOwnerId");


--
-- Name: admin REL_7403ac47c3a65ad475bb9704fe; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "REL_7403ac47c3a65ad475bb9704fe" UNIQUE ("accountOwnerId");


--
-- Name: manager REL_766b0df54007cf8b91d659f8b0; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "REL_766b0df54007cf8b91d659f8b0" UNIQUE ("accountOwnerId");


--
-- Name: contract REL_95c24778f5158039a6fa8f8976; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "REL_95c24778f5158039a6fa8f8976" UNIQUE ("previousContractContractId");


--
-- Name: technician REL_a5cc9be700210211a07aad3f52; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.technician
    ADD CONSTRAINT "REL_a5cc9be700210211a07aad3f52" UNIQUE ("accountOwnerId");


--
-- Name: contract REL_f7838bbfaca1c13e5791e63520; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "REL_f7838bbfaca1c13e5791e63520" UNIQUE ("nextContractContractId");


--
-- Name: resident UQ_06b083ffda1f617880fbf602c99; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "UQ_06b083ffda1f617880fbf602c99" UNIQUE ("profilePhone_number");


--
-- Name: vehicle UQ_08f5ab49f428e2090a434623a86; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT "UQ_08f5ab49f428e2090a434623a86" UNIQUE (license_plate);


--
-- Name: manager UQ_0bf0cc7e84d95c46c051a57aa5a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "UQ_0bf0cc7e84d95c46c051a57aa5a" UNIQUE ("profilePhone_number");


--
-- Name: account UQ_4c8f96ccf523e9a3faefd5bdd4c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT "UQ_4c8f96ccf523e9a3faefd5bdd4c" UNIQUE (email);


--
-- Name: admin UQ_8d6044ea49c7363e7329737351b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "UQ_8d6044ea49c7363e7329737351b" UNIQUE ("profilePhone_number");


--
-- Name: employee UQ_97bbfba3a57621a204f5874e6a3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT "UQ_97bbfba3a57621a204f5874e6a3" UNIQUE ("profilePhone_number");


--
-- Name: technician UQ_d103b5bce8de1a3df32002c8c93; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.technician
    ADD CONSTRAINT "UQ_d103b5bce8de1a3df32002c8c93" UNIQUE ("profilePhone_number");


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: resident FK_0405db8663fd4529a487e3c0327; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "FK_0405db8663fd4529a487e3c0327" FOREIGN KEY ("accountOwnerId") REFERENCES public.account(owner_id);


--
-- Name: floor FK_1565850c51d1cc30e896101fa77; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.floor
    ADD CONSTRAINT "FK_1565850c51d1cc30e896101fa77" FOREIGN KEY (building_id) REFERENCES public.building(building_id);


--
-- Name: equipment FK_18c1ade809ed0c03570b2b9897c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT "FK_18c1ade809ed0c03570b2b9897c" FOREIGN KEY (apartment_id) REFERENCES public.apartment(apartment_id);


--
-- Name: equipment FK_26430a91a04092c67a984c37db1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT "FK_26430a91a04092c67a984c37db1" FOREIGN KEY (floor_id) REFERENCES public.floor(floor_id);


--
-- Name: vehicle FK_4cb723ab505ae48c5ef46b827c6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT "FK_4cb723ab505ae48c5ef46b827c6" FOREIGN KEY (resident_id) REFERENCES public.resident(id);


--
-- Name: contract FK_6e98ee9bed0e7b69ca3fec522ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK_6e98ee9bed0e7b69ca3fec522ca" FOREIGN KEY (resident_id) REFERENCES public.resident(id);


--
-- Name: admin FK_7403ac47c3a65ad475bb9704fe7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "FK_7403ac47c3a65ad475bb9704fe7" FOREIGN KEY ("accountOwnerId") REFERENCES public.account(owner_id);


--
-- Name: manager FK_766b0df54007cf8b91d659f8b07; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "FK_766b0df54007cf8b91d659f8b07" FOREIGN KEY ("accountOwnerId") REFERENCES public.account(owner_id);


--
-- Name: apartment FK_81b84604fffd7cd77950c7527ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.apartment
    ADD CONSTRAINT "FK_81b84604fffd7cd77950c7527ab" FOREIGN KEY (floor_id) REFERENCES public.floor(floor_id);


--
-- Name: apartment FK_85733549aac7c41caec8e95e080; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.apartment
    ADD CONSTRAINT "FK_85733549aac7c41caec8e95e080" FOREIGN KEY (building_id) REFERENCES public.building(building_id);


--
-- Name: resident FK_94b757a77f8d48bbab3d07b0048; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resident
    ADD CONSTRAINT "FK_94b757a77f8d48bbab3d07b0048" FOREIGN KEY (stay_at_apartment_id) REFERENCES public.apartment(apartment_id);


--
-- Name: contract FK_95c24778f5158039a6fa8f89761; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK_95c24778f5158039a6fa8f89761" FOREIGN KEY ("previousContractContractId") REFERENCES public.contract(contract_id);


--
-- Name: manager FK_9a555f4704d10875ce0e96f7adf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT "FK_9a555f4704d10875ce0e96f7adf" FOREIGN KEY ("buildingBuildingId") REFERENCES public.building(building_id);


--
-- Name: equipment FK_a16fcd190ba1163562bd36ea361; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT "FK_a16fcd190ba1163562bd36ea361" FOREIGN KEY (building_id) REFERENCES public.building(building_id);


--
-- Name: technician FK_a5cc9be700210211a07aad3f522; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.technician
    ADD CONSTRAINT "FK_a5cc9be700210211a07aad3f522" FOREIGN KEY ("accountOwnerId") REFERENCES public.account(owner_id);


--
-- Name: service_package FK_dd059309aa7ad3f8e631d5a9b4e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_package
    ADD CONSTRAINT "FK_dd059309aa7ad3f8e631d5a9b4e" FOREIGN KEY ("serviceServiceId") REFERENCES public.service(service_id);


--
-- Name: contract FK_e376d998cdfc48b6f794322efbb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK_e376d998cdfc48b6f794322efbb" FOREIGN KEY (apartment_id) REFERENCES public.apartment(apartment_id);


--
-- Name: contract FK_f7838bbfaca1c13e5791e635204; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK_f7838bbfaca1c13e5791e635204" FOREIGN KEY ("nextContractContractId") REFERENCES public.contract(contract_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0

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
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migrations (id, migration, batch) FROM stdin;
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

