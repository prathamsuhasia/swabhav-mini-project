package com.aurionpro.entity;

public class Transactions {
	private int transactionID;
	private String senderAccountNumber;
	private String recieverAccountNumber;
	private String transaction_type;
	private double amount;
	private String date;
	private double balance;
	
	public Transactions(int transactionID, String senderAccountNumber, String recieverAccountNumber,
			String transaction_type, double amount, String date, double balance ) {
		super();
		this.transactionID = transactionID;
		this.senderAccountNumber = senderAccountNumber;
		this.recieverAccountNumber = recieverAccountNumber;
		this.transaction_type = transaction_type;
		this.amount = amount;
		this.date = date;
		this.balance = balance;
	}
	
	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public int getTransactionID() {
		return transactionID;
	}
	public String getSenderAccountNumber() {
		return senderAccountNumber;
	}
	public String getRecieverAccountNumber() {
		return recieverAccountNumber;
	}
	public String getTransaction_type() {
		return transaction_type;
	}
	public double getAmount() {
		return amount;
	}
	public String getDate() {
		return date;
	}
	public void setTransactionID(int transactionID) {
		this.transactionID = transactionID;
	}
	public void setSenderAccountNumber(String senderAccountNumber) {
		this.senderAccountNumber = senderAccountNumber;
	}
	public void setRecieverAccountNumber(String recieverAccountNumber) {
		this.recieverAccountNumber = recieverAccountNumber;
	}
	public void setTransaction_type(String transaction_type) {
		this.transaction_type = transaction_type;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
}
