-- operation 1
INSERT INTO category (category_type, max_tier)
VALUES ('Simple', 3);

INSERT INTO yard (code, category_type, max_tier)
VALUES ('Y', 'Simple', 3);

INSERT INTO position (
	bay,
	row,
	tier,
	code,
	max_tier
)
VALUES 
	(0, 0, 1, 'Y', 3),
	(0, 1, 1, 'Y', 3),
	(1, 0, 1, 'Y', 3),
	(1, 1, 1, 'Y', 3),
	(0, 0, 2, 'Y', 3),
	(0, 1, 2, 'Y', 3),
	(1, 0, 2, 'Y', 3),
	(1, 1, 2, 'Y', 3),
	(0, 0, 3, 'Y', 3),
	(0, 1, 3, 'Y', 3),
	(1, 0, 3, 'Y', 3),
	(1, 1, 3, 'Y', 3);

-- operation 2
INSERT INTO berth (longitude, latitude, code)
VALUES 
	(0, 0, 'B1'),
	(0, 1, 'B2');

-- operation 3
INSERT INTO country (name, continent)
VALUES ('Singapore', 'Asia');

INSERT INTO city (name, country_name)
VALUES ('Singapore', 'Singapore');

INSERT INTO company (
	company_code,
	name,
	address,
	postal_code,
	city_name,
	country_name
)
VALUES (
	'ADI',
	'Apasaja Distribution International',
	'Apasaja Street',
	'10086',
	'Singapore',
	'Singapore'
);

-- operation 4
INSERT INTO ship(
	mmsi,
	imo_number,
	call_sign,
	name,
	width,
	length,
	berth_code
)
VALUES (
	211382280,
	9229843,
	'5LJY5',
	'ship1',
	30,
	100,
	'B1'
);

INSERT INTO container(
	iso_6346,
	content,
	company_code,
	mmsi,
	bay,
	row,
	tier,
	code,
	support_tier
)
VALUES (
	'ADIU4974982',
	'shoes',
	'ADI',
	211382280,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL
);

-- operation 5
INSERT INTO ship(
	mmsi,
	imo_number,
	call_sign,
	name,
	width,
	length,
	berth_code
)
VALUES (
	209912000,
	9261889,
	'5BLP5',
	'ship2',
	40,
	150,
	'B2'
);

INSERT INTO container(
	iso_6346,
	content,
	company_code,
	mmsi,
	bay,
	row,
	tier,
	code,
	support_tier
)
VALUES (
	'ADIU7385836',
	'clothes',
	'ADI',
	209912000,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL
);

-- operation 6
DELETE FROM container
WHERE iso_6346 = 'ADIU4974982';

INSERT INTO container (
	iso_6346,
	content,
	company_code,
	mmsi,
	bay,
	row,
	tier,
	code,
	support_tier
)
VALUES (
	'ADIU4974982',
	'shoes',
	'ADI',
	NULL,
	0,
	0,
	1,
	'Y',
	NULL
);

-- operation 7
DELETE FROM ship
WHERE mmsi = '211382280';

-- operation 8
INSERT INTO ship (
	mmsi,
	imo_number,
	call_sign,
	name,
	width,
	length,
	berth_code
)
VALUES (
	255806008,
	9277400,
	'3FIV6',
	'ship3',
	20,
	60,
	'B1'
);

INSERT INTO container (
	iso_6346,
	content,
	company_code,
	mmsi,
	bay,
	row,
	tier,
	code,
	support_tier
)
VALUES (
	'ADIU7583471',
	'boxes',
	'ADI',
	255806008,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL
);

-- operation 9
DELETE FROM ship
WHERE mmsi = '209912000';

-- operation 10
DELETE FROM container
WHERE iso_6346 = 'ADIU7583471';

INSERT INTO container (
	iso_6346,
	content,
	company_code,
	mmsi,
	bay,
	row,
	tier,
	code,
	support_tier
)
VALUES (
	'ADIU7583471',
	'boxes',
	'ADI',
	NULL,
	0,
	0,
	2,
	'Y',
	1
);

-- query
SELECT 
    y.code AS yard_code, 
    y.category_type AS yard_type, 
    p.bay AS bay_number, 
    p.row AS row_number, 
    p.tier AS tier_number
FROM position p, yard y
WHERE y.code = p.code
    AND NOT EXISTS(
        SELECT 1 
        FROM container c
        WHERE c.bay = p.bay
            AND c.row = p.row
            AND c.tier = p.tier
            AND c.code = p.code
    )
ORDER BY y.code ASC, p.bay ASC, p.row ASC, p.tier ASC; 
