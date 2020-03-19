/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.data;

import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankAccount;
import Bank.logic.BankClient;
import Bank.logic.BankTeller;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author chinc
 */
public class DAO {

    private static DAO mInstance;
    private ArrayList<BankClient> clients;
    private ArrayList<BankTeller> tellers;
    private ArrayList<BankAccount> accounts;

    public static DAO getInstance() {
        if (mInstance == null) {
            mInstance = new DAO();
        }
        return mInstance;
    }

    private DAO() {
        clients = new ArrayList();
        tellers = new ArrayList();
        accounts = new ArrayList();
    }

    /*Clients*/
    public void insertarCliente(BankClient e) {
        ClientService se = new ClientService();
        try {
            se.insertClientToDB(e);
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<BankClient> listarClientes() {
        ClientService se = new ClientService();
        try {
            clients = se.clientesTotales();
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return clients;
    }
    
    public ArrayList<BankClient> consultarClientesID(int id) {
        ClientService se = new ClientService();
        try {
            clients = se.consultarPersonaID(id);
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return clients;
    }
    

    /*Tellers*/
    public ArrayList<BankTeller> listarCajeros() {
        TellerService se = new TellerService();
        try {
            tellers = se.cajerosTotales();
        } catch (GlobalException | NoDataException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tellers;
    }

    /*Accounts*/
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
