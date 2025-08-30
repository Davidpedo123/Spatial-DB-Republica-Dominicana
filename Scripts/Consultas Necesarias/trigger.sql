
CREATE TRIGGER trigger_actualizar_area_m2_secciones
BEFORE INSERT OR UPDATE ON secciones
FOR EACH ROW EXECUTE FUNCTION actualizar_area_m2();


CREATE TRIGGER trigger_actualizar_area_m2_lotes
BEFORE INSERT OR UPDATE ON barrios
FOR EACH ROW EXECUTE FUNCTION actualizar_area_m2();


CREATE TRIGGER trigger_actualizar_area_m2_parcelas
BEFORE INSERT OR UPDATE ON municipios
FOR EACH ROW EXECUTE FUNCTION actualizar_area_m2();
