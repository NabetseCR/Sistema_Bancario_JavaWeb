/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.data;

import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankAccount;
import Bank.logic.BankUser;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author chinc
 */
public class DAO {

    private static DAO mInstance;
    private ArrayList<BankUser> clients;
    private ArrayList<BankAccount> accounts;

    public static DAO getInstance() {
        if (mInstance == null) {
            mInstance = new DAO();
        }
        return mInstance;
    }

    private DAO() {
        clients = new ArrayList();
        accounts = new ArrayList();
    }

    /*---------------  Modulo UserService ------------------*/
    public void insertarCliente(BankUser e) {
        UserService se = new UserService();
        try {
            se.insertarCliente(e);
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<BankUser> listarClientes() {
        UserService se = new UserService();
        try {
            clients = se.listarClientes();
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return clients;
    }
    
    public ArrayList<BankUser> consultarClienteID(int id) {
        UserService se = new UserService();
        try {
            clients = se.consultarClienteID(id);
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return clients;
    }
    
    public ArrayList<BankUser> listarCajeros() {
        UserService se = new UserService();
        try {
            clients = se.listarCajeros();
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return clients;
    }
    
    public ArrayList<BankUser> consultarCajeroID(int id) {
        UserService se = new UserService();
        try {
            clients = se.consultarCajeroID(id);
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return clients;
    }
    

    /*----------- Modulo BankAccountService ---------------------------*/
    public void insertarCuenta(BankAccount e) {
        BankAccountService se = new BankAccountService();
        try {
            se.insertBankAccounnt(e);
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<BankAccount> consultarCuentasID(int id) {
        BankAccountService se = new BankAccountService();
        try {
            accounts = se.searchBankAccountID(id);
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return accounts;
    }

    public ArrayList<BankAccount> consultarCuentasNumero(int numero) {
        BankAccountService se = new BankAccountService();
        try {
            accounts = se.searchBankAccountNumb(numero);
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return accounts;
    }

}
