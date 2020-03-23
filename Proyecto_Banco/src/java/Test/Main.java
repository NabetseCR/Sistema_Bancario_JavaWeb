package Test;


import Bank.data.DAO;
import Bank.exceptions.GlobalException;
import Bank.exceptions.NoDataException;
import Bank.logic.BankAccount;
import Bank.logic.BankUser;
import java.util.ArrayList;


public class Main {
    public static void main(String[] args) throws GlobalException, NoDataException {
//        BankClient client = new BankClient(123,"Juan", "Perez", "Cardozo", "Soltero", "Alajuela", "Alajuela",
//                "150mts sur casa verde", "2345", "5678", "j@perez.com", 33, "clave");
//          TellerService service = new TellerService();
//        service.insertClientToDB(client);
//          ArrayList<BankTeller> ls = service.cajerosTotales();
//          System.out.println(ls.toString());
//
//          BankAccount account = new BankAccount(111,2,4.2);
//          BankAccountService service = new BankAccountService();
//          // OJO solo sirve con 333 porque esta tiene la fecha completa no en 0s
//          ArrayList<BankAccount> ls = service.searchBankAccountNumb(4);
//          System.out.println(ls.toString());

//            ArrayList<BankUser> ls1 = DAO.getInstance().listarClientes();
//            System.out.println(ls1.toString());
//            
//            System.out.println();
//            System.out.println();
//            
//            ArrayList<BankUser> ls2 = DAO.getInstance().listarCajeros();
//            System.out.println(ls2.toString());
            
            ArrayList<BankAccount> ls3 = DAO.getInstance().consultarCuentasID(111);
            System.out.println(ls3.toString());

    }
}
