view: d_tipo_habitacion {
  sql_table_name: "PUBLIC"."D_TIPO_HABITACION" ;;

  dimension: desc_habitacion {
    type: string
    sql: ${TABLE}."DESC_HABITACION" ;;
  }
  dimension: id_tipo_habitacion {
    type: number
    sql: ${TABLE}."ID_TIPO_HABITACION" ;;
    primary_key: yes
  }
  measure: count {
    type: count
  }
}
