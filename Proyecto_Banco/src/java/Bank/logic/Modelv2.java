package Bank.logic;

import Bank.data.DAO;
import java.util.ArrayList;


// Al momento de hacer esto no he implementado los controles de los servicios por tanto es que se instancia aqui para que sirva,
public class Modelv2 {
    private static Modelv2 uniqueInstance;
    ArrayList<BankUser> users;
    ArrayList<BankAccount> accounts;
    
    
    public static Modelv2 instance(){
        if (uniqueInstance == null){
            uniqueInstance = new Modelv2();
        }
        return uniqueInstance; 
    }
    
    private Modelv2(){
        users = new ArrayList();
        accounts = new ArrayList();
    }
    
    
    public BankUser clientFind(int cedula, String password) throws Exception{
        users = DAO.getInstance().listarClientes();
        int aux = 0;
        for(int i = 0; i < users.size(); i++){
            if(users.get(i).getId() == cedula && users.get(i).getPassword().equals(password)){
                aux = i;
            } 
        }
        return users.get(aux);
    }
    
    public BankUser clientFind(BankUser usuario) throws Exception{
        users = DAO.getInstance().listarClientes();
        int aux = 0;
        for(int i = 0; i < users.size(); i++){
            if(users.get(i).equals(usuario)){
                aux = i;
            } 
        }
        return users.get(aux);
    } 
    
//    public BankTeller tellerFind(int cedula, String password) throws Exception{
//        tellers = DAO.getInstance().listarCajeros();
//        int aux = 0;
//        for(int i = 0; i < tellers.size(); i++){
//            if(tellers.get(i).getId() == cedula && tellers.get(i).getPassword().equals(password)){
//                aux = i;
//            } 
//        }
//        return tellers.get(aux);
//    }
//    
//    public BankTeller tellerFind(BankTeller usuario) throws Exception{
//        tellers = DAO.getInstance().listarCajeros();
//        int aux = 0;
//        for(int i = 0; i < tellers.size(); i++){
//            if(tellers.get(i).equals(usuario)){
//                aux = i;
//            } 
//        }
//        return tellers.get(aux);
//    } 
    
    public ArrayList<BankAccount> cuentasFind(BankUser cliente) throws Exception{
        accounts = DAO.getInstance().consultarCuentasID(cliente.getId());
        return  accounts;
    }
    
//    public ArrayList<BankAccount> favoritasFind(BankClient cliente) throws Exception{
//        
//    }
  
    public BankAccount cuentaFind(int numero) throws Exception{
        return DAO.getInstance().consultarCuentasNumero(numero).get(numero);
    }   
}
