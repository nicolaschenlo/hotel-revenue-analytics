include: "/views/logic/proyecto/d_fecha.view.lkml"
#----------------------------------------------------------------------------------
# EXPLORE: fecha (BASE)
#
# Purpose: Explore base de d_fecha para sugerencias de filtros
# Grain: FECHA
#----------------------------------------------------------------------------------
explore: fecha {
  from: d_fecha
  label: "Fecha"
  hidden: yes
}
