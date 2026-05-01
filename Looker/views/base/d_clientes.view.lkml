view: d_clientes {
  sql_table_name: "PUBLIC"."D_CLIENTES" ;;

  dimension: desc_cliente {
    type: string
    sql: ${TABLE}."DESC_CLIENTE" ;;
  }
  dimension: fecha_cliente {
    type:  date
    sql: ${TABLE}."FECHA_CLIENTE" ;;
  }
  dimension: id_cliente {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID_CLIENTE" ;;
  }
  measure: count {
    type: count
  }
}
