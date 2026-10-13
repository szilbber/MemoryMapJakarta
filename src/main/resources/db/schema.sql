-- Таблица персон
CREATE TABLE persons (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    death_date DATE,
    description TEXT
);

-- Таблица мест захоронения
CREATE TABLE burial_locations (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    is_exact BOOLEAN NOT NULL DEFAULT FALSE,
    description TEXT,
    person_id BIGINT NOT NULL UNIQUE,

    CONSTRAINT fk_burial_location_person
        FOREIGN KEY (person_id)
        REFERENCES persons(id),

    CONSTRAINT chk_latitude
        CHECK (latitude IS NULL OR latitude BETWEEN -90 AND 90),

    CONSTRAINT chk_longitude
        CHECK (longitude IS NULL OR longitude BETWEEN -180 AND 180)
);

-- Тестовые персоны
INSERT INTO persons
    (first_name, last_name, birth_date, death_date, description)
VALUES
    ('Иван', 'Иванов', '1940-03-15', '2010-08-21',
     'Пример записи для проверки приложения'),
    ('Мария', 'Петрова', '1952-11-02', '2020-05-14',
     'Место захоронения известно приблизительно'),
    ('Алексей', 'Сидоров', '1935-06-10', '2001-12-30',
     'Тестовая запись без указанного места захоронения');

-- Тестовые места захоронения
INSERT INTO burial_locations
    (latitude, longitude, is_exact, description, person_id)
VALUES
    (53.1959, 50.1002, TRUE, 'Точные координаты для примера', 1),
    (53.2000, 50.1100, FALSE, 'Приблизительное расположение', 2);
