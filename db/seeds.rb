EventSource.create(
  title: "SF Jazz",
  region: "San Francisco, CA",
  url: "http://www.sfjazz.org/events-calendar",
  event_item_selector: ".view-sfj-page-body-event-seriesview .views-table tbody tr", 
  title_link_selector: ".views-field-field-excerpttitle-text-value a", 
  location_selector: ".views-field-field-excerpttitle-text-value-1 p", 
  date_selector: ".date-display-single",
  ticket_url_selector: ".views-field-path a",
  disabled: false
)

EventSource.create(
  title: "SF Jazzie",
  region: "San Francisco, CA",
  url: "http://www.sfjazz.org/events-calendar",
  event_item_selector: ".view-sfj-page-body-event-seriesview .views-table tbody tr", 
  title_link_selector: ".views-field-field-excerpttitle-text-value a", 
  location_selector: ".views-field-field-excerpttitle-text-value-1 p", 
  date_selector: ".date-display-single",
  ticket_url_selector: ".views-field-path a",
  disabled: false
)