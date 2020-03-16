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
//    
//    public ArrayList consultarAvionIdentificador(String identificadorp) throws GlobalException, NoDataException {
//        try {
//            conectar();
//        } catch (ClassNotFoundException ex) {
//            throw new GlobalException("No se ha localizado el Driver");
//        } catch (SQLException e) {
//            throw new NoDataException("La base de datos no se encuentra disponible");
//        }
//
//        ResultSet rs = null;
//        ArrayList<Avion> coleccion = new ArrayList<>();
//        Avion avion = null;
//        CallableStatement pstmt = null;
//        try {
//            pstmt = conexion.prepareCall(CONSULTARAVIONID);
//            pstmt.registerOutParameter(1, OracleTypes.CURSOR);
//            pstmt.setString(2, identificadorp);
//            pstmt.execute();
//            rs = (ResultSet) pstmt.getObject(1);
//            while (rs.next()) {
//                avion = new Avion(
//                        rs.getString("identificador"),
//                        rs.getString("annio"),
//                        rs.getString("modelo"),
//                        rs.getString("marca"),
//                        rs.getInt("cantidad_pasajeros"),
//                        rs.getInt("cantidad_filas"),
//                        rs.getInt("asientos_fila"),
//                        rs.getString("tipo"));
//                coleccion.add(avion);
//            }
//            for (Avion e : coleccion) {
//                System.out.println(e.toString());
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//
//            throw new GlobalException("Sentencia no valida");
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//                if (pstmt != null) {
//                    pstmt.close();
//                }
//                desconectar();
//            } catch (SQLException e) {
//                throw new GlobalException("Estatutos invalidos o nulos");
//            }
//        }
//        if (coleccion == null || coleccion.size() == 0) {
//            throw new NoDataException("No hay datos");
//        }
//        return coleccion;
//    }
      
    //------------------------- FIN DE CRUD ---------------------------------------------------
    //Atributos
    //Llamados Metodos de Base de datos
    private static final String INSERTPERSON = "{call insertarPersona(?,?,?,?,?,?,?,?,?,?,?,?)}";
    private static final String INSERTCLIENT = "{call insertarCliente(?)}";
    private static final String INSERTCLIENTACCOUNT = "{call insertarCuentaCliente(?,?)}";
    
    //Singleton
    private static ClientService instance = null;
}
