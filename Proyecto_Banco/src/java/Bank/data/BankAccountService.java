/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.data;

import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankAccount;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author chinc
 */
public class BankAccountService extends Service {

    private static final String INSERTBANKACCOUNT = "{call insertarCuenta(?,?,?)}";
    private static final String LISTBANKACCOUNTNUMB = "{call listaCuenta(?)}";
    private static final String LISTBANKACCOUNTID = "{call listaCuentaID(?)}";

    public BankAccountService() {

    }

    public void insertBankAccounnt(BankAccount account) throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException e) {
            throw new GlobalException("No se ha localizado el driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }
        CallableStatement pstmt = null;

        try {
            pstmt = connection.prepareCall(INSERTBANKACCOUNT);
            pstmt.setInt(1, account.getIdclient());
            pstmt.setInt(2, account.getCurrency());
            pstmt.setDouble(3, account.getInterest());
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

    public ArrayList searchBankAccountID(int _id) throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankAccount> collection = new ArrayList<>();
        BankAccount account = null;
        CallableStatement pstmt = null;
        try {
            pstmt = connection.prepareCall(LISTBANKACCOUNTID);
            //pstmt.registerOutParameter(1, Types.INTEGER);
            pstmt.setInt(1, _id);
            //pstmt.execute();

            boolean hadResults = pstmt.execute();
            while (hadResults) {
                rs = pstmt.getResultSet();

                // process result set
                while (rs.next()) {
                    account = new BankAccount(
                            rs.getInt("numero"),
                            rs.getInt("id_persona"),
                            rs.getInt("id_moneda"),
                            rs.getDouble("saldo"),
                            rs.getDouble("interes"),
                            rs.getDate("fecha_creacion"));
                    collection.add(account);
                }

                hadResults = pstmt.getMoreResults();
            }

            pstmt.close();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return collection;
    }

    public ArrayList<BankAccount> searchBankAccountNumb(int _numb) throws GlobalException, NoDataException {
        try {
            connect();
        } catch (ClassNotFoundException ex) {
            throw new GlobalException("No se ha localizado el Driver");
        } catch (SQLException e) {
            throw new NoDataException("La base de datos no se encuentra disponible");
        }

        ResultSet rs = null;
        ArrayList<BankAccount> collection = new ArrayList<>();
        BankAccount account = null;
        CallableStatement pstmt = null;
        try {
            pstmt = connection.prepareCall(LISTBANKACCOUNTNUMB);
            //pstmt.registerOutParameter(1, Types.INTEGER);
            pstmt.setInt(1, _numb);
            //pstmt.execute();

            boolean hadResults = pstmt.execute();
            while (hadResults) {
                rs = pstmt.getResultSet();

                // process result set
                while (rs.next()) {
                    account = new BankAccount(
                            rs.getInt("numero"),
                            rs.getInt("id_persona"),
                            rs.getInt("id_moneda"),
                            rs.getDouble("saldo"),
                            rs.getDouble("interes"),
                            rs.getDate("fecha_creacion"));
                    collection.add(account);
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
