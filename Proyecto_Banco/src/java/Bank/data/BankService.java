/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.data;

import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankClient;
import Bank.logic.BankTeller;
import java.util.ArrayList;

/**
 *
 * @author chinc
 */
public class BankService {
    public BankService() {
        accountService = BankAccountService.getInstance();
        clientService = ClientService.getInstance();
        tellerService = TellerService.getInstance();
    }
    
    public static BankService getInstance() {
        if (instance == null) {
            instance= new BankService();
        }
        return instance;
        
    }
    
    public ArrayList<BankClient> getClients() throws GlobalException, NoDataException{
        return clientService.clientesTotales();
    }
    
    public ArrayList<BankTeller> getTellers() throws GlobalException, NoDataException{
        return tellerService.cajerosTotales();
    }
    
    //Singleton
    private static BankService instance = null;
    //Cada servicio existente
    BankAccountService accountService;
    ClientService clientService;
    TellerService tellerService;
    
}
