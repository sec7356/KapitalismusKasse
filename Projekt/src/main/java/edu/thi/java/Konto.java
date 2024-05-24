package edu.thi.java;

import java.io.Serializable;

public class Konto implements Serializable {
private static final long serialVersionUID = 1L;
	
	private String IBAN;
	private long besitzer;
	private String kontoArt;
	private double kontoStand;
	
	public Konto() {
		 
	}
	
		public Konto(String iBAN, long besitzer, String kontoArt, double kontoStand) {
		super();
		this.IBAN = iBAN;
		this.besitzer = besitzer;
		this.kontoArt = kontoArt;
		this.kontoStand = kontoStand;
	}

		public String getIBAN() {
			return IBAN;
		}

		public void setIBAN(String iBAN) {
			IBAN = iBAN;
		}

		public long getBesitzer() {
			return besitzer;
		}

		public void setBesitzer(long besitzer) {
			this.besitzer = besitzer;
		}

		public String getKontoArt() {
			return kontoArt;
		}

		public void setKontoArt(String kontoArt) {
			this.kontoArt = kontoArt;
		}

		public double getKontoStand() {
			return kontoStand;
		}

		public void setKontoStand(double kontoStand) {
			this.kontoStand = kontoStand;
		}
		
}
