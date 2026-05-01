# Hotel Revenue Analytics
End-to-end analytics project built on a hotel reservations dataset. 
Covers the full pipeline from raw data normalization to an interactive dashboard.

## Stack
- **Python** — data cleaning, normalization, and dimensional model generation
- **Looker** — semantic layer, LookML modeling, MoM pipeline
- **Looker Studio** — interactive dashboard

## Data Model
Star schema with one fact table and four dimensions:
- `H_RESERVA` — fact table with 10,000 reservation records
- `D_TIEMPO` — date dimension
- `D_CANAL` — booking channel dimension
- `D_TIPO_HABITACION` — room type dimension
- `D_CLIENTES` — synthetically generated customer dimension

## ETL
The raw dataset is a public hotel reservations CSV. The normalization 
script (`ETL/normalizar.py`) handles:
- Column renaming and type casting
- Date construction from separate year/month/day columns
- Revenue calculation (`precio_medio × total_noches`)
- Generation of `D_CANAL`, `D_TIPO_HABITACION`, and `D_CLIENTES` dimensions

The customer dimension uses a probabilistic assignment to simulate 
realistic recurrence rates, since natural recurrence in the dataset 
was insufficient for meaningful analysis.

## Looker
- Star schema modeled in LookML
- MoM (Month-over-Month) comparison pipeline built with 4 chained NDTs
- PDT (Persistent Derived Table) pre-aggregating revenue metrics by room type
- 20+ measures across revenue, operations, and customer behavior

## Dashboard
Built in Looker Studio with 4 pages:
- **Resumen Ejecutivo** — KPIs, revenue trends, and channel breakdown
- **Operaciones y Comportamiento** — operational metrics and segmentation
- **Vista Detalle** — cross-dimensional matrix and reservation-level table
- **Histórico** — full reservation log for ad hoc analysis

## Dataset
Based on a public hotel reservations dataset. 
Original source: [Hotel Reservations Dataset](https://www.kaggle.com/datasets/ahsan81/hotel-reservations-classification-dataset)
