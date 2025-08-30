CREATE OR REPLACE PROCEDURE actualizar_area_barrios()
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE barrios
  SET area_m2 = ST_Area(ST_Transform(wkb_geometry, 4326)::geography)
  WHERE wkb_geometry IS NOT NULL;
END;
$$;