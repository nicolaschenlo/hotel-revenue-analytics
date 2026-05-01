include: "/views/base/proyecto/d_tipo_habitacion.view.lkml"
#----------------------------------------------------------------------------------
# VIEW: d_tipo_habitacion (LOGIC)
#
# Purpose: Logic layer extension of the base D_TIPO_HABITACION view. Adds user-facing
#          labels, group labels, computed dimensions and business measures.
#          No new raw fields are defined here -- all sql references delegate
#          to the base layer.
#
# Source: D_TIPO_HABITACION
# PK: id_tipo_habitacion
#
# Dimensions:
# - Tipo Habitación: id_tipo_habitacion, desc_tipo_habitacion
#----------------------------------------------------------------------------------
view: +d_tipo_habitacion {
  label: "Tipo Habitación"

  # ---------------------------------------------------------------
  # Canal
  # ---------------------------------------------------------------
  dimension: desc_tipo_habitacion {
    label: "Desc Tipo Habitación"
    description: "Descripción del tipo de habitación"
  }
  dimension: id_tipo_habitacion {
    label: "ID Tipo Habitación"
    description: "Identificador único del tipo de habitación"
  }

  # ---------------------------------------------------------------
  # System measure -- kept minimal in base layer
  # ---------------------------------------------------------------
  measure: count {
    hidden: yes
  }
}
