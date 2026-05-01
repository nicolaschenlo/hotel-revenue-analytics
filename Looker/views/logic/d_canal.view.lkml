include: "/views/base/proyecto/d_canal.view.lkml"
#----------------------------------------------------------------------------------
# VIEW: d_canal (LOGIC)
#
# Purpose: Logic layer extension of the base D_CANAL view. Adds user-facing
#          labels, group labels, computed dimensions and business measures.
#          No new raw fields are defined here -- all sql references delegate
#          to the base layer.
#
# Source: D_CANAL
# PK: id_canal
#
# Dimensions:
# - Canal: id_canal, desc_canal
#----------------------------------------------------------------------------------
view: +d_canal {
  label: "Canal"

  # ---------------------------------------------------------------
  # Canal
  # ---------------------------------------------------------------
  dimension: desc_canal {
    label: "Desc. Canal"
    description: "Descripción del Canal de Venta"
  }
  dimension: id_canal {
    label: "ID Canal"
    description: "Identificador único del canal de venta."
  }

  # ---------------------------------------------------------------
  # System measure -- kept minimal in base layer
  # ---------------------------------------------------------------
  measure: count {
    hidden: yes
  }
}
