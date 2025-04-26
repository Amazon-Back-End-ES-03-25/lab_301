![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# LAB | SQL Normalización, DDL y Agregación

### Instrucciones

1. Haz un fork de este repositorio.
2. Clona tu fork en tu máquina local.
3. Resuelve los ejercicios a continuación.

## Entregables

- Cuando termines, añade tu solución a git.
- Haz commit de los cambios y súbelos a tu repositorio en GitHub.
- Crea un pull request y pega el enlace del PR en el campo de entrega del Student Portal.

## Ejercicio 1: Normalizar una base de datos de blogs

**Paso 1:** A partir del siguiente conjunto de datos sin normalizar, identifica redundancias y normalízalo (al menos hasta 3FN).

<br>

| **author**          | **title**                       | **word_count** | **views** |
|----------------|-----------------------------|------------|-------|
| Maria Charlotte  | Best Paint Colors             | 814              | 14      |
| Juan Perez       | Small Space Decorating Tips   | 1146             | 221     |
| Maria Charlotte  | Hot Accessories               | 986              | 105     |
| Maria Charlotte  | Mixing Textures               | 765              | 22      |
| Juan Perez       | Kitchen Refresh               | 1242             | 307     |
| Maria Charlotte  | Homemade Art Hacks            | 1002             | 193     |
| Gemma Alcocer    | Refinishing Wood Floors       | 1571             | 7542    |

<br>

**Paso 2:** Escribe los scripts DDL (`CREATE TABLE`) para implementar tu esquema normalizado.

**Paso 3 (Opcional):** Inserta los datos de ejemplo usando `INSERT INTO`.

## Ejercicio 2: Normalizar una base de datos de vuelos

**Paso 1:** Normaliza el siguiente conjunto de datos (mínimo hasta 3FN):

<br>

| **Customer Name**    | **Customer Status** | **Flight Number** | **Aircraft**    | **Total Aircraft Seats** | **Flight Mileage** | **Total Customer Mileage** |
| ---------------- | --------------- | ------------- | ----------- | -------------------- | -------------- | ---------------------- |
| Agustine Riviera | Silver          | DL143         | Boeing 747  | 400                  | 135            | 115235                 |
| Agustine Riviera | Silver          | DL122         | Airbus A330 | 236                  | 4370           | 115235                 |
| Alaina Sepulvida | None            | DL122         | Airbus A330 | 236                  | 4370           | 6008                   |
| Agustine Riviera | Silver          | DL143         | Boeing 747  | 400                  | 135            | 115235                 |
| Tom Jones        | Gold            | DL122         | Airbus A330 | 236                  | 4370           | 205767                 |
| Tom Jones        | Gold            | DL53          | Boeing 777  | 264                  | 2078           | 205767                 |
| Agustine Riviera | Silver          | DL143         | Boeing 747  | 400                  | 135            | 115235                 |
| Sam Rio          | None            | DL143         | Boeing 747  | 400                  | 135            | 2653                   |
| Agustine Riviera | Silver          | DL143         | Boeing 747  | 400                  | 135            | 115235                 |
| Tom Jones        | Gold            | DL222         | Boeing 777  | 264                  | 1765           | 205767                 |
| Jessica James    | Silver          | DL143         | Boeing 747  | 400                  | 135            | 127656                 |
| Sam Rio          | None            | DL143         | Boeing 747  | 400                  | 135            | 2653                   |
| Ana Janco        | Silver          | DL222         | Boeing 777  | 264                  | 1765           | 136773                 |
| Jennifer Cortez  | Gold            | DL222         | Boeing 777  | 264                  | 1765           | 300582                 |
| Jessica James    | Silver          | DL122         | Airbus A330 | 236                  | 4370           | 127656                 |
| Sam Rio          | None            | DL37          | Boeing 747  | 400                  | 531            | 2653                   |
| Christian Janco  | Silver          | DL222         | Boeing 777  | 264                  | 1765           | 14642                  |

<br>

**Paso 2:** Identifica las dependencias funcionales y descompón el esquema en tablas más pequeñas relacionadas:
- `customers`
- `flights`
- `aircrafts`
- `bookings`

**Paso 3:** Escribe los scripts DDL (`CREATE TABLE` + claves foráneas).

**Paso 4:** Inserta los datos de ejemplo.

## Ejercicio 3: Consultas SQL sobre la base de datos de vuelos

Usa el esquema que creaste en el ejercicio 2 para responder lo siguiente:

1. Número total de vuelos:
```sql
SELECT COUNT(DISTINCT flight_number) FROM flights;
```

2. Distancia media de los vuelos:
```sql
SELECT AVG(mileage) FROM flights;
```

3. Número medio de plazas por avión:
```sql
SELECT AVG(total_seats) FROM aircrafts;
```

4. Millas medias recorridas por los clientes, agrupadas por estado:
```sql
SELECT status, AVG(total_mileage) FROM customers GROUP BY status;
```

5. Máximo de millas recorridas por clientes, agrupadas por estado:
```sql
SELECT status, MAX(total_mileage) FROM customers GROUP BY status;
```

6. Número de aviones con el nombre \"Boeing\":
```sql
SELECT COUNT(*) FROM aircrafts WHERE name LIKE '%Boeing%';
```

7. Vuelos con distancia entre 300 y 2000 millas:
```sql
SELECT * FROM flights WHERE mileage BETWEEN 300 AND 2000;
```

8. Distancia media de vuelos **reservados**, agrupada por estado del cliente:
```sql
SELECT c.status, AVG(f.mileage)
FROM bookings b
JOIN customers c ON b.customer_id = c.id
JOIN flights f ON b.flight_number = f.flight_number
GROUP BY c.status;
```

9. Avión más reservado por miembros con estado Gold:
```sql
SELECT a.name, COUNT(*) AS total_bookings
FROM bookings b
JOIN customers c ON b.customer_id = c.id
JOIN flights f ON b.flight_number = f.flight_number
JOIN aircrafts a ON f.aircraft_id = a.id
WHERE c.status = 'Gold'
GROUP BY a.name
ORDER BY total_bookings DESC
LIMIT 1;
```

## Reto Extra

- Crea diagramas ERD para visualizar ambos esquemas.
- Usa restricciones `CHECK`, `NOT NULL` y `UNIQUE` donde sea apropiado.
- Añade índices (`INDEX`) donde creas que puede mejorar el rendimiento.

<br>

**¡Disfruta del análisis de datos con SQL!** :dart:
