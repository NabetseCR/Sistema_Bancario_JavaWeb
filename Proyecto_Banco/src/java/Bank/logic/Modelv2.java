/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.logic;

import Bank.data.BankService;
import java.util.ArrayList;

/**
 *
 * @author chinc
 */


// Al momento de hacer esto no he implementado los controles de los servicios por tanto es que se instancia aqui para que sirva,
public class Modelv2 {
    private static Modelv2 uniqueInstance;
    
    public static Modelv2 instance(){
        if (uniqueInstance == null){
            uniqueInstance = new Modelv2();
        }
        return uniqueInstance; 
    }
    
    ArrayList<BankClient> clients;
    ArrayList<BankTeller> tellers;
    ArrayList<BankAccount> accounts;
    
    //No implemente control del servicio, por tanto lo puse aqui, se realiza asi tentativamente
    //Control no se implementa por necesidad de dormir
    BankService service;
    //HashMap<String,List<String>> favoritas;
    
    private Modelv2(){
        clients = new ArrayList();
        accounts = new ArrayList();
        tellers = new ArrayList();
        service = new BankService();
    }
    
    
    public BankClient clientFind(int cedula, String password) throws Exception{
        clients = service.getClients();
        int aux = 0;
        for(int i = 0; i < clients.size(); i++){
            if(clients.get(i).getId() == cedula && clients.get(i).getPassword().equals(password)){
                aux = i;
            } 
        }
        return clients.get(aux);
    }
    
    public BankClient clientFind(BankClient usuario) throws Exception{
        clients = service.getClients();
        int aux = 0;
        for(int i = 0; i < clients.size(); i++){
            if(clients.get(i).equals(usuario)){
                aux = i;
            } 
        }
        return clients.get(aux);
    } 
    
    public BankTeller tellerFind(int cedula, String password) throws Exception{
        tellers = service.getTellers();
        int aux = 0;
        for(int i = 0; i < tellers.size(); i++){
            if(tellers.get(i).getId() == cedula && tellers.get(i).getPassword().equals(password)){
                aux = i;
            } 
        }
        return tellers.get(aux);
    }
    
    public BankTeller tellerFind(BankTeller usuario) throws Exception{
        tellers = service.getTellers();
        int aux = 0;
        for(int i = 0; i < tellers.size(); i++){
            if(tellers.get(i).equals(usuario)){
                aux = i;
            } 
        }
        return tellers.get(aux);
    } 
    
//    public List<Cuenta> cuentasFind(Cliente cliente) throws Exception{
//        List<Cuenta> result = new ArrayList();
//        for(Cuenta c: cuentas.values()){
//            if(c.getCliente().equals(cliente)){
//                result.add(c);
//            }
//        }
//        return result;
//    }
//    
//    public List<Cuenta> favoritasFind(Cliente cliente) throws Exception{
//        List<Cuenta> result = new ArrayList();
//        for(String nc: favoritas.get(cliente.getCedula())){
//                result.add(cuentas.get(nc));
//        }
//        return result;
//    }
//
//    public void clienteUpdate(Cliente cliente) throws Exception{
//        if (clientes.get(cliente.getCedula())==null) 
//            throw new Exception("Cliente no existe");
//        else{
//            clientes.get(cliente.getCedula()).setNombre(cliente.getNombre());
//        }
//    }
//    
//    public Cuenta cuentaFind(String numero) throws Exception{
//        if (cuentas.get(numero)!=null) return cuentas.get(numero);
//        else throw new Exception("Cuenta no existe");
//    }   
}
