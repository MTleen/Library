package dao;

import java.io.*;


/**
 * Created by HuShengxiang on 12/10/2017.
 */
public class BookModel {
    private String name;
    private int id, type, total, amount;
    private String version;
    private String author;
    private String cover;
    private String initTime = "", deadline = "", isExtended = "";
    File coverFile;
    public void setName(String name){
        this.name = name;
    }
    public String getName(){
        return this.name;
    }
    public void setType(int type){
        this.type = type;
    }
    public int getType(){
        return this.type;
    }
    public void setTotal(int total){
        this.total = total;
    }
    public int getTotal(){
        return this.total;
    }
    public void setId(int id){
        this.id = id;
    }
    public int getId(){
        return this.id;
    }
    public void setVersion(String version){
        this.version = version;
    }
    public String getVersion(){
        return this.version;
    }
    public void setCover(String cover){
        this.cover = cover;
    }
    public String getCover(){
        return  this.cover;
    }
    public void setAuthor(String author){
        this.author = author;
    }
    public String getAuthor(){
        return this.author;
    }
    public void setCoverFile(File coverFile){
        this.coverFile = coverFile;
    }
    public File getCoverFile(){
        return this.coverFile;
    }
    public void setAmount(int amount){
        this.amount = amount;
    }
    public int getAmount(){
        return this.amount;
    }
    public void setInitTime(String t){
        this.initTime = t;
        System.out.print(t);
    }
    public String getInitTime(){
        return this.initTime;
    }
    public void setDeadline(String deadline){
        this.deadline = deadline;
    }
    public String getDeadline(){
        return this.deadline;
    }
    public void setIsExtended(String isExtended){
        this.isExtended = isExtended;
    }
    public String getIsExtended(){
        return this.isExtended;
    }
}
