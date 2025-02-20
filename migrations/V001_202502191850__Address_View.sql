CREATE VIEW [vw_full_addresses] AS
SELECT 
    addresses.[address_id],
    addresses.[street_number],
    addresses.[street_name],
    suburb.[name] AS suburb,
    suburb.[postal_code],
    city.[name] AS city,
    province.[name] AS province,
    country.[name] AS country
FROM [addresses]
	JOIN [suburb] ON (addresses.[suburb_id] = suburb.[suburb_id])
	JOIN [city] ON (addresses.[city_id] = city.[city_id])
	JOIN [province] ON (city.[province_id] = province.[province_id])
	JOIN [country] ON (province.[country_id] = country.[country_id]);
GO