include: "/views/base/proyecto/d_fecha.view.lkml"
#----------------------------------------------------------------------------------
# VIEW: d_fecha (LOGIC)
#
# Purpose: Logic layer extension of the base D_FECHA view. Adds user-facing
#          labels, group labels, computed dimensions and business measures.
#          No new raw fields are defined here -- all sql references delegate
#          to the base layer.
#
# Source: D_FECHA
# PK: date_key
#
# Dimensions:
# - Calendario: FECHA, year_num, month_num, day_num, day_of_week, day_of_year,
#          week_of_year, day_name, month_name, quarter_num, semester_num, date_key,
#          year_month, is_weekend, is_weekday
#----------------------------------------------------------------------------------
view: +d_fecha {
  label: "Fecha"

  # ---------------------------------------------------------------
  # Día
  # ---------------------------------------------------------------
  dimension: DAY_NUM {
    label: "Día"
    description: "Valor numérico entre 1 y 31 del día."
  }
  dimension: DAY_OF_WEEK {
    label: "Dia Semana"
    description: "Valor numérico entre 1 y 7 del día con respecto a la semana."
  }
  dimension: DAY_OF_YEAR {
    label: "Día Año"
    description: "Valor numérico entre 1 y 366 del día con respecto al año."
  }
  dimension: DAY_NAME {
    label: "Día Nombre"
    description: "Nombre del día de la semana."
  }
  dimension: IS_WEEKEND {
    label: "Finde?"
    description: "Indicador de si el día es fin de semana o no."
  }
  dimension: IS_WEEKDAY {
    label: "Semanal?"
    description: "Indicador de si el día es día de semana o no."
  }

  # ---------------------------------------------------------------
  # Semana
  # ---------------------------------------------------------------
  dimension: WEEK_OF_YEAR {
    label: "Semana Año"
    description: "Valor numérico entre 1 y 52 de la semana con respecto al año."
  }

  # ---------------------------------------------------------------
  # Mes
  # ---------------------------------------------------------------
  dimension: MONTH_NUM {
    label: "Mes"
    description: "Valor numérico entre 1 y 12 del mes."
  }
  dimension: MONTH_NAME {
    label: "Nombre del mes."
  }

  # ---------------------------------------------------------------
  # Trimestre, semestre
  # ---------------------------------------------------------------
  dimension: QUARTER_NUM {
    label: "Cuatrimestre"
    description: "Valor numérico entre 1 y 4 del cuatrimestre del año."
  }
  dimension: SEMESTER_NUM {
    label: "Semestre"
    description: "Valor numérico entre 1 y 2 del semestre del año."
  }

  # ---------------------------------------------------------------
  # Año
  # ---------------------------------------------------------------
  dimension: YEAR_NUM {
    label: "Año"
    description: "Valor numérico del año."
  }
  dimension: YEAR_MONTH {
    label: "Año Mes"
    description: "Valor numérico entre del año seguido del mes."
  }

  # ---------------------------------------------------------------
  # Fecha
  # ---------------------------------------------------------------
  dimension: DATE_KEY {
    label: "Fecha Key"
    description: "Identificador único de la fecha."
  }
  dimension: FECHA {
    label: "Fecha"
    description: "Fecha en formato habitual."
  }

  dimension: fecha_calendario {
    type: date
    hidden: yes
    sql: TO_DATE(${DATE_KEY}::VARCHAR,'YYYYMMDD') ;;
  }
  dimension: fecha_comp {
    type: date
    hidden: yes
    sql: DATEADD(month, -1, TO_DATE(${DATE_KEY}::VARCHAR,'YYYYMMDD')) ;;
  }

  # ---------------------------------------------------------------
  # System measure -- kept minimal in base layer
  # ---------------------------------------------------------------
  measure: count {
    hidden: yes
  }
}
