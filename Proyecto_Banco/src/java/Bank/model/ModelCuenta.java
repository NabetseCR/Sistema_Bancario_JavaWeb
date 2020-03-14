/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.model;

import Bank.logic.Cuenta;

/**
 *
 * @author Escinf
 */
public class ModelCuenta{
    Cuenta current;

    public ModelCuenta() {
        current = new Cuenta("",0.0,null);
    }

    public Cuenta getCurrent() {
        return current;
    }

    public void setCurrent(Cuenta current) {
        this.current = current;
    }

}
