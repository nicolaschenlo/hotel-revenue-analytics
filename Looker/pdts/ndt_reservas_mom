include: "/views/logic/proyecto/h_reservas.view.lkml"
#----------------------------------------------------------------------------------
# FILE: NDT RESERVAS YOY VIEWS
#
# Purpose: Define dos capas de NDTs para obtener las reservas YoY por id_cliente, id_tipo_habitacion, id_canal, fecha_llegada, fecha_salida
#
# Pipeline:[{ndt_reservas_tm}] + [{ndt_reservas_lm}]
#   --> [{ndt_reservas_mom_aux}] (Full Outer Join materialization)
#   --> [{ndt_reservas_mom}] (Final persisted NDT)
#
# Grain: id_cliente, id_tipo_habitacion, id_canal, fecha_llegada, fecha_salida
#----------------------------------------------------------------------------------

# =================================================================================
# VIEW: ndt_reservas_tm (STEP 1 -- Año actual)
#
# GENERA LA CTE PARA AÑO ACTUAL
# =================================================================================
view: ndt_reservas_tm {
  extends: [h_reservas]
  derived_table: {
    explore_source: reservas {
      column: fecha_llegada {field: reservas.fecha_llegada_date}
      column: id_cliente {}
      column: id_tipo_habitacion {}
      column: id_canal {}
      column: adultos {}
      column: ninios {}
      column: noches_semana {}
      column: noches_finde {}
      column: precio_medio {}
      column: parking {}
      column: ind_habitual {}
      column: ind_cancelada {}
      column: cancelaciones_previas {}
      column: estancias_previas {}
      column: antelacion_reserva {}
      column: peticiones_especiales {}
      column: venta {}
      column: id_reserva {}
      column: total_reservas_tm {field: reservas.total_reservas}
      column: total_ventas_tm {field: reservas.total_ventas}
      column: total_huespedes_tm {field: reservas.total_huespedes}
      column: total_clientes_tm {field: reservas.total_clientes}
      column: total_cancelaciones_tm {field: reservas.total_cancelaciones}
      #column: porc_cancelacion_tm {field: reservas.porc_cancelacion}
      column: adr_tm {field: reservas.adr}
      column: estancia_media_tm {field: reservas.estancia_media}
      column: antelacion_media_tm {field: reservas.antelacion_media}
      column: ventas_netas_tm {field: reservas.ventas_netas}
      column: ventas_perdidas_tm {field: reservas.ventas_perdidas}
      #column: venta_media_cliente_tm {field: reservas.venta_media_cliente}
      #column: venta_media_huesped_tm {field: reservas.venta_media_huesped}
      #column: venta_media_reserva_tm {field: reservas.venta_media_reserva}
      column: reservas_familiares_tm {field: reservas.reservas_familiares}
      #column: porc_familiares_tm {field: reservas.porc_familiares}
      #column: porc_finde_tm {field: reservas.porc_finde}
      #column: huespedes_medios_reserva_tm {field: reservas.huespedes_medios_reserva}
    }
  }

  # ---------------------------------------------------------------
  # HECHOS AGREGADOS RESULTANTES DE AUMENTAR EL GRANO DE LA TABLA
  # ---------------------------------------------------------------
  dimension: total_reservas_tm {
    hidden: yes
    type: number
  }
  dimension: total_ventas_tm {
    hidden: yes
    type: number
  }
  dimension: total_huespedes_tm {
    hidden: yes
    type: number
  }
  dimension: total_clientes_tm {
    hidden: yes
    type: number
  }
  dimension: total_cancelaciones_tm {
    hidden: yes
    type: number
  }
  dimension: adr_tm {
    hidden: yes
    type: number
  }
  dimension: estancia_media_tm {
    hidden: yes
    type: number
  }
  dimension: antelacion_media_tm {
    hidden: yes
    type: number
  }
  dimension: ventas_netas_tm {
    hidden: yes
    type: number
  }
  dimension: ventas_perdidas_tm {
    hidden: yes
    type: number
  }
  dimension: reservas_familiares_tm {
    hidden: yes
    type: number
  }

  # ---------------------------------------------------------------
  # Medidas TY Agregadas
  # ---------------------------------------------------------------
  measure: total_reservas {
    type: sum
    sql: ${total_reservas_tm} ;;
  }
  measure: total_ventas {
    type: sum
    sql: ${total_ventas_tm} ;;
  }
  measure: total_huespedes {
    type: sum
    sql: ${total_huespedes_tm} ;;
  }
  measure: total_clientes {
    type: sum
    sql: ${total_clientes_tm} ;;
  }
  measure: total_cancelaciones {
    type: sum
    sql: ${total_cancelaciones_tm} ;;
  }
  measure: adr {
    type: average
    sql: ${adr_tm} ;;
  }
  measure: estancia_media {
    type: average
    sql: ${estancia_media_tm} ;;
  }
  measure: antelacion_media {
    type: average
    sql: ${antelacion_media_tm} ;;
  }
  measure: ventas_netas {
    type: sum
    sql: ${ventas_netas_tm} ;;
  }
  measure: ventas_perdidas {
    type: sum
    sql: ${ventas_perdidas_tm} ;;
  }
  measure: reservas_familiares {
    type: sum
    sql: ${reservas_familiares_tm} ;;
  }
}

# =================================================================================
# VIEW: ndt_reservas_lm (STEP 2 -- Año Anterior)
#
# GENERA LA CTE PARA AÑO ANTERIOR
# =================================================================================
view: ndt_reservas_lm {
  extends: [h_reservas]
  derived_table: {
    explore_source: reservas_lm {
      column: fecha_llegada {field: d_fecha.FECHA}
      column: id_cliente {}
      column: id_tipo_habitacion {}
      column: id_canal {}
      column: adultos {}
      column: ninios {}
      column: noches_semana {}
      column: noches_finde {}
      column: precio_medio {}
      column: parking {}
      column: ind_habitual {}
      column: ind_cancelada {}
      column: cancelaciones_previas {}
      column: estancias_previas {}
      column: antelacion_reserva {}
      column: peticiones_especiales {}
      column: venta {}
      column: id_reserva {}
      column: reservas_lm {field: reservas.total_reservas}
      column: ventas_lm {field: reservas.total_ventas}
      column: huespedes_lm {field: reservas.total_huespedes}
      column: clientes_lm {field: reservas.total_clientes}
      column: cancelaciones_lm {field: reservas.total_cancelaciones}
      #column: rc_cancelacion_lm {field: reservas.porc_cancelacion}
      column: lyadr_lm {field: reservas.adr}
      column: est_media_lm {field: reservas.estancia_media}
      column: ant_media_lm {field: reservas.antelacion_media}
      column: netas_lm {field: reservas.ventas_netas}
      column: perdidas_lm {field: reservas.ventas_perdidas}
      #column: media_cliente_lm {field: reservas.venta_media_cliente}
      #column: media_huesped_lm {field: reservas.venta_media_huesped}
      #column: media_reserva_lm {field: reservas.venta_media_reserva}
      column: familiares_lm {field: reservas.reservas_familiares}
      #column: rc_familiares_lm {field: reservas.porc_familiares}
      #column: rc_finde_lm {field: reservas.porc_finde}
      #column: medios_reserva_lm {field: reservas.huespedes_medios_reserva}
    }
  }

  # ---------------------------------------------------------------
  # HECHOS AGREGADOS RESULTANTES DE AUMENTAR EL GRANO DE LA TABLA
  # ---------------------------------------------------------------
  dimension: reservas_lm {
    hidden: yes
    type: number
  }
  dimension: ventas_lm {
    hidden: yes
    type: number
  }
  dimension: huespedes_lm {
    hidden: yes
    type: number
  }
  dimension: clientes_lm {
    hidden: yes
    type: number
  }
  dimension: cancelaciones_lm {
    hidden: yes
    type: number
  }
  dimension: lyadr_lm {
    hidden: yes
    type: number
  }
  dimension: est_media_lm {
    hidden: yes
    type: number
  }
  dimension: ant_media_lm {
    hidden: yes
    type: number
  }
  dimension: netas_lm {
    hidden: yes
    type: number
  }
  dimension: perdidas_lm {
    hidden: yes
    type: number
  }
  dimension: familiares_lm {
    hidden: yes
    type: number
  }

  # ---------------------------------------------------------------
  # Medidas LY Agregadas
  # ---------------------------------------------------------------
  measure: total_reservas_lm {
    type: sum
    sql: ${reservas_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: total_ventas_lm {
    type: sum
    sql: ${ventas_lm} ;;
    value_format_name: "eur"
  }
  measure: total_huespedes_lm {
    type: sum
    sql: ${huespedes_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: total_clientes_lm {
    type: sum
    sql: ${clientes_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: total_cancelaciones_lm {
    type: sum
    sql: ${cancelaciones_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: adr_lm {
    type: average
    sql: ${lyadr_lm} ;;
    value_format_name: "eur"
  }
  measure: estancia_media_lm {
    type: average
    sql: ${est_media_lm} ;;
    value_format_name: "decimal_2"
  }
  measure: antelacion_media_lm {
    type: average
    sql: ${ant_media_lm} ;;
    value_format_name: "decimal_2"
  }
  measure: ventas_netas_lm {
    type: sum
    sql: ${netas_lm} ;;
    value_format_name: "eur"
  }
  measure: ventas_perdidas_lm {
    type: sum
    sql: ${perdidas_lm} ;;
    value_format_name: "eur"
  }
  measure: reservas_familiares_lm {
    type: sum
    sql: ${familiares_lm} ;;
    value_format_name: "decimal_0"
  }
}

# =================================================================================
# VIEW: ndt_reservas_mom_aux (STEP 3 -- FULL OUTER JOIN)
#
# JOIN ENTRE AÑO ACTUAL Y ANTERIOR.
# SE REDEFINE EL GRANO PARA RESOLVER TY Y LY EN UNA FILA PARA CADA
# COMBINACION MEDIANTE COALESCE
# =================================================================================
view: ndt_reservas_mom_aux {
  fields_hidden_by_default: yes
  extends: [h_reservas]
  derived_table: {
    explore_source: ndt_reservas_mom_aux {
      column: fecha_llegada_tm {field: ndt_reservas_mom_aux.fecha_llegada_date}
      column: fecha_llegada_lm {field: ndt_reservas_lm.fecha_llegada_date}
      column: id_cliente_tm {field: ndt_reservas_mom_aux.id_cliente}
      column: id_cliente_lm {field: ndt_reservas_lm.id_cliente}
      column: id_tipo_habitacion_tm {field: ndt_reservas_mom_aux.id_tipo_habitacion}
      column: id_tipo_habitacion_lm {field: ndt_reservas_lm.id_tipo_habitacion}
      column: id_canal_tm {field: ndt_reservas_mom_aux.id_canal}
      column: id_canal_lm {field: ndt_reservas_lm.id_canal}
      column: adultos_tm {field: ndt_reservas_mom_aux.adultos}
      column: adultos_lm {field: ndt_reservas_lm.adultos}
      column: ninios_tm {field: ndt_reservas_mom_aux.ninios}
      column: ninios_lm {field: ndt_reservas_lm.ninios}
      column: noches_semana_tm {field: ndt_reservas_mom_aux.noches_semana}
      column: noches_semana_lm {field: ndt_reservas_lm.noches_semana}
      column: noches_finde_tm {field: ndt_reservas_mom_aux.noches_finde}
      column: noches_finde_lm {field: ndt_reservas_lm.noches_finde}
      column: precio_medio_tm {field: ndt_reservas_mom_aux.precio_medio}
      column: precio_medio_lm {field: ndt_reservas_lm.precio_medio}
      column: parking_tm {field: ndt_reservas_mom_aux.parking}
      column: parking_lm {field: ndt_reservas_lm.parking}
      column: ind_habitual_tm {field: ndt_reservas_mom_aux.ind_habitual}
      column: ind_habitual_lm {field: ndt_reservas_lm.ind_habitual}
      column: ind_cancelada_tm {field: ndt_reservas_mom_aux.ind_cancelada}
      column: ind_cancelada_lm {field: ndt_reservas_lm.ind_cancelada}
      column: cancelaciones_previas_tm {field: ndt_reservas_mom_aux.cancelaciones_previas}
      column: cancelaciones_previas_lm {field: ndt_reservas_lm.cancelaciones_previas}
      column: estancias_previas_tm {field: ndt_reservas_mom_aux.estancias_previas}
      column: estancias_previas_lm {field: ndt_reservas_lm.estancias_previas}
      column: antelacion_reserva_tm {field: ndt_reservas_mom_aux.antelacion_reserva}
      column: antelacion_reserva_lm {field: ndt_reservas_lm.antelacion_reserva}
      column: peticiones_especiales_tm {field: ndt_reservas_mom_aux.peticiones_especiales}
      column: peticiones_especiales_lm {field: ndt_reservas_lm.peticiones_especiales}
      column: venta_tm {field: ndt_reservas_mom_aux.venta}
      column: venta_lm {field: ndt_reservas_lm.venta}
      column: id_reserva_tm {field: ndt_reservas_mom_aux.id_reserva}
      column: id_reserva_lm {field: ndt_reservas_lm.id_reserva}
      column: total_reservas_tm {field: ndt_reservas_mom_aux.total_reservas}
      column: reservas_lm {field: ndt_reservas_lm.reservas_lm}
      column: total_ventas_tm {field: ndt_reservas_mom_aux.total_ventas}
      column: ventas_lm {field: ndt_reservas_lm.total_ventas_lm}
      column: total_huespedes_tm {field: ndt_reservas_mom_aux.total_huespedes}
      column: huespedes_lm {field: ndt_reservas_lm.total_huespedes_lm}
      column: total_clientes_tm {field: ndt_reservas_mom_aux.total_clientes}
      column: clientes_lm {field: ndt_reservas_lm.total_clientes_lm}
      column: total_cancelaciones_tm {field: ndt_reservas_mom_aux.total_cancelaciones}
      column: cancelaciones_lm {field: ndt_reservas_lm.total_cancelaciones}
      #column: porc_cancelacion_tm {field: ndt_reservas_mom_aux.porc_cancelacion}
      #column: rc_cancelacion_lm {field: ndt_reservas_lm.porc_cancelacion_lm}
      column: adr_tm {field: ndt_reservas_mom_aux.adr}
      column: lyadr_lm {field: ndt_reservas_lm.adr_lm}
      column: estancia_media_tm {field: ndt_reservas_mom_aux.estancia_media}
      column: est_media_lm {field: ndt_reservas_lm.estancia_media_lm}
      column: antelacion_media_tm {field: ndt_reservas_mom_aux.antelacion_media}
      column: ant_media_lm {field: ndt_reservas_lm.antelacion_media_lm}
      column: ventas_netas_tm {field: ndt_reservas_mom_aux.ventas_netas}
      column: netas_lm {field: ndt_reservas_lm.ventas_netas_lm}
      column: ventas_perdidas_tm {field: ndt_reservas_mom_aux.ventas_perdidas}
      column: perdidas_lm {field: ndt_reservas_lm.ventas_perdidas_lm}
      #column: venta_media_cliente_tm {field: ndt_reservas_mom_aux.venta_media_cliente}
      #column: media_cliente_lm {field: ndt_reservas_lm.venta_media_cliente_lm}
      #column: venta_media_huesped_tm {field: ndt_reservas_mom_aux.venta_media_huesped}
      #column: media_huesped_lm {field: ndt_reservas_lm.venta_media_huesped_lm}
      #column: venta_media_reserva_tm {field: ndt_reservas_mom_aux.venta_media_reserva}
      #column: media_reserva_lm {field: ndt_reservas_lm.venta_media_reserva_lm}
      column: reservas_familiares_tm {field: ndt_reservas_mom_aux.reservas_familiares}
      column: familiares_lm {field: ndt_reservas_lm.reservas_familiares_lm}
      #column: porc_familiares_tm {field: ndt_reservas_mom_aux.porc_familiares}
      #column: rc_familiares_lm {field: ndt_reservas_lm.porc_familiares_lm}
      #column: porc_finde_tm {field: ndt_reservas_mom_aux.porc_finde}
      #column: rc_finde_lm {field: ndt_reservas_lm.porc_finde_lm}
      #column: huespedes_medios_reserva_tm {field: ndt_reservas_mom_aux.huespedes_medios_reserva}
      #column: medios_reserva_lm {field: ndt_reservas_lm.huespedes_medios_reserva_lm}
    }
  }

  # ---------------------------------------------------------------
  # DIMENSIONES AUXILIARES RESULTANTES DEL FULL OUTER JOIN
  # ---------------------------------------------------------------
      dimension: fecha_llegada_tm {}
      dimension: fecha_llegada_lm {}
      dimension: id_cliente_tm {}
      dimension: id_cliente_lm {}
      dimension: id_tipo_habitacion_tm {}
      dimension: id_tipo_habitacion_lm {}
      dimension: id_canal_tm {}
      dimension: id_canal_lm {}
      dimension: adultos_tm {}
      dimension: adultos_lm {}
      dimension: ninios_tm {}
      dimension: ninios_lm {}
      dimension: noches_semana_tm {}
      dimension: noches_semana_lm {}
      dimension: noches_finde_tm {}
      dimension: noches_finde_lm {}
      dimension: precio_medio_tm {}
      dimension: precio_medio_lm {}
      dimension: parking_tm {}
      dimension: parking_lm {}
      dimension: ind_habitual_tm {}
      dimension: ind_habitual_lm {}
      dimension: ind_cancelada_tm {}
      dimension: ind_cancelada_lm {}
      dimension: cancelaciones_previas_tm {}
      dimension: cancelaciones_previas_lm {}
      dimension: estancias_previas_tm {}
      dimension: estancias_previas_lm {}
      dimension: antelacion_reserva_tm {}
      dimension: antelacion_reserva_lm {}
      dimension: peticiones_especiales_tm {}
      dimension: peticiones_especiales_lm {}
      dimension: venta_tm {}
      dimension: venta_lm {}
      dimension: id_reserva_tm {}
      dimension: id_reserva_lm {}

  # ---------------------------------------------------------------
  # HECHOS AGREGADOS RESULTANTES DE AUMENTAR EL GRANO DE LA TABLA
  # ---------------------------------------------------------------
      dimension: total_reservas_tm {}
      dimension: reservas_lm {
        type: number
      }
      dimension: total_ventas_tm {}
      dimension: ventas_lm {}
      dimension: total_huespedes_tm {}
      dimension: huespedes_lm {}
      dimension: total_clientes_tm {}
      dimension: clientes_lm {}
      dimension: total_cancelaciones_tm {}
      dimension: cancelaciones_lm {}
      dimension: adr_tm {}
      dimension: lyadr_lm {}
      dimension: estancia_media_tm {}
      dimension: est_media_lm {}
      dimension: antelacion_media_tm {}
      dimension: ant_media_lm {}
      dimension: ventas_netas_tm {}
      dimension: netas_lm {}
      dimension: ventas_perdidas_tm {}
      dimension: perdidas_lm {}
      dimension: reservas_familiares_tm {}
      dimension: familiares_lm {}

  # ---------------------------------------------------------------
  # SE REDEFINE EL GRANO FINAL PARA TENER UN ÚNICO VALOR
  # DE CADA HECHO POR CADA COMBINACIÓN UNICA DEL GRANO
  # ---------------------------------------------------------------
  dimension: fecha_llegada {
    sql: COALESCE(${fecha_llegada_tm}, ${fecha_llegada_lm}) ;;
  }
  dimension: id_cliente {
    sql: COALESCE(${id_cliente_tm}, ${id_cliente_lm}) ;;
  }
  dimension: id_tipo_habitacion {
    sql: COALESCE(${id_tipo_habitacion_tm}, ${id_tipo_habitacion_lm}) ;;
  }
  dimension: id_canal {
    sql: COALESCE(${id_canal_tm}, ${id_canal_lm}) ;;
  }
  dimension: adultos {
    sql: COALESCE(${adultos_tm}, ${adultos_lm}) ;;
  }
  dimension: ninios {
    sql: COALESCE(${ninios_tm}, ${ninios_lm}) ;;
  }
  dimension: noches_semana {
    sql: COALESCE(${noches_semana_tm}, ${noches_semana_lm}) ;;
  }
  dimension: noches_finde {
    sql: COALESCE(${noches_finde_tm}, ${noches_finde_lm}) ;;
  }
  dimension: precio_medio {
    sql: COALESCE(${precio_medio_tm}, ${precio_medio_lm}) ;;
  }
  dimension: parking {
    sql: COALESCE(${parking_tm}, ${parking_lm}) ;;
  }
  dimension: ind_habitual {
    sql: COALESCE(${ind_habitual_tm}, ${ind_habitual_lm}) ;;
  }
  dimension: ind_cancelada {
    sql: COALESCE(${ind_cancelada_tm}, ${ind_cancelada_lm}) ;;
  }
  dimension: cancelaciones_previas {
    sql: COALESCE(${cancelaciones_previas_tm}, ${cancelaciones_previas_lm}) ;;
  }
  dimension: estancias_previas {
    sql: COALESCE(${estancias_previas_tm}, ${estancias_previas_lm}) ;;
  }
  dimension: antelacion_reserva {
    sql: COALESCE(${antelacion_reserva_tm}, ${antelacion_reserva_lm}) ;;
  }
  dimension: peticiones_especiales {
    sql: COALESCE(${peticiones_especiales_tm}, ${peticiones_especiales_lm}) ;;
  }
  dimension: venta {
    sql: COALESCE(${venta_tm}, ${venta_lm}) ;;
  }
  dimension: id_reserva {
    sql: COALESCE(${id_reserva_tm}, ${id_reserva_lm}) ;;
  }

  # ---------------------------------------------------------------
  # Medidas TY Agregadas
  # ---------------------------------------------------------------
  measure: total_reservas {
    type: sum
    sql: ${total_reservas_tm} ;;
  }
  measure: total_ventas {
    type: sum
    sql: ${total_ventas_tm} ;;
  }
  measure: total_huespedes {
    type: sum
    sql: ${total_huespedes_tm} ;;
  }
  measure: total_clientes {
    type: sum
    sql: ${total_clientes_tm} ;;
  }
  measure: total_cancelaciones {
    type: sum
    sql: ${total_cancelaciones_tm} ;;
  }
  measure: adr {
    type: average
    sql: ${adr_tm} ;;
  }
  measure: estancia_media {
    type: average
    sql: ${estancia_media_tm} ;;
  }
  measure: antelacion_media {
    type: average
    sql: ${antelacion_media_tm} ;;
  }
  measure: ventas_netas {
    type: sum
    sql: ${ventas_netas_tm} ;;
  }
  measure: ventas_perdidas {
    type: sum
    sql: ${ventas_perdidas_tm} ;;
  }
  measure: reservas_familiares {
    type: sum
    sql: ${reservas_familiares_tm} ;;
  }

  # ---------------------------------------------------------------
  # Medidas LY Agregadas
  # ---------------------------------------------------------------
  measure: total_reservas_lm {
    type: sum
    sql: ${reservas_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: total_ventas_lm {
    type: sum
    sql: ${ventas_lm} ;;
    value_format_name: "eur"
  }
  measure: total_huespedes_lm {
    type: sum
    sql: ${huespedes_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: total_clientes_lm {
    type: sum
    sql: ${clientes_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: total_cancelaciones_lm {
    type: sum
    sql: ${cancelaciones_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: adr_lm {
    type: average
    sql: ${lyadr_lm} ;;
    value_format_name: "eur"
  }
  measure: estancia_media_lm {
    type: average
    sql: ${est_media_lm} ;;
    value_format_name: "decimal_2"
  }
  measure: antelacion_media_lm {
    type: average
    sql: ${ant_media_lm} ;;
    value_format_name: "decimal_2"
  }
  measure: ventas_netas_lm {
    type: sum
    sql: ${netas_lm} ;;
    value_format_name: "eur"
  }
  measure: ventas_perdidas_lm {
    type: sum
    sql: ${perdidas_lm} ;;
    value_format_name: "eur"
  }
  measure: reservas_familiares_lm {
    type: sum
    sql: ${familiares_lm} ;;
    value_format_name: "decimal_0"
  }
}

# =================================================================================

# VIEW: ndt_reservas_mom (STEP 4 -- MATERIALIZACION)
#
# MATERIALIZACION PARA REDUCIR COSTES DE CONSULTA Y MEJORAR PERFORMANCE
# =================================================================================
view: ndt_reservas_mom {
  extends: [h_reservas]
  derived_table: {
    explore_source: ndt_reservas_mom {
      column: fecha_llegada {field: ndt_reservas_mom.fecha_llegada}
      column: id_cliente {}
      column: id_tipo_habitacion {}
      column: id_canal {}
      column: adultos {}
      column: ninios {}
      column: noches_semana {}
      column: noches_finde {}
      column: precio_medio {}
      column: parking {}
      column: ind_habitual {}
      column: ind_cancelada {}
      column: cancelaciones_previas {}
      column: estancias_previas {}
      column: antelacion_reserva {}
      column: peticiones_especiales {}
      column: venta {}
      column: id_reserva {}
      column: total_reservas_tm {field: ndt_reservas_mom.total_reservas}
      column: total_ventas_tm {field: ndt_reservas_mom.total_ventas}
      column: total_huespedes_tm {field: ndt_reservas_mom.total_huespedes}
      column: total_clientes_tm {field: ndt_reservas_mom.total_clientes}
      column: total_cancelaciones_tm {field: ndt_reservas_mom.total_cancelaciones}
      #column: porc_cancelacion_tm {field: ndt_reservas_mom.porc_cancelacion}
      column: adr_tm {field: ndt_reservas_mom.adr}
      column: estancia_media_tm {field: ndt_reservas_mom.estancia_media}
      column: antelacion_media_tm {field: ndt_reservas_mom.antelacion_media}
      column: ventas_netas_tm {field: ndt_reservas_mom.ventas_netas}
      column: ventas_perdidas_tm {field: ndt_reservas_mom.ventas_perdidas}
      #column: venta_media_cliente_tm {field: ndt_reservas_mom.venta_media_cliente}
      #column: venta_media_huesped_tm {field: ndt_reservas_mom.venta_media_huesped}
      #column: venta_media_reserva_tm {field: ndt_reservas_mom.venta_media_reserva}
      column: reservas_familiares_tm {field: ndt_reservas_mom.reservas_familiares}
      #column: porc_familiares_tm {field: ndt_reservas_mom.porc_familiares}
      #column: porc_finde_tm {field: ndt_reservas_mom.porc_finde}
      #column: huespedes_medios_reserva_tm {field: ndt_reservas_mom.huespedes_medios_reserva}
      column: reservas_lm {field: ndt_reservas_mom.total_reservas_lm}
      column: ventas_lm {field: ndt_reservas_mom.total_ventas_lm}
      column: huespedes_lm {field: ndt_reservas_mom.total_huespedes_lm}
      column: clientes_lm {field: ndt_reservas_mom.total_clientes_lm}
      column: cancelaciones_lm {field: ndt_reservas_mom.total_cancelaciones_lm}
      #column: rc_cancelacion_lm {field: ndt_reservas_mom.porc_cancelacion_lm}
      column: lyadr_lm {field: ndt_reservas_mom.adr_lm}
      column: est_media_lm {field: ndt_reservas_mom.estancia_media_lm}
      column: ant_media_lm {field: ndt_reservas_mom.antelacion_media_lm}
      column: netas_lm {field: ndt_reservas_mom.ventas_netas_lm}
      column: perdidas_lm {field: ndt_reservas_mom.ventas_perdidas_lm}
      #column: media_cliente_lm {field: ndt_reservas_mom.venta_media_cliente_lm}
      #column: media_huesped_lm {field: ndt_reservas_mom.venta_media_huesped_lm}
      #column: media_reserva_lm {field: ndt_reservas_mom.venta_media_reserva_lm}
      column: familiares_lm {field: ndt_reservas_mom.reservas_familiares_lm}
      #column: rc_familiares_lm {field: ndt_reservas_mom.porc_familiares_lm}
      #column: rc_finde_lm {field: ndt_reservas_mom.porc_finde_lm}
      #column: medios_reserva_lm {field: ndt_reservas_mom.huespedes_medios_reserva_lm}
    }
    datagroup_trigger: Alumno_14
    #cluster_keys: ["fecha_llegada"]
  }

  # ---------------------------------------------------------------
  # HECHOS AGREGADOS RESULTANTES DE AUMENTAR EL GRANO DE LA TABLA
  # ---------------------------------------------------------------
  dimension: total_reservas_tm {
    hidden: yes
    type: number
  }
  dimension: total_ventas_tm {
    hidden: yes
    type: number
  }
  dimension: total_huespedes_tm {
    hidden: yes
    type: number
  }
  dimension: total_clientes_tm {
    hidden: yes
    type: number
  }
  dimension: total_cancelaciones_tm {
    hidden: yes
    type: number
  }
  dimension: adr_tm {
    hidden: yes
    type: number
  }
  dimension: estancia_media_tm {
    hidden: yes
    type: number
  }
  dimension: antelacion_media_tm {
    hidden: yes
    type: number
  }
  dimension: ventas_netas_tm {
    hidden: yes
    type: number
  }
  dimension: ventas_perdidas_tm {
    hidden: yes
    type: number
  }
  dimension: reservas_familiares_tm {
    hidden: yes
    type: number
  }

  # ---------------------------------------------------------------
  # HECHOS AGREGADOS RESULTANTES DE AUMENTAR EL GRANO DE LA TABLA
  # ---------------------------------------------------------------
  dimension: reservas_lm {
    hidden: yes
    type: number
  }
  dimension: ventas_lm {
    hidden: yes
    type: number
  }
  dimension: huespedes_lm {
    hidden: yes
    type: number
  }
  dimension: clientes_lm {
    hidden: yes
    type: number
  }
  dimension: cancelaciones_lm {
    hidden: yes
    type: number
  }
  dimension: lyadr_lm {
    hidden: yes
    type: number
  }
  dimension: est_media_lm {
    hidden: yes
    type: number
  }
  dimension: ant_media_lm {
    hidden: yes
    type: number
  }
  dimension: netas_lm {
    hidden: yes
    type: number
  }
  dimension: perdidas_lm {
    hidden: yes
    type: number
  }
  dimension: familiares_lm {
    hidden: yes
    type: number
  }

  # ---------------------------------------------------------------
  # Medidas TY Agregadas
  # ---------------------------------------------------------------
  measure: total_reservas {
    type: sum
    sql: ${total_reservas_tm} ;;
  }
  measure: total_ventas {
    type: sum
    sql: ${total_ventas_tm} ;;
  }
  measure: total_huespedes {
    type: sum
    sql: ${total_huespedes_tm} ;;
  }
  measure: total_clientes {
    type: sum
    sql: ${total_clientes_tm} ;;
  }
  measure: total_cancelaciones {
    type: sum
    sql: ${total_cancelaciones_tm} ;;
  }
  measure: adr {
    type: average
    sql: ${adr_tm} ;;
  }
  measure: estancia_media {
    type: average
    sql: ${estancia_media_tm} ;;
  }
  measure: antelacion_media {
    type: average
    sql: ${antelacion_media_tm} ;;
  }
  measure: ventas_netas {
    type: sum
    sql: ${ventas_netas_tm} ;;
  }
  measure: ventas_perdidas {
    type: sum
    sql: ${ventas_perdidas_tm} ;;
  }
  measure: reservas_familiares {
    type: sum
    sql: ${reservas_familiares_tm} ;;
  }

  # ---------------------------------------------------------------
  # Medidas LY Agregadas
  # ---------------------------------------------------------------
  measure: total_reservas_lm {
    type: sum
    sql: ${reservas_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: total_ventas_lm {
    type: sum
    sql: ${ventas_lm} ;;
    value_format_name: "eur"
  }
  measure: total_huespedes_lm {
    type: sum
    sql: ${huespedes_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: total_clientes_lm {
    type: sum
    sql: ${clientes_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: total_cancelaciones_lm {
    type: sum
    sql: ${cancelaciones_lm} ;;
    value_format_name: "decimal_0"
  }
  measure: adr_lm {
    type: average
    sql: ${lyadr_lm} ;;
    value_format_name: "eur"
  }
  measure: estancia_media_lm {
    type: average
    sql: ${est_media_lm} ;;
    value_format_name: "decimal_2"
  }
  measure: antelacion_media_lm {
    type: average
    sql: ${ant_media_lm} ;;
    value_format_name: "decimal_2"
  }
  measure: ventas_netas_lm {
    type: sum
    sql: ${netas_lm} ;;
    value_format_name: "eur"
  }
  measure: ventas_perdidas_lm {
    type: sum
    sql: ${perdidas_lm} ;;
    value_format_name: "eur"
  }
  measure: reservas_familiares_lm {
    type: sum
    sql: ${familiares_lm} ;;
    value_format_name: "decimal_0"
  }

}
