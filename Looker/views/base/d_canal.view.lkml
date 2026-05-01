view: d_canal {
  sql_table_name: "PUBLIC"."D_CANAL" ;;

  dimension: desc_canal {
    type: string
    sql: ${TABLE}."DESC_CANAL" ;;
  }
  dimension: id_canal {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID_CANAL" ;;
  }
  measure: count {
    type: count
  }
}
