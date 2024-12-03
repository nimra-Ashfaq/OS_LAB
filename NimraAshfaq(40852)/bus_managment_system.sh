#!/bin/bash

declare -A adminAccounts
declare -A userAccounts
declare -A buses

# Admin Accounts (for login)
adminAccounts["nimra"]="12345"

# Admin Login
adminLogin() {
    echo "Admin Login"
    read -p "Username: " username
    read -sp "Password: " password
    echo ""

    if [[ ${adminAccounts[$username]} == $password ]];

        then
        echo "Login successful!"
        sleep 2
        clear
        adminMenu
        else
        echo "Invalid Uername or Passward!"
       sleep 2
       clear
    fi
            }

# Admin Menu: Add, Update, View, Delete Bus & Logout
adminMenu() {
    while true; do
        echo -e "\nAdmin Menu"
        echo "1. Add Bus"
        echo "2. Update Bus"
        echo "3. View All Buses"
        echo "4. Delete Bus"
        echo "5. Logout"
        read -p "Choose an option: " choice
         sleep 2
         clear

        case $choice in
            1) addBus ;;
            2) updateBus ;;
            3) viewBuses ;;
            4) deleteBus ;;
            5) echo "Logging out..."; break ;;
            *) echo "Invalid choice. Try again." ;;

        esac
        sleep 3
        clear
    done
}


# Add a new bus
addBus() {
    read -p "Enter Bus Number: " busNum
    read -p "Enter Departure Station: " dep
    read -p "Enter Destination Station: " dest
    read -p "Enter Departure Time : " time
    read -p "Enter Time Period (AM/PM): " period
    read -p "Enter Available Seats: " seats

    buses["$busNum"]="$dep $dest $time $period $seats"
    echo "Bus added successfully!"
      sleep 2
      clear
}

# Update bus information
updateBus() {
    read -p "Enter Bus Number to update: " busNum
    if [[ -n ${buses[$busNum]} ]]; 
        then

        read -p "Enter new Departure Station: " dep
        read -p "Enter new Destination Station: " dest
        read -p "Enter new Departure Time: " time
        read -p "Enter new Time Period: " period
        read -p "Enter new Number of Seats: " seats

        buses["$busNum"]="$dep $dest $time $period $seats"
        echo "Bus details updated!"
        sleep 2
        clear
else
       echo "Bus not found!"
       sleep 2
       clear
fi
}

# View all available buses
viewBuses() {
    if [[ ${#buses[@]} -eq 0 ]]; then
        echo "No buses available."
        sleep 3
    else
        echo -e "\nAvailable Buses:"
        for busNum in "${!buses[@]}"; do
            echo -e "$busNum: ${buses[$busNum]}"
        sleep 3
        done

    fi
}

# Delete a bus
deleteBus() {
    read -p "Enter Bus Number to delete: " busNum
    if [[ -n ${buses[$busNum]} ]]; then
        unset buses["$busNum"]
        echo "Bus deleted!"

else
        echo "Bus not found!"

fi
}

# User Signup
userSignup() {
    echo "User Signup"
    read -p "Choose a Username: " username
    read -sp "Choose a Password: " password
    echo ""

    if [[ -n ${userAccounts[$username]} ]]; then
        echo "Username already exists!"

else
        userAccounts[$username]=$password
        echo "Signup successful!"

fi
}

# User Login
userLogin() {
    echo "User Login"
    read -p "Username: " username
    read -sp "Password: " password
    echo ""

    if [[ ${userAccounts[$username]} == $password ]]; then
        echo "Login successful!"

userMenu
    else
        echo "Invalid login!"

fi
}

# User Menu: View Buses & Book Tickets
userMenu() {
    while true; do
        echo -e "\nUser Menu"
        echo "1. View All Buses"
        echo "2. Book Ticket"
        echo "3. Logout"
        read -p "Choose an option: " choice
        clear
        case $choice in
            1) viewBuses ;;
            2) bookTicket ;;
            3) echo "Logging out..."; break ;;
            *) echo "Invalid choice. Try again." ;;
        esac
    done
}

# Book a ticket for a bus
bookTicket() {
    read -p "Enter Bus Number to book a ticket: " busNum
    if [[ -n ${buses[$busNum]} ]]; then
        busDetails=(${buses[$busNum]})
        seats=${busDetails[4]}

        if [[ $seats -gt 0 ]]; then
            ((seats--))
            busDetails[4]=$seats
            buses["$busNum"]="${busDetails[0]} ${busDetails[1]} ${busDetails[2]} ${busDetails[3]} $seats"
            echo "Ticket booked successfully!"

else
            echo "No available seats!"
        fi
    else
        echo "Bus not found!"
    fi
}

# Main Menu: Admin, User, Exit
mainMenu() {
    while true; do
        echo -e "\nBus Management System"
        echo "1. Admin"
        echo "2. User"
        echo "3. Exit"
        read -p "Choose an option: " choice
        clear
        case $choice in
            1) adminLogin ;;
            2) userModule ;;
            3) exitSystem ;;
            *) echo "Invalid choice. Try again." ;;

  esac
    done
}

# User Module: Signup, Login, Exit
userModule() {
    while true; do
        echo -e "\nUser Module"
        echo "1. Sign Up"
        echo "2. Log In"
        echo "3. Exit"
        read -p "Choose an option: " choice
        clear
        case $choice in
            1) userSignup ;;
            2) userLogin ;;
            3) exitSystem ;;
            *) echo "Invalid choice. Try again." ;;

        esac
    done
}

# Exit System
exitSystem() {
    echo "Exiting the system. Goodbye!"
    exit 0
}

# Run the main menu
mainMenu
