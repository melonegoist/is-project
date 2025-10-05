create type role_enum as enum ('Admin','User','Teacher');
create type courses_types_enum as enum ('Online','Ofline','Hybrid');
create type courses_skill_levels_enum as enum ('Begginer','Intermediate','Advanced');
create type courses_statuses_enum as enum ('Staring the course','Completing the course','Course completed');
create type profiles_skill_level_enum as enum ('Juniour','Middle','Seniour');
create type courses_status_enum as enum ('Published','Recently updated','Closed');
create type payment_currency_enum as enum ('RUB','EUR','USD');


CREATE TABLE USERS(
    user_id SERIAL PRIMARY KEY ,
    email VARCHAR(30) NOT NULL ,
    password VARCHAR(255) NOT NULL UNIQUE,
    role role_enum,
    first_name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    created_user_time timestamp,
    is_active bool,
    email_veridef bool
);

CREATE TABLE LOCATIONS(
  location_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  address text
);

CREATE TABLE COURSES(
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(64) NOT NULL,
    text VARCHAR(1024) NOT NULL,
    format courses_types_enum NOT NULL,
    skill_level courses_skill_levels_enum,
    status courses_statuses_enum NOT NULL ,
    teacher_id INTEGER REFERENCES USERS(user_id),
    location_id INTEGER REFERENCES LOCATIONS(location_id),
    created_at timestamp
);

CREATE TABLE COURSE_ENROLLMENTS
(
    enrollment_id SERIAL PRIMARY KEY,
    user_id       INTEGER REFERENCES USERS (user_id),
    course_id     INTEGER REFERENCES COURSES (course_id),
    status        courses_statuses_enum NOT NULL,
    enrolles_at   timestamp
);

CREATE TABLE PROFILES(
    profile_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES USERS(user_id),
    phone_number VARCHAR(20),
    avatar_url TEXT,
    date_of_birth DATE,
    skill_level profiles_skill_level_enum NOT NULL,
    info_profilies TEXT
);

CREATE TABLE EQUIPMENT(
    equipment_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    type_equipment VARCHAR(100),
    description TEXT,
    status VARCHAR(100)
);

CREATE TABLE PAYMENTS(
    payment_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES USERS(user_id),
    amount DECIMAL,
    currency payment_currency_enum NOT NULL,
    status VARCHAR(100),
    payment_type VARCHAR(1000),
    entity_id INTEGER,
    created_at timestamp
);

CREATE TABLE MESSAGES(
    message_id SERIAL PRIMARY KEY ,
    sender_id INTEGER REFERENCES USERS(user_id),
    receiver_id INTEGER REFERENCES USERS(user_id),
    message_text TEXT,
    sent_at timestamp,
    message_type VARCHAR(50)
);

CREATE TABLE LESSONS(
    lessons_id SERIAL PRIMARY KEY ,
    course_id INTEGER REFERENCES COURSES(course_id),
    title VARCHAR(128),
    start_time TIMESTAMP,
    duration_minutes INTEGER,
    video_conf_url VARCHAR(256),
    location_id INTEGER REFERENCES LOCATIONS(location_id)
);

CREATE TABLE EQUIPMENT_RENTALS(
    rental_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES USERS(user_id),
    equipment_id INTEGER REFERENCES EQUIPMENT(equipment_id),
    start_date timestamp,
    end_date timestamp,
    status VARCHAR(100),
    created_at TIMEStamp
);
