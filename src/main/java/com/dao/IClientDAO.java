package com.dao;

import com.entities.Client;

import java.util.List;

public interface IClientDAO extends Idao<Client> {

    Client checkLogin(String email, String password);

    List<Client> getAll();
    public boolean isExist(String email);

    public boolean register(Client client);
    String getRandom();
    boolean sendEmail(String toEmail, String otp);



}
