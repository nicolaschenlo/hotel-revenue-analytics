include: "/views/logic/proyecto/d_clientes.view.lkml"
#----------------------------------------------------------------------------------
# EXPLORE: clientes (BASE)
#
# Purpose: Explore base de d_clientes para sugerencias de filtros
# Grain: id_cliente
#----------------------------------------------------------------------------------
explore: clientes {
  from: d_clientes
  label: "Clientes"
  hidden: yes
}
