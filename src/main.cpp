#include <wx/wx.h>
#include <wx/listctrl.h>
#include "ui/sql.h"

// Application class
class MyApp : public wxApp {
public:
    bool OnInit() override;
};

// Main Frame
class MyFrame : public wxFrame {
public:
    MyFrame(const wxString& title);

private:
    wxListCtrl* listCtrl;
    void OnFetch(wxCommandEvent& event);
    void FetchDataFromDB();

    wxDECLARE_EVENT_TABLE();
};

// Event Table
enum { ID_FETCH = wxID_HIGHEST + 1 };

wxBEGIN_EVENT_TABLE(MyFrame, wxFrame)
    EVT_BUTTON(ID_FETCH, MyFrame::OnFetch)
wxEND_EVENT_TABLE()

// wxWidgets App Implementation
wxIMPLEMENT_APP(MyApp);

bool MyApp::OnInit() {
    MyFrame* frame = new MyFrame("wxWidgets + MySQL Demo");
    frame->Show(true);
    return true;
}

// Frame Implementation
MyFrame::MyFrame(const wxString& title)
    : wxFrame(nullptr, wxID_ANY, title, wxDefaultPosition, wxSize(800, 400)) {

    wxPanel* panel = new wxPanel(this);
    wxBoxSizer* vbox = new wxBoxSizer(wxVERTICAL);

    wxButton* fetchBtn = new wxButton(panel, ID_FETCH, "Fetch Members");
    listCtrl = new wxListCtrl(panel, wxID_ANY, wxDefaultPosition, wxDefaultSize,
                              wxLC_REPORT | wxBORDER_SUNKEN);

    listCtrl->InsertColumn(0, "Member ID");
    listCtrl->InsertColumn(1, "First Name");
    listCtrl->InsertColumn(2, "Last Name");
    listCtrl->InsertColumn(3, "Email");

    vbox->Add(fetchBtn, 0, wxALL | wxCENTER, 10);
    vbox->Add(listCtrl, 1, wxEXPAND | wxALL, 10);

    panel->SetSizer(vbox);
}

// Button Handler
void MyFrame::OnFetch(wxCommandEvent&) {
    FetchDataFromDB();
}

// Database Fetch Function
void MyFrame::FetchDataFromDB() {
    listCtrl->DeleteAllItems();

    try {
        sql::mysql::MySQL_Driver* driver = sql::mysql::get_mysql_driver_instance();

        // NOTE: Change credentials as needed
        std::unique_ptr<sql::Connection> conn(
            driver->connect("tcp://127.0.0.1:3306", "gymowner", "gympass")
        );

        conn->setSchema("gymman");

        std::unique_ptr<sql::Statement> stmt(conn->createStatement());
        std::unique_ptr<sql::ResultSet> res(stmt->executeQuery(
            "SELECT member_id, first_name, last_name, email FROM Members;"
        ));

        long index = 0;
        while (res->next()) {
            // Convert member_id (int → string → wxString)
            wxString memberId = wxString::Format("%d", res->getInt("member_id"));

            // Convert sql::SQLString → std::string → wxString
            wxString firstName = wxString::FromUTF8(res->getString("first_name").c_str());
            wxString lastName  = wxString::FromUTF8(res->getString("last_name").c_str());
            wxString email     = wxString::FromUTF8(res->getString("email").c_str());

            long itemIndex = listCtrl->InsertItem(index, memberId);
            listCtrl->SetItem(itemIndex, 1, firstName);
            listCtrl->SetItem(itemIndex, 2, lastName);
            listCtrl->SetItem(itemIndex, 3, email);

            ++index;
        }

        wxMessageBox("Data fetched successfully!", "Success", wxICON_INFORMATION);
    } catch (sql::SQLException& e) {
        wxMessageBox(wxString::Format("SQL Error: %s", e.what()), "Error", wxICON_ERROR);
    } catch (std::exception& e) {
        wxMessageBox(wxString::Format("Exception: %s", e.what()), "Error", wxICON_ERROR);
    }
}
