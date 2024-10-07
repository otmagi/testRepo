package com.bean;

import java.io.Serializable;

public class Message{
    int id;
    String name;
    String subject;
    int age;
    String xueyuan;
    String intro;

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", subject='" + subject + '\'' +
                ", age=" + age +
                ", xueyuan='" + xueyuan + '\'' +
                ", intro='" + intro + '\'' +
                '}';
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

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getXueyuan() {
        return xueyuan;
    }

    public void setXueyuan(String xueyuan) {
        this.xueyuan = xueyuan;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }
}
