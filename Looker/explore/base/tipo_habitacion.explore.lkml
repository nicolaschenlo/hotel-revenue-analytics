include: "/views/logic/proyecto/d_tipo_habitacion.view.lkml"
#----------------------------------------------------------------------------------
# EXPLORE: tipo_habitacion (BASE)
#
# Purpose: Explore base de d_tipo_habitacion para sugerencias de filtros
# Grain: id_tipo_habitacion
#----------------------------------------------------------------------------------
explore: tipo_habitacion {
  from: d_tipo_habitacion
  label: "Tipo Habitación"
  hidden: yes
}
