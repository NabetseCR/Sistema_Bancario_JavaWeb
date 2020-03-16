/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author chinc
 */
public class DBConnection {
    protected Connection connection = null;

    public DBConnection() {

    }

    protected void connect() throws SQLException, ClassNotFoundException {
        //Nombre de espacio que trae el conector
        Class.forName("com.mysql.cj.jdbc.Driver");
        //------
        //Parametros(URL, USER, PASS)
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banco", "root", "nabetse97");
        //Cambiar "usuario" y "contrasenna", con sus credenciales
        //para hacer uso de la base de datos.
    }

    protected void disconnect() throws SQLException {
        if (!connection.isClosed()) {
            connection.close();
        }
    }
}
