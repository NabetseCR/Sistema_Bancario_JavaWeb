/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.data;

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
    
    //Singleton
    private static BankService instance = null;
    //Cada servicio existente
    BankAccountService accountService;
    ClientService clientService;
    TellerService tellerService;
    
}
