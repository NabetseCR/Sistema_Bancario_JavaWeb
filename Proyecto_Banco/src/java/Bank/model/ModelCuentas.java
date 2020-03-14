/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.model;

import Bank.logic.Cuenta;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Escinf
 */
public class ModelCuentas{
    List<Cuenta> cuentas;
    Cuenta seleccionado;

    public ModelCuentas() {
        this.reset();
    }

    public void reset(){ 
        List<Cuenta> rows = new ArrayList<>();        
        seleccionado=null;  
        this.setCuentas(rows);
    }
    
    public void setCuentas(List<Cuenta> cuentas){
        this.cuentas =cuentas;    
    }

     public List<Cuenta> getCuentas() {
        return cuentas;
    }

    public Cuenta getSeleccionado() {
        return seleccionado;
    }

    public void setSeleccionado(Cuenta seleccionado) {
        this.seleccionado = seleccionado;
    }
}
