/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.logic;

import java.util.Objects;

/**
 *
 * @author chinc
 */
// Esta clase es igual a BankTeller simplemente se utiliza para distincion en login
public class BankTeller {
    int id;
    String name;
    String first_surname;
    String second_surname;
    String marital_status;
    String city;
    String place;
    String address;
    String telephone;
    String cellphone;
    String email;
    int age;
    String password;

    public BankTeller() {
    }

    public BankTeller(int id, String name, String first_surname, String second_surname, String marital_status, String city, String place, String address, String telephone, String cellphone, String email, int age, String password) {
        this.id = id;
        this.name = name;
        this.first_surname = first_surname;
        this.second_surname = second_surname;
        this.marital_status = marital_status;
        this.city = city;
        this.place = place;
        this.address = address;
        this.telephone = telephone;
        this.cellphone = cellphone;
        this.email = email;
        this.age = age;
        this.password = password;
    }

    //Constructor para Consultar personas

    public BankTeller(int id, String name, String first_surname, String second_surname, String marital_status, String city, String place, String address, String telephone, String cellphone, String email, int age) {
        this.id = id;
        this.name = name;
        this.first_surname = first_surname;
        this.second_surname = second_surname;
        this.marital_status = marital_status;
        this.city = city;
        this.place = place;
        this.address = address;
        this.telephone = telephone;
        this.cellphone = cellphone;
        this.email = email;
        this.age = age;
    }
    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFirst_surname() {
        return first_surname;
    }

    public void setFirst_surname(String first_surname) {
        this.first_surname = first_surname;
    }

    public String getSecond_surname() {
        return second_surname;
    }

    public void setSecond_surname(String second_surname) {
        this.second_surname = second_surname;
    }

    public String getMarital_status() {
        return marital_status;
    }

    public void setMarital_status(String marital_status) {
        this.marital_status = marital_status;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final BankTeller other = (BankTeller) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "BankTeller{" + "id=" + id + ", name=" + name + ", first_surname=" + first_surname + ", second_surname=" + second_surname + ", marital_status=" + marital_status + ", city=" + city + ", place=" + place + ", address=" + address + ", telephone=" + telephone + ", cellphone=" + cellphone + ", email=" + email + ", age=" + age + ", password=" + password +'}';
    }
}
