/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.data;

import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankTeller;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author chinc
 */
public class TellerService extends DBConnection {
    public TellerService() {
        
    }
    
    public static TellerService getInstance() {
        if (instance == null) {
            instance= new TellerService();
        }
        return instance;
    }
    
    //------------------------ PARTE DEL CRUD --------------------------------------------------
    // No necesario insertar o diferentes cosas, este serivicio solo servira como apoyo a login siendo cajero
    
    // Ver si persona esta
    public ArrayList consultarPersonaID(int _id) throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankTeller> collection = new ArrayList<>();
        BankTeller client = null;
        CallableStatement pstmt = null;
        try {
            pstmt = connection.prepareCall(LISTPERSON);
            //pstmt.registerOutParameter(1, Types.INTEGER);
            pstmt.setInt(1, _id);
            //pstmt.execute();
            
            boolean hadResults = pstmt.execute();
            while (hadResults) {
                rs = pstmt.getResultSet();
 
                // process result set
                while (rs.next()) {
                    client = new BankTeller(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("primer_apelido"),
                        rs.getString("segundo_apellido"),
                        rs.getString("estado_civil"),
                        rs.getString("provincia"),
                        rs.getString("canton"),
                        rs.getString("direccion"),
                        rs.getString("telefono"),
                        rs.getString("celular"),
                        rs.getString("email"),
                        rs.getInt("edad"));
                collection.add(client);
                }
 
                hadResults = pstmt.getMoreResults();
            }
 
            pstmt.close();
 
        } catch (SQLException ex) {
            ex.printStackTrace();
        } 
        return collection;
    }
    
    public ArrayList cajerosTotales() throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankTeller> collection = new ArrayList<>();
        BankTeller client = null;
        CallableStatement pstmt = null;
        try {
            pstmt = connection.prepareCall(LISTTELLER);
            //pstmt.registerOutParameter(1, Types.INTEGER);
            //pstmt.setInt(1, _id);
            //pstmt.execute();
            
            boolean hadResults = pstmt.execute();
            while (hadResults) {
                rs = pstmt.getResultSet();
 
                // process result set
                while (rs.next()) {
                    client = new BankTeller(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("primer_apelido"),
                        rs.getString("segundo_apellido"),
                        rs.getString("estado_civil"),
                        rs.getString("provincia"),
                        rs.getString("canton"),
                        rs.getString("direccion"),
                        rs.getString("telefono"),
                        rs.getString("celular"),
                        rs.getString("email"),
                        rs.getInt("edad"),
                        rs.getString("clave"));
                collection.add(client);
                }
 
                hadResults = pstmt.getMoreResults();
            }
 
            pstmt.close();
 
        } catch (SQLException ex) {
            ex.printStackTrace();
        } 
        return collection;
    }
    
    //Ayuda a verificar contrasenna
    
      
    //------------------------- FIN DE CRUD ---------------------------------------------------
    //Atributos
    private static final String LISTPERSON = "{call listaPersona(?)}";
    private static final String LISTTELLER = "{call listaCajerosTotales()}";
    //Singleton
    private static TellerService instance = null;
}
