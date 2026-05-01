include: "/explores/logic/proyecto/reservas_mom.explore.lkml"

explore: +reservas_mom {
  aggregate_table: pdt_reservas_yoy {
    query: {
      dimensions: [
        reservas_mom.fecha_llegada_month,
        d_tipo_habitacion.desc_habitacion,
        d_canal.desc_canal]
      measures: [
        reservas_mom.ventas_netas,
        reservas_mom.ventas_perdidas]
    }
    materialization: {
      datagroup_trigger: Alumno_14
      cluster_keys: ["fecha_llegada_month"]
    }
  }
}
