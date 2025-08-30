-- funcion distancia

CREATE OR REPLACE FUNCTION distancia_entre_provincias(prov1 TEXT, prov2 TEXT)
RETURNS DOUBLE PRECISION AS $$
BEGIN
  RETURN (
    SELECT ST_Distance(
      ST_Centroid(ST_Transform(a.wkb_geometry, 4326))::geography,
      ST_Centroid(ST_Transform(b.wkb_geometry, 4326))::geography
    )
    FROM provincias a, provincias b
    WHERE a.prov = prov1 AND b.prov = prov2
  );
END;
$$ LANGUAGE plpgsql;

-- SELECT distancia_entre_provincias('21', '13') AS distancia_metros;





-- funcion barrio mas grande y peque;o
CREATE OR REPLACE FUNCTION barrios_extremos_por_municipio(municipio_codigo TEXT)
RETURNS TABLE (
  tipo TEXT,
  nombre_barrio TEXT,
  nombre_municipio TEXT,
  area_m2 DOUBLE PRECISION
) AS $$
BEGIN
  RETURN QUERY
  -- Barrio más grande
  SELECT
    'Más grande'::TEXT AS tipo,
    b.toponimia::TEXT AS nombre_barrio,
    m.toponimia::TEXT AS nombre_municipio,
    ST_Area(ST_Transform(b.wkb_geometry, 4326)::geography) AS area_m2
  FROM barrios b
  INNER JOIN municipios m ON b.mun = m.mun
  WHERE b.mun = municipio_codigo
  ORDER BY area_m2 DESC
  LIMIT 1;

  RETURN QUERY
  -- Barrio más pequeño
  SELECT
    'Más pequeño'::TEXT AS tipo,
    b.toponimia::TEXT AS nombre_barrio,
    m.toponimia::TEXT AS nombre_municipio,
    ST_Area(ST_Transform(b.wkb_geometry, 4326)::geography) AS area_m2
  FROM barrios b
  INNER JOIN municipios m ON b.mun = m.mun
  WHERE b.mun = municipio_codigo
  ORDER BY area_m2 ASC
  LIMIT 1;
END;
$$ LANGUAGE plpgsql;


--ejemplo SELECT * FROM barrios_extremos_por_municipio('02'); 

--provincias mas cercana a otra

CREATE OR REPLACE FUNCTION provincias_mas_cercanas(provincia_origen TEXT, limite INT)
RETURNS TABLE (
  codigo_provincia TEXT,
  nombre_provincia TEXT,
  distancia_metros DOUBLE PRECISION
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    p2.prov::TEXT AS codigo_provincia,
    p2.toponimia::TEXT AS nombre_provincia,
    ST_Distance(
      ST_Centroid(ST_Transform(p1.wkb_geometry, 4326))::geography,
      ST_Centroid(ST_Transform(p2.wkb_geometry, 4326))::geography
    ) AS distancia_metros
  FROM provincias p1
  JOIN provincias p2 ON p1.prov <> p2.prov
  WHERE p1.prov = provincia_origen
  ORDER BY distancia_metros
  LIMIT limite;
END;
$$ LANGUAGE plpgsql;


-- -- Ejemplo: las 4 provincias más cercanas a la provincia '21'
-- SELECT * FROM provincias_mas_cercanas('21', 4);


CREATE OR REPLACE FUNCTION actualizar_area_m2()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' OR NEW.wkb_geometry IS DISTINCT FROM OLD.wkb_geometry THEN
    IF NEW.wkb_geometry IS NOT NULL THEN
      NEW.area_m2 := ST_Area(ST_Transform(NEW.wkb_geometry, 4326)::geography);
    ELSE
      NEW.area_m2 := NULL;
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


