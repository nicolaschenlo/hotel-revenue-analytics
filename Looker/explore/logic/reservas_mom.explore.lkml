include: "/explores/logic/proyecto/reservas.explore.lkml"
include: "/pdts/proyecto/ndt_reservas_mom.view.lkml"
include: "/config/datagroups.lkml"
include: "/pdts/proyecto/pdt_reservas_mom.view.lkml"
#----------------------------------------------------------------------------------
# FILE: RESERVAS YOY EXPLORE
#
# Purpose: Cálculo de medidas YoY mediante el merge datasets de TY y LY definidos sobre NDTs
# Flow: [reservas] + [reservas_lm]
#       --> [ndt_reservas_mom_aux] (Joiner)
#       --> [ndt_reservas_mom] (Persistence)
#       --> [reservas_mom] (Final User Explore)
# Grain: id_cliente, id_tipo_habitacion, id_canal, fecha_llegada, fecha_salida
#----------------------------------------------------------------------------------

# =================================================================================
# EXPLORE: reservas_lm
# =================================================================================
explore: reservas_lm {
  hidden: yes
  extends: [reservas]
  view_name: reservas
  join: d_fecha {
    type: inner
    relationship: many_to_one
    sql_on: ${reservas.fecha_llegada_date} = ${d_fecha.fecha_comp} ;;
  }
}

# =================================================================================
# EXPLORE: ndt_reservas_mom_aux
# =================================================================================
explore: ndt_reservas_mom_aux {
  hidden: yes
  from: ndt_reservas_tm
  fields: [ALL_FIELDS*]
  join: ndt_reservas_lm {
    type: full_outer
    relationship: one_to_one
    sql_on:
    ${ndt_reservas_mom_aux.fecha_llegada_date} = ${ndt_reservas_lm.fecha_llegada_date}
      AND  ${ndt_reservas_mom_aux.id_canal} = ${ndt_reservas_lm.id_canal}
      AND  ${ndt_reservas_mom_aux.id_cliente} = ${ndt_reservas_lm.id_cliente}
      AND  ${ndt_reservas_mom_aux.id_tipo_habitacion} = ${ndt_reservas_lm.id_tipo_habitacion} ;;
  }
}

# =================================================================================
# EXPLORE: ndt_reservas_mom
# =================================================================================
explore: ndt_reservas_mom {
  from: ndt_reservas_mom_aux
  fields: [ALL_FIELDS*]
  hidden: yes
}

# =================================================================================
# EXPLORE: reservas_mom
# =================================================================================
explore: reservas_mom {
  label: "YoY"
  description: "Explore de reservas YoY"
  from: ndt_reservas_mom
  #persist_with: Alumno_14

  join: d_canal {
    type: inner
    relationship: many_to_one
    sql_on: ${reservas_mom.id_canal} = ${d_canal.id_canal} ;;
  }
  join: d_clientes {
    type: inner
    relationship: many_to_one
    sql_on: ${reservas_mom.id_cliente} = ${d_clientes.id_cliente} ;;
  }
  join: d_tipo_habitacion {
    type: inner
    relationship: many_to_one
    sql_on: ${reservas_mom.id_tipo_habitacion} = ${d_tipo_habitacion.id_tipo_habitacion} ;;
  }
}
