#include "sql.h"

sql::Connection* connectToDatabase(std::string db_name, std::string user, std::string pass) {
    try {
        sql::mysql::MySQL_Driver* driver = sql::mysql::get_driver_instance();

        sql::Connection* conn(
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

std::vector<std::tuple<std::string, std::string, double, std::string, int, int, int, std::string, std::string>> fetchAllStrengthExercises(sql::Connection* conn) {
    std::vector<std::tuple<std::string, std::string, double, std::string, int, int, int, std::string, std::string>> results;
    try {
        std::unique_ptr<sql::Statement> stmt(conn->createStatement());

        std::unique_ptr<sql::ResultSet> res(
            stmt->executeQuery(
                "SELECT CONCAT(m.first_name, ' ', m.last_name) AS member, "
                "e.exercise_name, s.exercise_weight, s.weight_unit, s.num_sets, s.num_repetitions, e.rpe, s.notes, e.exercise_date "
                "FROM Members AS m "
                "INNER JOIN Exercises AS e ON m.member_id = e.member_id "
                "INNER JOIN Strength_Exercises AS s ON e.exercise_id = s.exercise_id "
                "ORDER BY e.exercise_date DESC;"
            )
        );

        while (res->next()) {
            results.emplace_back(
                res->getString("member"),
                res->getString("exercise_name"),
                res->getDouble("exercise_weight"),
                res->getString("weight_unit"),
                res->getInt("num_sets"),
                res->getInt("num_repetitions"),
                res->getInt("rpe"),
                res->getString("notes"),
                res->getString("exercise_date")
            );
        }

    } catch (sql::SQLException& e) {
        std::cerr << "Query Failed: " << e.what() << std::endl;
    }
    return results;
}



