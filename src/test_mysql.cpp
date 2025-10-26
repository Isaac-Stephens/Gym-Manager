/* ================== *
 * DB CONNECTION TEST *
 * ================== */

// g++ test_mysql.cpp -o test_mysql -lmysqlcppconn -std=c++17
// ./test_mysql

#include <iostream>
#include <memory>
#include <cppconn/driver.h>
#include <mysql_driver.h>
#include <mysql_connection.h>

int main () {
    
    try {
        sql::mysql::MySQL_Driver *driver = sql::mysql::get_mysql_driver_instance();
        std::unique_ptr<sql::Connection> conn(driver->connect("tcp://127.0.0.1:3306", "root", "root"));
        conn->setSchema("gymman");
        std::cout << "DB OK" << std::endl;
    } catch (sql::SQLException& e) {
        std::cerr << "SQLExeption: " << e.what() << std::endl;
        return 2;
    } catch (std::exception& e) {
        std::cerr << "std::exeption: " << e.what() << std::endl;
        return 3;
    }

    return 0;
}