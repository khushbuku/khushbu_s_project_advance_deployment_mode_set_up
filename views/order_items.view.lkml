view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }
  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension_group: test {
    type: duration
    intervals: [day,month,year]
    sql_start: min(${returned_date}) ;;
    sql_end: max(${returned_date}) ;;
  }

  measure: min_date {
   # type: date_time
    sql: MIN(${returned_date}) ;;

  }

  measure: max_date {
  # type: date_time
    sql: MAX(${returned_date}) ;;
  }

  measure: duration {
    type: number
    sql: ${max_date}-${min_date} ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: test1 {
    type: sum
    sql: ROUND(${sale_price});;
    html: {% if orders.status_value == "Complete" %}
    {{value}}
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }
  measure: count {
    type: count
    drill_fields: [id, sale_price, inventory_items.id]
  }
}
