--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.3

-- Started on 2023-11-17 22:54:49

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

DO
$do$
BEGIN
   IF EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = 'homeland_db_user') THEN

      RAISE NOTICE 'Role "homeland_db_user" already exists. Skipping.';
   ELSE
      CREATE USER homeland_db_user WITH PASSWORD '123';
   END IF;
END
$do$;


ALTER SCHEMA public OWNER TO homeland_db_user;

--
-- TOC entry 3303 (class 0 OID 0)
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
-- TOC entry 3304 (class 0 OID 0)
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


-- Completed on 2023-11-17 22:54:52

--
-- PostgreSQL database dump complete
--

