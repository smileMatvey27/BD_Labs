DROP TABLE IF EXISTS booking CASCADE;
DROP TABLE IF EXISTS flight CASCADE;
DROP TABLE IF EXISTS aircraft CASCADE;
DROP TABLE IF EXISTS passenger CASCADE;
DROP TABLE IF EXISTS airport CASCADE;
DROP TABLE IF EXISTS city CASCADE;


CREATE TABLE city (
    id       SERIAL       PRIMARY KEY,
    name     VARCHAR(100) NOT NULL,
    country  VARCHAR(100) NOT NULL,
    CONSTRAINT uq_city_name_country UNIQUE (name, country)
);


CREATE TABLE airport (
    id       SERIAL       PRIMARY KEY,
    code     CHAR(3)      NOT NULL,
    name     VARCHAR(150) NOT NULL,
    city_id  INTEGER      NOT NULL,
    CONSTRAINT uq_airport_code UNIQUE (code),
    CONSTRAINT check_airport_code_format CHECK (code ~ '^[A-Z]{3}$'),
    CONSTRAINT fk_airport_city FOREIGN KEY (city_id)
        REFERENCES city (id) ON DELETE RESTRICT
);


CREATE TABLE passenger (
    id          SERIAL       PRIMARY KEY,
    full_name   VARCHAR(150) NOT NULL,
    passport    VARCHAR(20)  NOT NULL,
    email       VARCHAR(100) NOT NULL,
    phone       VARCHAR(20),
    birth_date  DATE         NOT NULL,
    CONSTRAINT uq_passenger_passport UNIQUE (passport),
    CONSTRAINT uq_passenger_email    UNIQUE (email),
    CONSTRAINT check_passenger_email CHECK (email LIKE '%@%.%'),
    CONSTRAINT check_passenger_birth CHECK (birth_date < CURRENT_DATE)
);


CREATE TABLE aircraft (
    id           SERIAL      PRIMARY KEY,
    tail_number  VARCHAR(10) NOT NULL,
    model        VARCHAR(50) NOT NULL,
    capacity     INTEGER     NOT NULL,
    CONSTRAINT uq_aircraft_tail UNIQUE (tail_number),
    CONSTRAINT check_aircraft_capacity CHECK (capacity > 0)
);


CREATE TABLE flight (
    id                    SERIAL        PRIMARY KEY,
    flight_number         VARCHAR(10)   NOT NULL,
    aircraft_id           INTEGER       NOT NULL,
    departure_airport_id  INTEGER       NOT NULL,
    arrival_airport_id    INTEGER       NOT NULL,
    departure_time        TIMESTAMP     NOT NULL,
    arrival_time          TIMESTAMP     NOT NULL,
    base_price            NUMERIC(10,2) NOT NULL,
    CONSTRAINT uq_flight_number UNIQUE (flight_number),
    CONSTRAINT check_flight_price CHECK (base_price >= 0),
    CONSTRAINT check_flight_airports CHECK (departure_airport_id <> arrival_airport_id),
    CONSTRAINT check_flight_times CHECK (arrival_time > departure_time),
    CONSTRAINT fk_flight_aircraft FOREIGN KEY (aircraft_id)
        REFERENCES aircraft (id) ON DELETE RESTRICT,
    CONSTRAINT fk_flight_dep_airport FOREIGN KEY (departure_airport_id)
        REFERENCES airport (id) ON DELETE RESTRICT,
    CONSTRAINT fk_flight_arr_airport FOREIGN KEY (arrival_airport_id)
        REFERENCES airport (id) ON DELETE RESTRICT
);


CREATE TABLE booking (
    id             SERIAL        PRIMARY KEY,
    passenger_id   INTEGER       NOT NULL,
    flight_id      INTEGER       NOT NULL,
    seat_number    VARCHAR(5)    NOT NULL,
    booking_class  VARCHAR(20)   NOT NULL,
    status         VARCHAR(10)   NOT NULL DEFAULT 'booked',
    booking_date   TIMESTAMP     NOT NULL DEFAULT NOW(),
    price_paid     NUMERIC(10,2) NOT NULL,
    CONSTRAINT check_booking_class CHECK (booking_class IN ('economy','business','first')),
    CONSTRAINT check_booking_status CHECK (status IN ('booked','paid','cancelled')),
    CONSTRAINT check_booking_price CHECK (price_paid >= 0),
    CONSTRAINT uq_booking_seat UNIQUE (flight_id, seat_number),
    CONSTRAINT fk_booking_passenger FOREIGN KEY (passenger_id)
        REFERENCES passenger (id) ON DELETE RESTRICT,
    CONSTRAINT fk_booking_flight FOREIGN KEY (flight_id)
        REFERENCES flight (id) ON DELETE RESTRICT
);