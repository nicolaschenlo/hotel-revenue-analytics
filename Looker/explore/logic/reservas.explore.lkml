include: "/views/logic/proyecto/**.view.lkml"

#----------------------------------------------------------------------------------
# EXPLORE: reservas (LOGIC)
#
# Purpose: Explore básico del modelo de reservas
# Grain: FECHA, id_cliente, id_canal, id_tipo_habitacion

# Note: Todos los joins se definen como INNER para garantizar la integridad a través de las dimensiones.
#----------------------------------------------------------------------------------
explore: reservas {
  from: h_reservas
  label: "Reservas"

  #----------------------------------------------------------------------------------
  # Joins
  #----------------------------------------------------------------------------------
  join: d_fecha {
    view_label: "Calendario"
    type: inner
    relationship: many_to_one
    sql_on: ${d_fecha.FECHA} = ${reservas.fecha_llegada} ;;
  }
  join: d_clientes {
    type: inner
    relationship: many_to_one
    sql_on: ${d_clientes.id_cliente} ${reservas.id_cliente} ;;
  }
  join: d_canal {
    type: inner
    relationship: many_to_one
    sql_on: ${d_canal.id_canal} = ${reservas.id_canal} ;;
  }
  join: d_tipo_habitacion {
    type: inner
    relationship: many_to_one
    sql_on: ${d_tipo_habitacion.id_tipo_habitacion} = ${reservas.id_tipo_habitacion} ;;
  }
}
