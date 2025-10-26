/*
 * Since main.cpp is already wayyyy to crowded, this is where all
 * the bulky ImGui table creators will live.
 */

#pragma once

#include "render/renderer.h"
#include "sql.h"

void ShowAllStrenghtExercisesTable(sql::Connection* conn); // Displays an ImGui table for fetchAllStrengthExercises()