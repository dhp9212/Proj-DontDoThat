package com.temp.app.model;

public class Card{
	private String kindOfCreditCard;
	private String numOfCreditCard;
	private String expirationDate;
	
	public Card(String kindOfCreditCard, String numOfCreditCard, String expirationDate) {
		setKindOfCreditCard(kindOfCreditCard);
		setNumOfCreditCard(numOfCreditCard);
		setExpirationDate(expirationDate);
	}

	public String getKindOfCreditCard() {
		return kindOfCreditCard;
	}
	public void setKindOfCreditCard(String kindOfCreditCard) {
		this.kindOfCreditCard = kindOfCreditCard;
	}
	public String getNumOfCreditCard() {
		return numOfCreditCard;
	}
	public void setNumOfCreditCard(String numOfCreditCard) {
		this.numOfCreditCard = numOfCreditCard;
	}
	public String getExpirationDate() {
		return expirationDate;
	}
	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}

}
