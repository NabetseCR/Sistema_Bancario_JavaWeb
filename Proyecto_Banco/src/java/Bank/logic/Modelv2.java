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
        service = new BankService();
    }
    
    
//    public BankClient clientFind(String cedula,String clave) throws Exception{
//        if (usuarios.get(cedula)!=null) return usuarios.get(cedula);
//        else throw new Exception("Usuario no existe");
//    }
//
//    public Cliente clienteFind(Usuario usuario) throws Exception{
//        if (clientes.get(usuario.getCedula())!=null) return clientes.get(usuario.getCedula());
//        else throw new Exception("Cliente no existe");
//    }    
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
