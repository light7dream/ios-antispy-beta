//
//  DatabaseHelper.swift
//  AntiSpy
//
//  Created by Fi on 5/3/23.
//

import Foundation
import SQLite3

class DatabaseHelper{
    
    static let shared = DatabaseHelper()
    
    let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/antispy_logs.sqlite"
    
    var db: OpaquePointer?
    
    func openDatabase() -> Bool {
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbPath)")
            return true
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                  "in the documentation and that the SQLite library is installed correctly.")
            return false
        }
    }
    
    func closeDatabase() {
        sqlite3_close(db)
    }
    
    func store(activity: Activity){
        
        // Define the SQL statement
        let insertStatementString = "INSERT INTO logs (name, iconName, serviceName) VALUES (?, ?, ?);"
        
        // Prepare the statement
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            // Bind parameters to the statement
            sqlite3_bind_text(insertStatement, 1, NSString(string: activity.name).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, NSString(string: activity.iconName).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, NSString(string: activity.serviceName).utf8String, -1, nil)
            
            // Execute the statement
            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("error inserting data")
            }
            
            // Reset the statement for future use
            sqlite3_reset(insertStatement)
            
        } else {
            print("error preparing statement")
        }
        
        // Clean up the statement
        sqlite3_finalize(insertStatement)
    }
    
    func storeClickId(clickId: String) {
        // Define the SQL statement
        let insertStatementString = "INSERT INTO license (clickId) VALUES (?);"
        
        // Prepare the statement
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            // Bind parameters to the statement
            sqlite3_bind_text(insertStatement, 1, NSString(string: clickId).utf8String, -1, nil)
            
            // Execute the statement
            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("error inserting data")
            }
            
            // Reset the statement for future use
            sqlite3_reset(insertStatement)
            
        } else {
            print("error preparing statement")
        }
        
        // Clean up the statement
        sqlite3_finalize(insertStatement)
    }
    
    func getAll() -> [Activity] {
        var activities : [Activity] = []
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, "SELECT id, name, iconName, serviceName, strftime('%d-%m-%Y', created_at) as startDate, strftime('%H:%M:%S', created_at) as startTime, time(strftime('%s', updated_at) - strftime('%s', created_at), 'unixepoch') as duration FROM logs;", -1, &queryStatement, nil) == SQLITE_OK {
            
            // Retrieve the data here
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let iconName = String(cString: sqlite3_column_text(queryStatement, 2))
                let serviceName = String(cString: sqlite3_column_text(queryStatement, 3))
                let startDate = String(cString: sqlite3_column_text(queryStatement, 4))
                let startTime = String(cString: sqlite3_column_text(queryStatement, 5))
                let period = String(cString: sqlite3_column_text(queryStatement, 6))
                activities.append(Activity(startDate: startDate, startTime: startTime, name: name, iconName: iconName, serviceName: serviceName, period: period, _id: Int(id)))
                
            }
        } else {
            print("error preparing statement")
        }
        
        sqlite3_finalize(queryStatement)
        
        return activities
    }
    
    
    func getOne(id: Int) -> Activity {
        var activity : Activity?
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, "SELECT id, name, iconName, serviceName, strftime('%d-%m-%Y', created_at) as startDate, strftime('%H:%M:%S', created_at) as startTime, time(strftime('%s', updated_at) - strftime('%s', created_at), 'unixepoch') as duration FROM logs WHERE id = ?", -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(id))
            // Retrieve the data here
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let iconName = String(cString: sqlite3_column_text(queryStatement, 2))
                let serviceName = String(cString: sqlite3_column_text(queryStatement, 3))
                let startDate = String(cString: sqlite3_column_text(queryStatement, 4))
                let startTime = String(cString: sqlite3_column_text(queryStatement, 5))
                let period = String(cString: sqlite3_column_text(queryStatement, 6))
                activity = Activity(startDate: startDate, startTime: startTime, name: name, iconName: iconName, serviceName: serviceName, period: period, _id: Int(id))
            }
        } else {
            print("error preparing statement")
        }
        return activity!
    }
    
    func doWork(activity: Activity){
        let queryStatementString = "SELECT * FROM logs WHERE name = ? AND serviceName = ? AND updated_at > datetime('now', '-12 seconds') LIMIT 1 OFFSET 0;";
        var queryStatement: OpaquePointer?
        	
        if(sqlite3_prepare(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK) {

            sqlite3_bind_text(queryStatement, 1, NSString(string: activity.name).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, NSString(string: activity.serviceName).utf8String, -1, nil)
            // Execute the statement
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                update(id: id, activity: activity)
                
            } else {
                print("query returned no results")
                store(activity: activity)
                if(BackgroundTaskService.enVibration == true)
                {
                    makeVibration()
                    print("Vibration has been enabled.")
                }
                if(BackgroundTaskService.enNotification == true)
                {

                    makeNotification(title: "Secure alert", body: activity.name+" accessed the location", identifier: activity.name+activity.serviceName)

                    print("Notification has been enabled.")
                }
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing update: \(errmsg)")
        }
        
        sqlite3_finalize(queryStatement)
    }
    
    func fresh( en: Bool) {
        var triggerStatementString = "";
        if en == true {
            triggerStatementString = "DELETE FROM logs WHERE updated_at < date('now', '-2 day');"
            var triggerStatement: OpaquePointer?
            if sqlite3_prepare_v2(db, triggerStatementString, -1, &triggerStatement, nil) ==
                SQLITE_OK {
                if sqlite3_step(triggerStatement) == SQLITE_DONE {
                    print("trigger table created.")
                } else {
                    print("trigger could not be created.")
                }
            } else {
                print("trigger could not be prepared.")
            }
            sqlite3_finalize(triggerStatement)
        }
}
        
    
    
    func update( id: Int, activity: Activity ) {
        let updateStatementString = "UPDATE logs SET updated_at = datetime('now') WHERE id = ?;"
        var updateStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            // Bind any parameters if needed
            sqlite3_bind_int(updateStatement, 1, Int32(id))
            if sqlite3_step(updateStatement) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("failure updating data: \(errmsg)")
            }
            
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing update: \(errmsg)")
        }
        sqlite3_finalize(updateStatement)
        
    }
    
    func deleteOne(id: Int) {
        let deleteStatementString = "DELETE FROM logs WHERE id = ?;"
        var deleteStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            // Bind parameters to the statement
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("\nSuccessfully deleted row.")
            } else {
                print("\nCould not delete row.")
            }
            
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing delete: \(errmsg)")
        }
        sqlite3_finalize(deleteStatement)
    }


    func initDatabase() {
        let createTableString = """
CREATE TABLE IF NOT EXISTS logs(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name CHAR(255),
    iconName CHAR(255),
    serviceName CHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER IF NOT EXISTS logs_trigger
AFTER UPDATE ON logs
FOR EACH ROW
BEGIN
  UPDATE logs SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

"""
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
            SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Table table created.")
            } else {
                print("Table table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
}
