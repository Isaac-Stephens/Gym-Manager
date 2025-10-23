/*  
    =================================================
    Functions for implementation of SQL with main.cpp
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

std::unique_ptr<sql::Connection> connectToDatabase(char* db_name, char* user, char* pass);



