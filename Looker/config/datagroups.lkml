datagroup: Alumno_14 {
  label: "Materialización de PDTs"
  #description: "Datagroup con caché máximo de 24 horas que se lanza diariamente a las 4AM"
  max_cache_age: "8784 hours"
  #sql_trigger: SELECT YEAR(CONVERT_TIMEZONE('Europe/Madrid', CURRENT_TIMESTAMP())) ;;
  interval_trigger: "8784 hours"
}
