


-- la distancia entre san cristobal y la vega
SELECT ST_Distance(
  ST_Centroid(ST_Transform(a.wkb_geometry, 4326))::geography,
  ST_Centroid(ST_Transform(b.wkb_geometry, 4326))::geography
) AS distancia_metros
FROM provincias a, provincias b
WHERE a.prov = '21' AND b.prov = '13';





-- barrio mas grande

SELECT 
  barrios.toponimia AS nombre_barrio, 
  municipios.toponimia AS nombre_municipio, 
  ST_Area(ST_Transform(barrios.wkb_geometry, 4326)::geography) AS area_m2
FROM barrios
INNER JOIN municipios ON barrios.mun = municipios.mun
ORDER BY area_m2 DESC
LIMIT 1;


--Top 10
SELECT 
  barrios.toponimia AS nombre_barrio, 
  municipios.toponimia AS nombre_municipio, 
  ST_Area(ST_Transform(barrios.wkb_geometry, 4326)::geography) AS area_m2
FROM barrios
INNER JOIN municipios ON barrios.mun = municipios.mun
ORDER BY area_m2 DESC
LIMIT 10;


-- BARRIO MAS PEQUE;O
SELECT 
  barrios.toponimia AS nombre_barrio, 
  municipios.toponimia AS nombre_municipio, 
  ST_Area(ST_Transform(barrios.wkb_geometry, 4326)::geography) AS area_m2
FROM barrios
INNER JOIN municipios ON barrios.mun = municipios.mun
ORDER BY area_m2 ASC
LIMIT 1;

-- Top 10
SELECT 
  barrios.toponimia AS nombre_barrio, 
  municipios.toponimia AS nombre_municipio, 
  ST_Area(ST_Transform(barrios.wkb_geometry, 4326)::geography) AS area_m2
FROM barrios
INNER JOIN municipios ON barrios.mun = municipios.mun
ORDER BY area_m2 ASC
LIMIT 10;


 
--provincias mas cercanas a san cristobal
SELECT 
  p2.prov AS codigo_provincia,
  p2.toponimia AS nombre_provincia,
  ST_Distance(
    ST_Centroid(ST_Transform(p1.wkb_geometry, 4326))::geography,
    ST_Centroid(ST_Transform(p2.wkb_geometry, 4326))::geography
  ) AS distancia_metros
FROM provincias p1
JOIN provincias p2 ON p1.prov <> p2.prov
WHERE p1.prov = '21'  -- provincia de referencia
ORDER BY distancia_metros
LIMIT 4;

--Hospitales mas cerca de villa mella

 SELECT h.nombre AS nombre_hospital,
    h.ubicacion,
    h.direccion,
    st_distance(h.ubicacion::geography, st_centroid(st_transform(b.wkb_geometry, 4326))::geography) AS distancia_metros,
    b.toponimia
   FROM hospitales h
     JOIN barrios b ON b.toponimia::text = 'VILLA MELLA'::text
  ORDER BY (st_distance(h.ubicacion::geography, st_centroid(st_transform(b.wkb_geometry, 4326))::geography))
 LIMIT 5;
