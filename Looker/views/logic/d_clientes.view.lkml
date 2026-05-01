include: "/views/base/proyecto/d_clientes.view.lkml"
#----------------------------------------------------------------------------------
# VIEW: d_clientes (LOGIC)
#
# Purpose: Logic layer extension of the base D_CLIENTES view. Adds user-facing
#          labels, group labels, computed dimensions and business measures.
#          No new raw fields are defined here -- all sql references delegate
#          to the base layer.
#
# Source: D_CLIENTES
# PK: id_cliente
#
# Dimensions:
# - Cliente: id_cliente, desc_cliente, fecha_cliente
#----------------------------------------------------------------------------------
view: +d_clientes {
  label: "Clientes"

  # ---------------------------------------------------------------
  # Cliente
  # ---------------------------------------------------------------
  dimension: fecha_cliente {
    label: "Fecha Cliente"
    description: "Fecha de nacimiento del cliente"
  }
  dimension: desc_cliente {
    label: "Desc. Cliente"
    description: "Nombre del cliente"
  }
  dimension: id_cliente {
    label: "ID Cliente"
    description: "ID del cliente"
  }

  # ---------------------------------------------------------------
  # System measure -- kept minimal in base layer
  # ---------------------------------------------------------------
  measure: count {
    hidden: yes
  }
}
