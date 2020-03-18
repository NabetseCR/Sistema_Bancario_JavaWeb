/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.data;

import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankClient;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author chinc
 */
public class ClientService extends DBConnection {
    public ClientService() {
        
    }
    
    public static ClientService getInstance() {
        if (instance == null) {
            instance= new ClientService();
        }
        return instance;
    }
    
    //------------------------ PARTE DEL CRUD --------------------------------------------------
    public void insertPerson(BankClient client) throws GlobalException, NoDataException  	{
        try {
            connect();
        } catch (ClassNotFoundException e) {
            throw new GlobalException("No se ha localizado el driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }
        CallableStatement pstmt=null;
        
        try {
            pstmt = connection.prepareCall(INSERTPERSON);
            pstmt.setInt(1,client.getId());
            pstmt.setString(2,client.getName());
            pstmt.setString(3,client.getFirst_surname());
            pstmt.setString(4,client.getSecond_surname());
            pstmt.setString(5,client.getMarital_status());
            pstmt.setString(6,client.getCity());
            pstmt.setString(7,client.getPlace());
            pstmt.setString(8,client.getAddress());
            pstmt.setString(9,client.getTelephone());
            pstmt.setString(10,client.getCellphone());
            pstmt.setString(11,client.getEmail());
            pstmt.setInt(12,client.getAge());
            boolean resultado = pstmt.execute();
            if (resultado == true) {
                throw new NoDataException("No se realizo la inserciï¿½n");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new GlobalException("Llave duplicada");
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                disconnect();
            } catch (SQLException e) {
                throw new GlobalException("Estatutos invalidos o nulos");
            }
        }
    }
    
    public void insertClientAccount(BankClient client) throws GlobalException, NoDataException  	{
        try {
            connect();
        } catch (ClassNotFoundException e) {
            throw new GlobalException("No se ha localizado el driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }
        CallableStatement pstmt=null;
        
        try {
            pstmt = connection.prepareCall(INSERTCLIENTACCOUNT);
            pstmt.setString(1,client.getPassword());
            pstmt.setInt(2,client.getId());
            boolean resultado = pstmt.execute();
            if (resultado == true) {
                throw new NoDataException("No se realizo la inserciï¿½n");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new GlobalException("Llave duplicada");
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                disconnect();
            } catch (SQLException e) {
                throw new GlobalException("Estatutos invalidos o nulos");
            }
        }
    }
    
    public void insertClient(BankClient client) throws GlobalException, NoDataException  	{
        try {
            connect();
        } catch (ClassNotFoundException e) {
            throw new GlobalException("No se ha localizado el driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }
        CallableStatement pstmt=null;
        
        try {
            pstmt = connection.prepareCall(INSERTCLIENT);
            pstmt.setInt(1,client.getId());
            boolean resultado = pstmt.execute();
            if (resultado == true) {
                throw new NoDataException("No se realizo la inserciï¿½n");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new GlobalException("Llave duplicada");
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                disconnect();
            } catch (SQLException e) {
                throw new GlobalException("Estatutos invalidos o nulos");
            }
        }
    }
    
    public void insertClientToDB(BankClient client) throws GlobalException, NoDataException{
        insertPerson(client);
        insertClient(client);
        insertClientAccount(client);
    }
    
    public ArrayList consultarPersonaID(int _id) throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankClient> collection = new ArrayList<>();
        BankClient client = null;
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
                    client = new BankClient(
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
    
    public ArrayList clientesTotales() throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankClient> collection = new ArrayList<>();
        BankClient client = null;
        CallableStatement pstmt = null;
        try {
            pstmt = connection.prepareCall(LISTUSERPERSON);
            //pstmt.registerOutParameter(1, Types.INTEGER);
            //pstmt.setInt(1, _id);
            //pstmt.execute();
            
            boolean hadResults = pstmt.execute();
            while (hadResults) {
                rs = pstmt.getResultSet();
 
                // process result set
                while (rs.next()) {
                    client = new BankClient(
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
      
    //------------------------- FIN DE CRUD ---------------------------------------------------
    //Atributos
    //Llamados Metodos de Base de datos
    private static final String INSERTPERSON = "{call insertarPersona(?,?,?,?,?,?,?,?,?,?,?,?)}";
    private static final String INSERTCLIENT = "{call insertarCliente(?)}";
    private static final String INSERTCLIENTACCOUNT = "{call insertarCuentaCliente(?,?)}";
    //private static final String LISTPERSON = "{?=call listaPersona(?)}";
    private static final String LISTPERSON = "{call listaPersona(?)}";
    private static final String LISTUSERPERSON = "{call listaClientesTotales()}";
    
    //Singleton
    private static ClientService instance = null;
}
