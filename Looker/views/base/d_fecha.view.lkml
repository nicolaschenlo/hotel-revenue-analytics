view: d_fecha {
  sql_table_name: "PUBLIC"."D_FECHA" ;;

  dimension: date_key {
    type: number
    sql: ${TABLE}."DATE_KEY" ;;
    primary_key: yes
  }
  dimension_group: fecha {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."FECHA" ;;
  }
  dimension: month_name {
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
  }
  dimension: month_num {
    type: number
    sql: ${TABLE}."MONTH_NUM" ;;
  }
  dimension: year_month {
    type: string
    sql: ${TABLE}."YEAR_MONTH" ;;
  }
  dimension: year_num {
    type: number
    sql: ${TABLE}."YEAR_NUM" ;;
  }
}
