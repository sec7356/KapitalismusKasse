package edu.thi.java;

import java.io.Serializable;
import java.util.Date;

public class Benutzer implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long b_id;
	private String vorname;
	private String nachname;
	private String email;
	private int pin;
	private boolean admin;
	
	public Benutzer() {
	}
	
	public Benutzer(Long b_id, String vorname, String nachname, String email, int pin, boolean admin) {
		super();
		this.b_id = b_id;
		this.vorname = vorname;
		this.nachname = nachname;
		this.email = email;
		this.pin = pin;
		this.admin = admin;
	}
	
	public Long getB_id() {
		return b_id;
	}
	public void setB_id(Long b_id) {
		this.b_id = b_id;
	}
	public String getVorname() {
		return vorname;
	}
	public void setVorname(String vorname) {
		this.vorname = vorname;
	}
	public String getNachname() {
		return nachname;
	}
	public void setNachname(String nachname) {
		this.nachname = nachname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPin() {
		return pin;
	}
	public void setPin(int pin) {
		this.pin = pin;
	}
	public boolean isAdmin() {
		return admin;
	}
	public void setAdmin(boolean admin) {
		this.admin = admin;
	}
}
