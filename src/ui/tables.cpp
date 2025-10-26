#include "tables.h"

void ShowAllStrenghtExercisesTable(sql::Connection* conn) {
    static auto exercises = fetchAllStrengthExercises(conn);

    if (ImGui::Begin("Strength Exercises")) {
        if (ImGui::BeginTable("ExercisesTable", 8, ImGuiTableFlags_Borders | ImGuiTableFlags_RowBg)) {
            ImGui::TableSetupColumn("Member");
            ImGui::TableSetupColumn("Exercise");
            ImGui::TableSetupColumn("Weight");
            ImGui::TableSetupColumn("Units");
            ImGui::TableSetupColumn("Sets");
            ImGui::TableSetupColumn("Reps");
            ImGui::TableSetupColumn("RPE");
            ImGui::TableSetupColumn("Notes");
            ImGui::TableHeadersRow();

            for (auto& row: exercises) {
                ImGui::TableNextRow();
                ImGui::TableSetColumnIndex(0); ImGui::Text("%s", std::get<0>(row).c_str());
                ImGui::TableSetColumnIndex(1); ImGui::Text("%s", std::get<1>(row).c_str());
                ImGui::TableSetColumnIndex(2); ImGui::Text("%.2f", std::get<2>(row));
                ImGui::TableSetColumnIndex(3); ImGui::Text("%s", std::get<3>(row).c_str());
                ImGui::TableSetColumnIndex(4); ImGui::Text("%d", std::get<4>(row));
                ImGui::TableSetColumnIndex(5); ImGui::Text("%d", std::get<5>(row));
                ImGui::TableSetColumnIndex(6); ImGui::Text("%d", std::get<6>(row));
                ImGui::TableSetColumnIndex(7); ImGui::Text("%s", std::get<7>(row).c_str());
            }

            ImGui::EndTable();
        }

        ImGui::End();
    }
}