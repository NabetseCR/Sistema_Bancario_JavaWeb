/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Test;

import Bank.data.BankAccountService;
import Bank.data.ClientService;
import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankAccount;
import Bank.logic.BankClient;
import java.util.ArrayList;

/**
 *
 * @author chinc
 */
public class Main {
    public static void main(String[] args) throws GlobalException, NoDataException {
//        BankClient client = new BankClient(123,"Juan", "Perez", "Cardozo", "Soltero", "Alajuela", "Alajuela",
//                "150mts sur casa verde", "2345", "5678", "j@perez.com", 33, "clave");
//          ClientService service = new ClientService();
//        service.insertClientToDB(client);
//          ArrayList<BankClient> ls = service.consultarPersonaID(222);
//          System.out.println(ls.toString());

//          BankAccount account = new BankAccount(111,2,4.2);
          BankAccountService service = new BankAccountService();
          // OJO solo sirve con 333 porque esta tiene la fecha completa no en 0s
          ArrayList<BankAccount> ls = service.searchBankAccountNumb(4);
          System.out.println(ls.toString());
    }
}
