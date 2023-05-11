//
//  LicenseHelper.swift
//  AntiSpy
//
//  Created by Fi on 5/11/23.
//

import Foundation
import SQLite3

class LicenseHelper {
    
    static let shared = LicenseHelper()
    
    let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/antispy_license.sqlite"
    
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
    
    func store(clickId: String) {
        // Define the SQL statement
        let insertStatementString = "INSERT INTO license (referrer) VALUES (?);"
        
        // Prepare the statement
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            // Bind parameters to the statement
            sqlite3_bind_text(insertStatement, 1, NSString(string: clickId).utf8String, -1, nil)
            
            // Execute the statement
            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("error inserting data license")
            }
            
            // Reset the statement for future use
            sqlite3_reset(insertStatement)
            
        } else {
            print("error preparing statement license")
        }
        
        // Clean up the statement
        sqlite3_finalize(insertStatement)
    }
    
    
    func get() -> String {
        var clickId = ""
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, "SELECT referrer FROM license", -1, &queryStatement, nil) == SQLITE_OK {
            
            // Retrieve the data here
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                clickId = String(cString: sqlite3_column_text(queryStatement, 0))
            }
        } else {
            print("error preparing statement license")
        }
        return clickId
    }
    
    func fresh() {
        let deleteStatementString = "DELETE FROM license"
        var deleteStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            // Bind parameters to the statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("\nSuccessfully fresh.")
            } else {
                print("\nCould not fresh.")
            }
            
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing fresh: \(errmsg)")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func initDatabase() {
        let createTableString = """
CREATE TABLE IF NOT EXISTS license(
    Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    referrer CHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

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
