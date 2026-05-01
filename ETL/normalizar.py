import pandas as pd
import random

# Leemos datos:
df = pd.read_csv('reservas.csv')

# Eliminamos columna 'type_of_meal_plan' porque no queremos esa dimensión:
df = df.drop(columns = ['type_of_meal_plan'], errors = 'ignore')

# Renombramos variables:
df = df.rename(columns = {
    'Booking_ID': 'id_reserva',
    'no_of_adults': 'adultos',
    'no_of_children': 'ninios',
    'no_of_weekend_nights': 'noches_finde',
    'no_of_week_nights': 'noches_semana',
    'required_car_parking_space': 'parking',
    'room_type_reserved': 'id_tipo_habitacion',
    'lead_time': 'antelacion_reserva',
    'arrival_year': 'anyo_llegada',
    'arrival_month': 'mes_llegada',
    'arrival_date': 'dia_llegada',
    'market_segment_type': 'canal_reserva',
    'repeated_guest': 'ind_habitual',
    'no_of_previous_cancellations': 'cancelaciones_previas',
    'no_of_previous_bookings_not_canceled': 'estancias_previas',
    'avg_price_per_room': 'precio_medio',
    'no_of_special_requests': 'peticiones_especiales',
    'booking_status': 'ind_cancelada'
})

# Transformamos variables:
#   'ind_cancelada' como booleano con 1 para 'Canceled' y 0 para 'Not_Canceled'
#   'anyo_llegada', 'mes_llegada' y 'dia_llegada' como una única columna de fecha
df['id_tipo_habitacion'] = df['id_tipo_habitacion'].str.replace('Room_Type ', '').astype(int)
df['ind_cancelada'] = df['ind_cancelada'].map({'Canceled': 1, 'Not_Canceled': 0})
df['fecha_llegada'] = pd.to_datetime(pd.DataFrame({
    'year': df['anyo_llegada'], 
    'month': df['mes_llegada'], 
    'day': df['dia_llegada']
}), errors = 'coerce') 
# errors = 'coerce' convierte fechas inválidas a NaT (Not a Time)

# Calculamos 'fecha_salida':
total_noches = df['noches_finde'] + df['noches_semana']
df['fecha_salida'] = df['fecha_llegada'] + pd.to_timedelta(total_noches, unit = 'd')

# Calculamos la columna de ingresos 'venta':
df['precio_medio'] = df['precio_medio'].round(2)
df['venta'] = total_noches * df['precio_medio']
df['venta'] = df['venta'].round(2) 
# .round(2) porque si no algunos valores no se guardan bien

# Reducimos el dataset a una muestra aleatoria de 10000 filas:
df = df.sample(n = 10000, random_state = 123)

# Sobreescribimos 'id_reserva' con un nuevo ID secuencial:
df['id_reserva'] = range(1, len(df) + 1)

# Generamos dimensión 'd_clientes':
pool_clientes = []
nuevo_id_cliente = 1
ids_asignados = []
for index, row in df.iterrows():
    ind_recurrente = row['ind_habitual'] == 1 or row['cancelaciones_previas'] > 0 or row['estancias_previas'] > 0 or random.random() < 0.30
    if ind_recurrente and len(pool_clientes) > 0:
        ids_asignados.append(random.choice(pool_clientes))
    else:
        ids_asignados.append(nuevo_id_cliente)
        pool_clientes.append(nuevo_id_cliente)
        nuevo_id_cliente += 1
df['id_cliente'] = ids_asignados
d_clientes = pd.DataFrame({'id_cliente': list(set(ids_asignados))})
nombres = ['Ana', 'Luis', 'Carlos', 'Maria', 'Elena', 'Jorge', 'Sara', 'David', 'Marta', 'Pablo']
apellidos = ['Garcia', 'Martinez', 'Lopez', 'Sanchez', 'Perez', 'Gomez', 'Martin', 'Ruiz']
d_clientes['desc_cliente'] = d_clientes['id_cliente'].apply(lambda x: f"{random.choice(nombres)} {random.choice(apellidos)}")
d_clientes['fecha_cliente'] = pd.to_datetime(pd.DataFrame({
    'year': [random.randint(1942, 1999) for _ in range(len(d_clientes))],
    'month': [random.randint(1, 12) for _ in range(len(d_clientes))],
    'day': [random.randint(1, 28) for _ in range(len(d_clientes))]
}))

# Generamos dimensión 'd_canal':
canales_unicos = df['canal_reserva'].unique()
desc_canales = {
    'Online': 'Agencias Online',
    'Offline': 'Agencias Offline',
    'Corporate': 'Corporativo',
    'Aviation': 'Aviación',
    'Complementary': 'Cortesía',
    'Direct': 'Venta Directa'
}
d_canal = pd.DataFrame({
    'id_canal': range(1, len(canales_unicos) + 1),
    'desc_canal': [desc_canales.get(c, f'{c}') for c in canales_unicos]
})
mapa_canales = dict(zip(canales_unicos, d_canal['id_canal']))
df['id_canal'] = df['canal_reserva'].map(mapa_canales)

# Generamos dimensión 'd_tipo_habitacion':
id_tipos = sorted(df['id_tipo_habitacion'].unique())
desc_tipos = {
    1: 'Individual', 
    2: 'Doble', 
    3: 'Triple', 
    4: 'Familiar', 
    5: 'Junior Suite', 
    6: 'Suite Ejecutiva', 
    7: 'Suite Presidencial'
}
d_tipo_habitacion = pd.DataFrame({
    'id_tipo_habitacion': id_tipos,
    'desc_habitacion': [desc_tipos.get(t, f'{t}') for t in id_tipos]
})

# Dropeamos columnas innecesarias:
df = df.drop(columns=['anyo_llegada', 'mes_llegada', 'dia_llegada', 'canal_reserva'])

# Exportamos a CSV la tabla de hechos y las de dimensiones:
df.to_csv('h_reservas.csv', index = False, encoding = 'utf-8-sig')
d_clientes.to_csv('d_clientes.csv', index = False, encoding = 'utf-8-sig')
d_canal.to_csv('d_canal.csv', index = False, encoding = 'utf-8-sig')
d_tipo_habitacion.to_csv('d_tipo_habitacion.csv', index = False, encoding = 'utf-8-sig')
# encoding porque los valores con tildes dan problemas
