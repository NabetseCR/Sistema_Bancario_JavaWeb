package Bank.data;

import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankUser;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class UserService extends Service {
    
    //Atributos
    private static final String INSERTCLIENT = "{call insertarCliente(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
    private static final String LISTCLIENTS = "{call listarClientes()}";
    private static final String SEARCHCLIENTID = "{call consultaClienteID(?)}";
    
    private static final String LISTTELLERS = "{call listarCajeros()}";
    private static final String SEARCHTELLERID = "{call consultaCajeroID(?)}";
    
    //Constructor

    public UserService() {
    }
    
    //Recordar que cajeros se manejan directamente de la DB
    //No existe requerimiento de modificar via aplicacion el registro, o maniuplacion de los mismos
    //PERO SI PARA LOGIN
    
    /*--------- Modulo Usuarios Clientes --------------*/
    
    
    //Insertar
    
    public void insertarCliente(BankUser client) throws GlobalException, NoDataException{
        try {
            connect();
        } catch (ClassNotFoundException e) {
            throw new GlobalException("No se ha localizado el driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }
        CallableStatement pstmt = null;

        try {
            pstmt = connection.prepareCall(INSERTCLIENT);
            pstmt.setInt(1, client.getId());
            pstmt.setString(2, client.getName());
            pstmt.setString(3, client.getFirst_surname());
            pstmt.setString(4, client.getSecond_surname());
            pstmt.setString(5, client.getMarital_status());
            pstmt.setString(6, client.getCity());
            pstmt.setString(7, client.getPlace());
            pstmt.setString(8, client.getAddress());
            pstmt.setString(9, client.getTelephone());
            pstmt.setString(10, client.getCellphone());
            pstmt.setString(11, client.getEmail());
            pstmt.setInt(12, client.getAge());
            pstmt.setString(13, client.getPassword());
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
    
    //Listar
    
    public ArrayList<BankUser> listarClientes() throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankUser> collection = new ArrayList<>();
        BankUser client = null;
        CallableStatement pstmt = null;
        try {
            pstmt = connection.prepareCall(LISTCLIENTS);
            boolean hadResults = pstmt.execute();
            while (hadResults) {
                rs = pstmt.getResultSet();

                // process result set
                while (rs.next()) {
                    client = new BankUser(
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
    
    //Consultar
    
    public ArrayList<BankUser> consultarClienteID(int _id) throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankUser> collection = new ArrayList<>();
        BankUser client = null;
        CallableStatement pstmt = null;
        try {
            pstmt = connection.prepareCall(SEARCHCLIENTID);
            pstmt.setInt(1, _id);

            boolean hadResults = pstmt.execute();
            while (hadResults) {
                rs = pstmt.getResultSet();

                // process result set
                while (rs.next()) {
                    client = new BankUser(
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
    
    
    
    
    /*--------- Modulo Usuarios Cajeros --------------*/
    
    
    //Listar
    
    public ArrayList<BankUser> listarCajeros() throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankUser> collection = new ArrayList<>();
        BankUser client = null;
        CallableStatement pstmt = null;
        try {
            pstmt = connection.prepareCall(LISTTELLERS);
            boolean hadResults = pstmt.execute();
            while (hadResults) {
                rs = pstmt.getResultSet();

                // process result set
                while (rs.next()) {
                    client = new BankUser(
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
    
    //Consultar
    
    public ArrayList<BankUser> consultarCajeroID(int _id) throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankUser> collection = new ArrayList<>();
        BankUser client = null;
        CallableStatement pstmt = null;
        try {
            pstmt = connection.prepareCall(SEARCHTELLERID);
            pstmt.setInt(1, _id);

            boolean hadResults = pstmt.execute();
            while (hadResults) {
                rs = pstmt.getResultSet();

                // process result set
                while (rs.next()) {
                    client = new BankUser(
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
}
