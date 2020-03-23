/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.logic;

import java.util.ArrayList;

/**
 *
 * @author jpabl
 */
public class Client {

    BankUser usuario;
    ArrayList<BankAccount> cuentas;
    ArrayList<String> favoritos;
    int tipo;

    public Client(BankUser usuario, ArrayList<BankAccount> cuentas, ArrayList<String> favoritos, int tipo) {
        this.usuario = usuario;
        this.cuentas = cuentas;
        this.favoritos = favoritos;
        this.tipo = tipo;
    }

    public Client(BankUser usuario, int tipo) {
        this.usuario = usuario;
        this.cuentas = null;
        this.favoritos = null;
        this.tipo = tipo;
    }

    public Client() {
        this.usuario = null;
        this.cuentas = null;
        this.favoritos = null;
        this.tipo = 0;
    }

    public BankUser getUsuario() {
        return usuario;
    }

    public void setUsuario(BankUser usuario) {
        this.usuario = usuario;
    }

    public ArrayList<BankAccount> getCuentas() {
        return cuentas;
    }

    public void setCuentas(ArrayList<BankAccount> cuentas) {
        this.cuentas = cuentas;
    }

    public ArrayList<String> getFavoritos() {
        return favoritos;
    }

    public void setFavoritos(ArrayList<String> favoritos) {
        this.favoritos = favoritos;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    @Override
    public String toString() {
        return "Client{" + "usuario=" + usuario + ", cuentas=" + cuentas + ", favoritos=" + favoritos + ", tipo=" + tipo + '}';
    }

    
}
