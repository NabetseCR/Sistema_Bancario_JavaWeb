/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.model;

import Bank.logic.Usuario;

/**
 *
 * @author jsanchez
 */
public class ModelLogin {
    Usuario current;

    public ModelLogin() {
        this.reset();
    }
    
    public void reset(){
        setCurrent(new Usuario());        
    }
    
    public Usuario getCurrent() {
        return current;
    }

    public void setCurrent(Usuario current) {
        this.current = current;
    }
   
}
