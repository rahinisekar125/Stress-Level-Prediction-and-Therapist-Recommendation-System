package com.stress;

public class User {
    private String username;
    private String password;
    private String location;
    private int age;

    public User(String username, String password, String location, int age) {
        this.username = username;
        this.password = password;
        this.location = location;
        this.age = age;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getLocation() {
        return location;
    }

    public int getAge() {
        return age;
    }
}