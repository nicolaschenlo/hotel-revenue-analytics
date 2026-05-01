import pandas as pd

def generar_archivo_sql(df_input, table_name, file_name):
    """Genera un archivo .sql con un único INSERT masivo."""
    temp_df = df_input.copy()
    
    # Asegurar formato de fecha SQL estándar (YYYY-MM-DD)
    for col in temp_df.columns:
        if 'fecha' in col.lower():
            temp_df[col] = pd.to_datetime(temp_df[col]).dt.strftime('%Y-%m-%d')
    
    cols = ", ".join(temp_df.columns)
    values_list = []
    
    for _, row in temp_df.iterrows():
        row_vals = []
        for v in row.values:
            if pd.isna(v) or str(v).lower() == 'nat':
                row_vals.append("NULL")
            elif isinstance(v, (int, float)):
                row_vals.append(str(v))
            else:
                # Escapar comillas simples
                val_escapado = str(v).replace("'", "''")
                row_vals.append(f"'{val_escapado}'")
        values_list.append(f"({', '.join(row_vals)})")
    
    # Construcción de la sentencia final
    contenido_sql = f"INSERT INTO {table_name} ({cols})\nVALUES\n" + ",\n".join(values_list) + "\n;"
    
    # Escritura del archivo individual
    with open(file_name, 'w', encoding='utf-8-sig') as f:
        f.write(contenido_sql)
    print(f"Archivo creado: {file_name}")

def procesar_todos_los_inserts():
    try:
        # Carga de archivos fuente
        df_hechos = pd.read_csv('h_reservas.csv')
        df_clientes = pd.read_csv('d_clientes.csv')
        df_canales = pd.read_csv('d_canal.csv')
        df_habitaciones = pd.read_csv('d_tipo_habitacion.csv')

        # Generación de archivos individuales
        generar_archivo_sql(df_canales, 'd_canal', 'insert_d_canal.sql')
        generar_archivo_sql(df_habitaciones, 'd_tipo_habitacion', 'insert_d_tipo_habitacion.sql')
        generar_archivo_sql(df_clientes, 'd_clientes', 'insert_d_clientes.sql')
        generar_archivo_sql(df_hechos, 'h_reservas', 'insert_h_reservas.sql')

    except FileNotFoundError as e:
        print(f"Error: Asegúrate de tener los CSV en la carpeta. {e}")

if __name__ == "__main__":
    procesar_todos_los_inserts()