include: "/views/base/proyecto/h_reservas.view.lkml"
#----------------------------------------------------------------------------------
# VIEW: h_reservas (LOGIC)
#
# Purpose: 1:1 mapping with the gold layer H_RESERVAS table. Exposes raw
# dimensions only -- no business logic, labels, or measures defined here.
# All labelling and logic is handled in the corresponding logic layer view.
#
# Source: H_RESERVAS
#
# Dimensions:
# - Campos de cruce con dimensiones: id_cliente, fecha_llegada, fecha_salida,
#                                    id_tipo_habitacion, id_canal
# - Hechos: id_reserva, adultos, ninios, noches_semana, noches_finde, precio_medio,
#           ind_parking, ind_habitual, ind_cancelada, cancelaciones_previas,
#           estancias_previas, antelacion_reserva, peticiones_especiales, venta
#----------------------------------------------------------------------------------
view: +h_reservas {
  label: "Reservas"

  #----------------------------------------------------------------------------------
  # Cross fields with dimensions
  #----------------------------------------------------------------------------------
  dimension: id_cliente {
    hidden: yes
  }
  dimension: id_tipo_habitacion {
    hidden: yes
  }
  dimension: id_canal {
    hidden: yes
  }
  dimension: fecha_llegada {
    hidden: yes
  }
  dimension: fecha_salida {
    hidden: yes
  }

  #----------------------------------------------------------------------------------
  # Facts
  #----------------------------------------------------------------------------------
  dimension: adultos {
    label: "Núm. Adultos"
    description: "Número de adultos de la reserva,."
  }
  dimension: ninios {
    label: "Núm. Niños"
    description: "Número de niños de la reserva."
  }
  dimension: noches_semana {
    label: "Núm. Noches Semana"
    description: "Número de noches de semana de la reserva."
  }
  dimension: noches_finde {
    label: "Núm. Noches Finde"
    description: "Número de noches de fin de semana de la reserva."
  }
  dimension: precio_medio {
    label: "Precio Medio"
    description: "Precio medio por noche de la reserva."
  }
  dimension: parking {
    label: "Ind. Parking"
    description: "Indicador de si el cliente ha solicitado parking (ind_parking = 1) o no (ind_parking = 0)."
  }
  dimension: ind_habitual {
    label: "Ind. Habitual"
    description: "Indicador de si el cliente es un cliente habitual (ind_habitual = 1) o no (ind_habitual = 0)."
  }
  dimension: ind_cancelada {
    label: "Ind. Cancelada"
    description: "Indicador de si la reserva ha sido cancelada (ind_cancelada = 1) o no (ind_cancelada = 0)."
  }
  dimension: cancelaciones_previas {
    label: "Núm. Cancelaciones Previas"
    description: "Número de reservas que previamente ha cancelado el cliente."
  }
  dimension: estancias_previas {
    label: "Núm. Estancias Previas"
    description: "Número de veces en las que el cliente se ha alojado previamente."
  }
  dimension: antelacion_reserva {
    label: "Antelación Reserva"
    description: "Antelación en días con la que se ha efectuado la reserva."
  }
  dimension: peticiones_especiales {
    label: "Núm. Peticiones Especiales"
    description: "Número de peticiones especiales que ha expresado el cliente. Por ejemplo habitación con bañera, cuna, etc."
  }
  dimension: venta {
    label: "Venta"
    description: "Precio total de la reserva. Se calcula multiplicando el precio medio por noche por el número de noches (incluyendo semana y fin de semana)."
  }
  dimension: id_reserva {
    label: "ID Reserva"
    description: "Identificador único de la reserva."
  }

  #----------------------------------------------------------------------------------
  # Measures
  #----------------------------------------------------------------------------------
  measure: total_reservas {
    label: "Total Reservas"
    description: "Número de reservas totales."
    type: count_distinct
    sql: ${id_reserva} ;;
    value_format_name: "decimal_0"
  }
  measure: total_ventas {
    label: "Total Ventas"
    description: "Suma de las ventas totales."
    type: sum
    sql: ${venta} ;;
    value_format_name: "eur"
  }
  measure: total_huespedes {
    label: "Total Huéspedes"
    description: "Suma de los huéspedes totales."
    type: sum
    sql: ${adultos} + ${ninios} ;;
    value_format_name: "decimal_0"
  }
  measure: total_clientes {
    label: "Total Clientes"
    description: "Suma de los clientes totales."
    type: count_distinct
    sql: ${id_cliente} ;;
    value_format_name: "decimal_0"
  }
  measure: total_cancelaciones {
    label: "Total Cancelaciones"
    description: "Número de cancelaciones totales."
    type: sum
    sql: ${ind_cancelada} ;;
    value_format_name: "decimal_0"
  }
  measure: porc_cancelacion {
    label: "% Cancelación"
    description: "Porcentaje de reservas canceladas."
    type: number
    sql: ${total_cancelaciones} / NULLIF(${total_reservas}, 0) ;;
    value_format_name: "percent_2"
  }
  measure: adr {
    label: "Tarifa Media Diaria"
    description: "Average Daily Rate, precio medio por noche."
    type: average
    sql: ${precio_medio} ;;
    value_format_name: "eur"
  }
  measure: estancia_media {
    label: "Estancia Media"
    description: "Estancia media por reserva."
    type: average
    sql: ${noches_finde} + ${noches_semana} ;;
    value_format_name: "decimal_2"
  }
  measure: antelacion_media {
    label: "Antelación Media"
    description: "Antelación media por reserva."
    type: average
    sql: ${antelacion_reserva} ;;
    value_format_name: "decimal_2"
  }
  measure: ventas_netas {
    label: "Ventas Netas"
    description: "Ventas sin incluír las de reservas que han sido canceladas."
    type: sum
    sql: ${venta} ;;
    value_format_name: "eur"
    filters: [ind_cancelada: "=0"]
  }
  measure: ventas_perdidas {
    label: "Ventas Perdidas"
    description: "Ventas de reservas que han sido canceladas."
    type: sum
    sql: ${venta} ;;
    value_format_name: "eur"
    filters: [ind_cancelada: "=1"]
  }
  measure: venta_media_cliente {
    label: "Ventas Medias Cliente"
    description: "Ventas medias por cliente."
    type: number
    sql: ${total_ventas} / NULLIF(${total_clientes}, 0) ;;
    value_format_name: "eur"
  }
  measure: venta_media_huesped {
    label: "Ventas Medias Huésped"
    description: "Ventas medias por huésped."
    type: number
    sql: ${total_ventas} / NULLIF(${total_huespedes}, 0) ;;
    value_format_name: "eur"
  }
  measure: venta_media_reserva {
    label: "Ventas Medias Reserva"
    description: "Ventas medias por reserva."
    type: number
    sql: ${total_ventas} / NULLIF(${total_reservas}, 0) ;;
    value_format_name: "eur"
  }
  measure: reservas_familiares {
    label: "Reservas Familiares"
    description: "Reservas en las que se alojan niños."
    type: count_distinct
    sql: ${id_reserva} ;;
    value_format_name: "decimal_0"
    #filters: [adultos: ">0"]
  }
  measure: porc_familiares {
    label: "% Familiares"
    description: "Porcentaje de reservas familiares."
    type: number
    sql: ${reservas_familiares} / NULLIF(${total_reservas}, 0) ;;
    value_format_name: "percent_2"
  }
  measure: porc_finde {
    label: "% Finde"
    description: "Porcentaje de noches reservadas que corresponden a fin de semana."
    type: number
    sql: SUM(${noches_finde}) / NULLIF(SUM(${noches_finde} + ${noches_semana}), 0) ;;
    value_format_name: "percent_2"
  }
  measure: huespedes_medios_reserva {
    label: "Huéspedes Medios Reserva"
    description: "Huéspedes medios por reserva."
    type: number
    sql: ${total_huespedes} / NULLIF(${total_reservas}, 0) ;;
    value_format_name: "decimal_2"
  }

  # System measure -- kept minimal in base layer
  measure: count {
    hidden: yes
  }
}
