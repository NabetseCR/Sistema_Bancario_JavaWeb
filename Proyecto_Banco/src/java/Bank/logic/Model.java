/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.logic;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Escinf
 */
public class Model {
    private static Model uniqueInstance;
    
    public static Model instance(){
        if (uniqueInstance == null){
            uniqueInstance = new Model();
        }
        return uniqueInstance; 
    }

    HashMap<String,Usuario> usuarios;
    HashMap<String,Cliente> clientes;
    HashMap<String,Cuenta> cuentas;
    HashMap<String,List<String>> favoritas;
    
    
    private Model(){
        usuarios = new HashMap();
        usuarios.put("111", new Usuario("111","111",1));
        usuarios.put("222", new Usuario("222","222",1));
        usuarios.put("333", new Usuario("333","333",2));
        
        clientes = new HashMap(); 
        clientes.put("111", new Cliente("111","J.Perez",usuarios.get("111")));
        clientes.put("222", new Cliente("222","B.Banner",usuarios.get("222")));
        clientes.put("333", new Cliente("333","L.Kjero",usuarios.get("333")));
        
        cuentas = new HashMap(); 
        cuentas.put("1-111-11", new Cuenta("1-111-11",100.0,clientes.get("111")));
        cuentas.put("1-222-22", new Cuenta("1-222-22",200.0,clientes.get("111")));        
        cuentas.put("2-111-11", new Cuenta("2-111-11",150.0,clientes.get("222")));

        //HashMap<String,List<String>> favoritas;
        favoritas = new HashMap(); 
        favoritas.put("111", Arrays.asList(new String[]{"2-111-11"}));
        favoritas.put("222", Arrays.asList(new String[]{"1-111-11","1-222-22"}));
    }

    public Usuario usuarioFind(String cedula,String clave) throws Exception{
        if (usuarios.get(cedula)!=null) return usuarios.get(cedula);
        else throw new Exception("Usuario no existe");
    }

    public Cliente clienteFind(Usuario usuario) throws Exception{
        if (clientes.get(usuario.getCedula())!=null) return clientes.get(usuario.getCedula());
        else throw new Exception("Cliente no existe");
    }    
    public List<Cuenta> cuentasFind(Cliente cliente) throws Exception{
        List<Cuenta> result = new ArrayList();
        for(Cuenta c: cuentas.values()){
            if(c.getCliente().equals(cliente)){
                result.add(c);
            }
        }
        return result;
    }
    
    public List<Cuenta> favoritasFind(Cliente cliente) throws Exception{
        List<Cuenta> result = new ArrayList();
        for(String nc: favoritas.get(cliente.getCedula())){
                result.add(cuentas.get(nc));
        }
        return result;
    }

    public void clienteUpdate(Cliente cliente) throws Exception{
        if (clientes.get(cliente.getCedula())==null) 
            throw new Exception("Cliente no existe");
        else{
            clientes.get(cliente.getCedula()).setNombre(cliente.getNombre());
        }
    }
    
    public Cuenta cuentaFind(String numero) throws Exception{
        if (cuentas.get(numero)!=null) return cuentas.get(numero);
        else throw new Exception("Cuenta no existe");
    }    
}
