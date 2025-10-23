#include "sql.h"

std::unique_ptr<sql::Connection> connectToDatabase(char* db_name, char* user, char* pass) {
    try {
        sql::mysql::MySQL_Driver* driver = sql::mysql::get_driver_instance();

        std::unique_ptr<sql::Connection> conn(
            driver->connect("tcp://127.0.0.1:3306"/* local host */, user, pass)
        );

        conn->setSchema(db_name);
        std::cout << "Connected to MySQL successfully." << std::endl;
        return conn;

    } catch (sql::SQLException& e) {
        std::cerr << "MySQL connection failed: " << e.what() << std::endl;
        return nullptr;
    }
}
