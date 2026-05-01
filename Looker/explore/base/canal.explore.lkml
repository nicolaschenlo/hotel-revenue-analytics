include: "/views/logic/proyecto/d_canal.view.lkml"
#----------------------------------------------------------------------------------
# EXPLORE: canal (BASE)
#
# Purpose: Explore base de d_canal para sugerencias de filtros
# Grain: id_canal
#----------------------------------------------------------------------------------
explore: canal {
  from: d_canal
  label: "Canal"
  hidden: yes
}
