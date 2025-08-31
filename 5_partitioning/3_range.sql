CREATE TABLE
    iot_measurement (
        location_id int not null,
        measure_date timestamp not null,
        temp_celcius int,
        rel_humidity_pct int
    )
PARTITION BY
    RANGE (measure_date);

CREATE TABLE
    iot_measurement_wk1_2024 PARTITION OF iot_measurement FOR
VALUES
FROM
    ('2024-01-01') TO ('2024-01-08');

CREATE TABLE
    iot_measurement_wk2_2024 PARTITION OF iot_measurement FOR
VALUES
FROM
    ('2024-01-08') TO ('2024-01-15');

CREATE TABLE
    iot_measurement_wk3_2024 PARTITION OF iot_measurement FOR
VALUES
FROM
    ('2024-01-15') TO ('2024-01-22');