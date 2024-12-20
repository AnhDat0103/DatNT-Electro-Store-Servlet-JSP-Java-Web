/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DAT
 */
public class DBConnect {
    protected static Connection connection;
    
    public static Connection JDBCConnector() {
        try {
            String url = "jdbc:sqlserver://ANHDAT\\\\\\\\TRONGDAT:1433;databse=Electro_Store;encrypt=true;trustServerCertificate=true";
            String username = "sa";
            String password = "0123456789";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            System.err.println(e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return connection;
    }
    
    public static void main(String[] args) {
        JDBCConnector();
    }
    
}
