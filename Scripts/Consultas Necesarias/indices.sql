CREATE INDEX ON barrios USING GIST (wkb_geometry);
CREATE INDEX ON municipios USING GIST (wkb_geometry);
CREATE INDEX ON provincias USING GIST (wkb_geometry);
CREATE INDEX ON distritos USING GIST (wkb_geometry);
CREATE INDEX ON secciones USING GIST (wkb_geometry);
