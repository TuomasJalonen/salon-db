#! /bin/bash

# This script runs a hair salon.

PSQL="psql --username=postgres --dbname=salon -t --no-align -F | -c"

GET_SERVICE() {
  echo "Welcome to My Salon, how can I help you?"
  while true
  do
    # print available services
    $PSQL "SELECT name, service_id FROM services" |
    while IFS="|" read -r SERVICE_NAME SERVICE_ID; do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done

    # get service selection
    read -r SERVICE_ID_SELECTED

    # get service name and return if it is found
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    [[ -n $SERVICE_NAME ]] && return

    echo "I could not find that service. What would you like today?"
  done
}

RUN_SALON() {

  echo -e "\n~~~~~ MY SALON ~~~~~"
  GET_SERVICE

  # get the name of the selected service
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  # get customer phone number
  echo -e "What's your phone number?"
  read -r CUSTOMER_PHONE

  # get customer name from database
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    # ask the name if not found from the database
    echo -e "I don't have a record for that phone number, what's your name?"
    read -r CUSTOMER_NAME
    # insert new customer into database
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi

  # get customer id from database
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # get service time
  echo -e "What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read -r SERVICE_TIME

  # insert appointment to database
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

  # print confirmation
  echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

}

RUN_SALON
