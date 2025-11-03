/*  
    =================================================
    Functions for implementation of SQL with ui
    =================================================
*/

#pragma once
#include <mysql_driver.h> // For the MySQL driver instance
#include <mysql_connection.h> // For the Connection object
#include <cppconn/driver.h> // Generic driver interface
#include <cppconn/exception.h> // For handling SQL exceptions
#include <cppconn/resultset.h> // For handling query results
#include <cppconn/statement.h> // For creating and executing SQL statements
#include <memory>

sql::Connection* connectToDatabase(std::string db_name, std::string user, std::string pass);

std::vector<std::tuple<std::string, std::string, double, std::string, int, int, int, std::string, std::string>> fetchAllStrengthExercises(sql::Connection* conn);



