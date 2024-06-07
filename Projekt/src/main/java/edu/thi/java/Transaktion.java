package edu.thi.java;

import java.io.Serializable;
import java.sql.Timestamp;

public class Transaktion implements Serializable {
	private static final long serialVersionUID = 1L;

	private long t_id;
	private String von;
	private String nach;
	private double summe;
	private Timestamp zeitstempel;
	private String senderVorname;
	private String senderNachname;
	private String empfaengerVorname;
	private String empfaengerNachname;
	private String verzweck;

	public Transaktion() {
	}

	public Transaktion(long t_id, String von, String nach, double summe, Timestamp zeitstempel) {
		super();
		this.t_id = t_id;
		this.von = von;
		this.nach = nach;
		this.summe = summe;
		this.zeitstempel = zeitstempel;
	}

	public long getT_id() {
		return t_id;
	}

	public void setT_id(long t_id) {
		this.t_id = t_id;
	}

	public String getVon() {
		return von;
	}

	public void setVon(String von) {
		this.von = von;
	}

	public String getNach() {
		return nach;
	}

	public void setNach(String nach) {
		this.nach = nach;
	}

	public double getSumme() {
		return summe;
	}

	public void setSumme(double summe) {
		this.summe = summe;
	}

	public Timestamp getZeitstempel() {
		return zeitstempel;
	}

	public void setZeitstempel(Timestamp zeitstempel) {
		this.zeitstempel = zeitstempel;
	}

	public String getSenderVorname() {
		return senderVorname;
	}

	public void setSenderVorname(String senderVorname) {
		this.senderVorname = senderVorname;
	}

	public String getSenderNachname() {
		return senderNachname;
	}

	public void setSenderNachname(String senderNachname) {
		this.senderNachname = senderNachname;
	}

	public String getEmpfaengerVorname() {
		return empfaengerVorname;
	}

	public void setEmpfaengerVorname(String empfaengerVorname) {
		this.empfaengerVorname = empfaengerVorname;
	}

	public String getEmpfaengerNachname() {
		return empfaengerNachname;
	}

	public void setEmpfaengerNachname(String empfaengerNachname) {
		this.empfaengerNachname = empfaengerNachname;
	}

	public String getVerzweck() {
		return verzweck;
	}

	public void setVerzweck(String verzweck) {
		this.verzweck = verzweck;
	}
}
