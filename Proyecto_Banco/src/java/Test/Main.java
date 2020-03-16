/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Test;

import Bank.data.ClientService;
import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankClient;

/**
 *
 * @author chinc
 */
public class Main {
    public static void main(String[] args) throws GlobalException, NoDataException {
        BankClient client = new BankClient(123,"Juan", "Perez", "Cardozo", "Soltero", "Alajuela", "Alajuela",
                "150mts sur casa verde", "2345", "5678", "j@perez.com", 33, "clave");
        ClientService service = new ClientService();
        service.insertClientToDB(client);
    }
}
