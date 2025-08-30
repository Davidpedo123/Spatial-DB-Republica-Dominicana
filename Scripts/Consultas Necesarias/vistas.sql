CREATE VIEW municipio_monte_criti AS
SELECT
    municipios.toponimia AS municipio_toponimia,
    provincias.toponimia AS provincia_toponimia
FROM
    municipios
INNER JOIN
    provincias ON provincias.prov = municipios.prov
WHERE
    provincias.prov = '04';

	select * from municipio_monte_criti



CREATE VIEW municipio_sancristobal AS
SELECT
    municipios.toponimia AS municipio_toponimia,
    provincias.toponimia AS provincia_toponimia
FROM
    municipios
INNER JOIN
    provincias ON provincias.prov = municipios.prov
WHERE
    provincias.prov = '21';

	select * from municipio_sancristobal



CREATE VIEW municipio_monte_plata AS
SELECT
    municipios.toponimia AS municipio_toponimia,
    provincias.toponimia AS provincia_toponimia
FROM
    municipios
INNER JOIN
    provincias ON provincias.prov = municipios.prov
WHERE
    provincias.prov = '09';

	select * from municipio_monte_plata


CREATE VIEW hospitales_mas_cercanos_villamella AS
SELECT h.nombre AS nombre_hospital,
    h.ubicacion,
    h.direccion,
    st_distance(h.ubicacion::geography, st_centroid(st_transform(b.wkb_geometry, 4326))::geography) AS distancia_metros,
    b.toponimia
   FROM hospitales h
     JOIN barrios b ON b.toponimia::text = 'VILLA MELLA'::text
  ORDER BY (st_distance(h.ubicacion::geography, st_centroid(st_transform(b.wkb_geometry, 4326))::geography))
 LIMIT 5;