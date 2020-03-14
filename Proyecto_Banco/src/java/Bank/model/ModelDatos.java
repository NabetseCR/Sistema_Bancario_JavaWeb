/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.model;

import Bank.logic.Cliente;
import Bank.logic.Usuario;

/**
 *
 * @author Escinf
 */
public class ModelDatos{
    Cliente current;

    public ModelDatos() {
        this.current = new Cliente("","",new Usuario("","",1));
    }

    
    public Cliente getCurrent() {
        return current;
    }

    public void setCurrent(Cliente current) {
        this.current = current;
    }
    
    
}
