view: h_reservas {
  sql_table_name: "PUBLIC"."H_RESERVAS" ;;

  dimension: adultos {
    type: number
    sql: ${TABLE}."ADULTOS" ;;
  }
  dimension: antelacion_reserva {
    type: number
    sql: ${TABLE}."ANTELACION_RESERVA" ;;
  }
  dimension: cancelaciones_previas {
    type: number
    sql: ${TABLE}."CANCELACIONES_PREVIAS" ;;
  }
  dimension: estancias_previas {
    type: number
    sql: ${TABLE}."ESTANCIAS_PREVIAS" ;;
  }
  dimension_group: fecha_llegada {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."FECHA_LLEGADA" ;;
  }
  dimension: id_canal {
    type: number
    sql: ${TABLE}."ID_CANAL" ;;
  }
  dimension: id_cliente {
    type: number
    sql: ${TABLE}."ID_CLIENTE" ;;
  }
  dimension: id_reserva {
    type: number
    sql: ${TABLE}."ID_RESERVA" ;;
  }
  dimension: id_tipo_habitacion {
    type: number
    sql: ${TABLE}."ID_TIPO_HABITACION" ;;
  }
  dimension: ind_cancelada {
    type: number
    sql: ${TABLE}."IND_CANCELADA" ;;
  }
  dimension: ind_habitual {
    type: number
    sql: ${TABLE}."IND_HABITUAL" ;;
  }
  dimension: ninios {
    type: number
    sql: ${TABLE}."NINIOS" ;;
  }
  dimension: noches_finde {
    type: number
    sql: ${TABLE}."NOCHES_FINDE" ;;
  }
  dimension: noches_semana {
    type: number
    sql: ${TABLE}."NOCHES_SEMANA" ;;
  }
  dimension: parking {
    type: number
    sql: ${TABLE}."PARKING" ;;
  }
  dimension: peticiones_especiales {
    type: number
    sql: ${TABLE}."PETICIONES_ESPECIALES" ;;
  }
  dimension: precio_medio {
    type: number
    sql: ${TABLE}."PRECIO_MEDIO" ;;
  }
  dimension: venta {
    type: number
    sql: ${TABLE}."VENTA" ;;
  }
  measure: count {
    type: count
  }
}
