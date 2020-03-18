/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.logic;

import java.sql.Date;

/**
 *
 * @author chinc
 */
public class BankAccount {
    
    int number;
    int idclient;
    int currency;
    double balance;
    double interest;
    Date creationDate;

    public BankAccount() {
    }

    //Para consultas
    public BankAccount(int number, int idclient, int currency, double balance, double interest, Date creationDate) {
        this.number = number;
        this.idclient = idclient;
        this.currency = currency;
        this.balance = balance;
        this.interest = interest;
        this.creationDate = creationDate;
    }
    
    //Para Insertar ya que numero, saldo y fecha se genera automaticamente en db
    public BankAccount(int idclient, int currency, double interest) {
        this.idclient = idclient;
        this.currency = currency;
        this.interest = interest;
    }

    public int getNumber() {
        return number;
    }

    public int getCurrency() {
        return currency;
    }

    public double getBalance() {
        return balance;
    }

    public double getInterest() {
        return interest;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public void setCurrency(int currency) {
        this.currency = currency;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public void setInterest(double interest) {
        this.interest = interest;
    }

    public int getIdclient() {
        return idclient;
    }
    
    @Override
    public String toString() {
        return "BankAccount{" + "number=" + number + ", idclient=" + idclient + ", currency=" + currency + ", balance=" + balance + ", interest=" + interest + ", creationDate=" + creationDate + '}';
    }

    
    
}


