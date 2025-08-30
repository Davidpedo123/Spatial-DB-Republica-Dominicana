# Base de Datos Geoespacial de la República Dominicana

Esta repositorio contiene todo lo necesario para la **creación de una Base de Datos Geoespacial** de la República Dominicana.

---

## Estructura del proyecto

El proyecto está segmentado por diferentes niveles administrativos y puntos de interés:

### Provincias
![Provincias](example_data/example-provincias-data.png)

### Municipios
![Municipios](example_data/example-municipios-data.png)

### Distritos
![Distritos](example_data/example-distritos-data.png)

### Barrios, Secciones y Puntos de Interés
En este caso, se incluyen ejemplos de **hospitales** como puntos de interés.  
![Hospitales Cercanos](example_data/vista-HospitalesCerca.png)

---

## Funciones, Triggers y Vistas

Este proyecto incluye **diversas funciones nativas de PostGIS**, ideales para medir distancias, encontrar entidades cercanas y facilitar análisis geoespacial:

- **Distancia entre provincias**  
  Permite calcular la distancia en metros entre diversas provincias.  
  ![Distancia entre Provincias](example_data/func-DistanciaEntreProvincias.png)

- **Provincias más cercanas**  
  Permite encontrar las provincias más cercanas a otra.  
  ![Provincias Más Cercanas](example_data/func-provinciasMascercanas.png)  
  ![Visualización Geo](example_data/func-provinciasmascercasGEO.png)

---

> Este repositorio está pensado para desarrolladores y analistas que quieran trabajar con datos geoespaciales de la República Dominicana, utilizando PostGIS y SQL avanzado.
