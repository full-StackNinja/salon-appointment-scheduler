#!/bin/bash

echo -e "\n~~~ Chameleon Salon ~~~\n"
PSQL="psql -t -A --username=freecodecamp --dbname=salon -c"
MAIN_MENU(){
  if [[ $1 ]]
  then
  echo -e "\n$1\n"
  fi
  echo "Welcome to Chameleon Salon. How may I help you?"
  echo -e "\n1) Hair Cut\n2) Color\n3) Facial\n4) Exit\n"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
  1) BOOK_SERVICE;;
  2) BOOK_SERVICE;;
  3) BOOK_SERVICE;;
  4) EXIT;;
  *) MAIN_MENU "Please select correct service or type 4 to exit.";;
  esac
}

BOOK_SERVICE(){
  # Ask for user phone
  echo -e "\nYour phone number?"
  read CUSTOMER_PHONE
  # get customer name
  CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
  # if customer does not exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # ask for customer name
    echo -e "\nYour name?"
    read CUSTOMER_NAME
    # save customer info
    $PSQL "INSERT INTO customers(name, phone)VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')"
  fi
  # ask for service time
  echo -e "\nYour service time?"
  read SERVICE_TIME
  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id from customers WHERE phone = '$CUSTOMER_PHONE'")
  # save appointment of the customer
  APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time)VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  # get service name for service id selected
  SERVICE_NAME=$($PSQL "SELECT name from services WHERE service_id = $SERVICE_ID_SELECTED")
  # inform customer about appointment confirmation
  echo -e "\nI have put you down for a "$SERVICE_NAME" at "$SERVICE_TIME", "$CUSTOMER_NAME"."
}
COLOR(){
  echo "Hello Color"
}
FACIAL(){
  echo "Hello Facial"
}

EXIT(){
  echo -e "\nThank you for stopping in."
}

MAIN_MENU