package com.aurionpro.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.entity.Customers;
import com.aurionpro.entity.Transactions;

public class BankDBUtil {

	private Statement statement;
	private Connection connection;
	private PreparedStatement preparedStatement;
	private int customerId;

	public void connectToDB() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "root");
			statement = connection.createStatement();
			System.out.println("Connection successful!");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean validateAdmin(String username, String password) {
		try {
			String query = "select * from admins where email = ? and password = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, username);
			preparedStatement.setString(2, password);

			ResultSet resultSet = preparedStatement.executeQuery();
			return resultSet.next(); // If a result exists, credentials are valid
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean validateCustomers(String email, String password) {
		try {
			String query = "select * from customers where email = ? and password = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, email);
			preparedStatement.setString(2, password);

			ResultSet resultSet = preparedStatement.executeQuery();
			return resultSet.next();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public void addCustomer(String firstName, String lastName, String email, String password) {
		try {
			String query = "insert into customers (first_name, last_name, email, password) values (?, ?, ?, ?)";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, firstName);
			preparedStatement.setString(2, lastName);
			preparedStatement.setString(3, email);
			preparedStatement.setString(4, password);

			preparedStatement.executeUpdate();
			System.out.println("Customer added successfully!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void addBankAccount(int customerId, String accountNumber, double initialBalance) {
		try {
			String query = "insert into accounts  (customer_id, account_number, balance) values (?, ?, ?)";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, customerId);
			preparedStatement.setString(2, accountNumber);
			preparedStatement.setDouble(3, initialBalance);

			preparedStatement.executeUpdate();
			System.out.println("Bank account added successfully!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Transactions> printPassbook(String accountNumber) {
		List<Transactions> transactionsList = new ArrayList<>();
		String sql = "SELECT * FROM transactions WHERE transaction_made_by = ? ORDER BY transaction_date DESC;";

		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, accountNumber);

			ResultSet resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				int transactionId = resultSet.getInt("transaction_id");
				String senderAccount = resultSet.getString("sender_account_number");
				String receiverAccount = resultSet.getString("receiver_account_number");
				String transactionType = resultSet.getString("transaction_type");
				double amount = resultSet.getDouble("amount");
				String transactionDate = resultSet.getString("transaction_date");
				double balance = resultSet.getDouble("balance");

				Transactions transaction = new Transactions(transactionId, senderAccount, receiverAccount,
						transactionType, amount, transactionDate, balance);
				transactionsList.add(transaction);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return transactionsList;
	}

	private double getInitialBalance(String accountNumber) {
		String balanceQuery = "SELECT balance FROM accounts WHERE account_number = ?";
		double balance = 0.0;
		try {
			preparedStatement = connection.prepareStatement(balanceQuery);
			preparedStatement.setString(1, accountNumber);
			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				balance = resultSet.getDouble("balance");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return balance;
	}

	public List<Customers> createAccount() {
		List<Customers> customersWithoutAccount = new ArrayList<>();

		try {

			String query = "SELECT c.customer_id, c.first_name, c.last_name, c.email, c.created_at,a.account_number,a.balance "
					+ "FROM customers c " + "LEFT JOIN accounts a ON c.customer_id = a.customer_id ";

			preparedStatement = connection.prepareStatement(query);
			ResultSet resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				int id = resultSet.getInt("customer_id");
				String firstName = resultSet.getString("first_name");
				String lastName = resultSet.getString("last_name");
				String email = resultSet.getString("email");
				String createdAt = resultSet.getString("created_at");
				String accountNumber = resultSet.getString("account_number");
				double balance = resultSet.getDouble("balance");

				customersWithoutAccount
						.add(new Customers(id, firstName, lastName, email, createdAt, accountNumber, balance));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return customersWithoutAccount;
	}

	public boolean isEmailPresent(String email) {
		boolean exists = false;
		try {
			String query = "SELECT COUNT(*) FROM customers WHERE email = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, email);
			ResultSet rs = preparedStatement.executeQuery();
			if (rs.next()) {
				exists = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return exists;
	}

	public int getCustomerID(String username, String password) {

		try {
			String sql = "SELECT customer_id FROM customers WHERE email = ? AND password = ?";

			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, username);
			preparedStatement.setString(2, password);

			ResultSet resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				// Retrieve customer ID from the result set
				customerId = resultSet.getInt("customer_id");
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Handle exceptions properly in your production code
		}

		return customerId;
	}

	public List<Customers> getCustomerDetails(int customerId) {
		List<Customers> customers = new ArrayList<>();

		String query = "SELECT c.customer_id, c.first_name, c.last_name, c.email, c.created_at, a.account_number,a.balance "
				+ "FROM customers c " + "LEFT JOIN accounts a ON c.customer_id = a.customer_id "
				+ "WHERE c.customer_id = ?";

		try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			preparedStatement.setInt(1, customerId);

			try (ResultSet resultSet = preparedStatement.executeQuery()) {
				while (resultSet.next()) {
					int id = resultSet.getInt("customer_id");
					String firstName = resultSet.getString("first_name");
					String lastName = resultSet.getString("last_name");
					String email = resultSet.getString("email");
					String createdAt = resultSet.getString("created_at");
					String accountNumber = resultSet.getString("account_number");
					double balance = resultSet.getDouble("balance");

					Customers customer = new Customers(id, firstName, lastName, email, createdAt, accountNumber,
							balance);

					customers.add(customer);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Handle exceptions properly in your production code
		}

		return customers;
	}

	public List<Customers> viewCustomer() {
		List<Customers> customers = new ArrayList<>();

		try {
			String query = "select c.customer_id, c.first_name, c.last_name, c.email, c.created_at, a.account_number, a.balance from customers c "
					+ "left join accounts a on c.customer_id = a.customer_id ";

			preparedStatement = connection.prepareStatement(query);

			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				int id = resultSet.getInt("customer_id");
				String firstName = resultSet.getString("first_name");
				String lastName = resultSet.getString("last_name");
				String email = resultSet.getString("email");
				String createdAt = resultSet.getString("created_at");
				String accountNumber = resultSet.getString("account_number");
				double balance = resultSet.getDouble("balance");

				System.out.println(id);

				customers.add(new Customers(id, firstName, lastName, email, createdAt, accountNumber, balance));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return customers;
	}

	public List<Transactions> viewTransactions() {
		List<Transactions> transactions = new ArrayList<>();
		double balance = 0;
		try {
			String query = "select * from transactions";
			ResultSet resultSet = statement.executeQuery(query);

			while (resultSet.next()) {
				int transactionID = resultSet.getInt("transaction_id");
				String senderAccNo = resultSet.getString("sender_account_number");
				String receiverAccNo = resultSet.getString("receiver_account_number");
				String transactionType = resultSet.getString("transaction_type");
				double amount = resultSet.getDouble("amount");
				String transactionDate = resultSet.getString("transaction_date");

				transactions.add(new Transactions(transactionID, senderAccNo, receiverAccNo, transactionType, amount,
						transactionDate, balance));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return transactions;
	}

	public void createTransaction(String senderAccount, String receiverAccount, double amount, String transactionType) {
		String selfQuery = "Insert into transactions (sender_account_number, receiver_account_number, transaction_type, amount, transaction_made_by, balance) values (?,?,?,?,?,?)";
		String debitQuery = "Insert into transactions (sender_account_number, receiver_account_number, transaction_type, amount, transaction_made_by, balance) values (?,?,?, ?,?,?)";
		String creditQuery = "Insert into transactions (sender_account_number, receiver_account_number, transaction_type, amount, transaction_made_by, balance) values (?,?,?, ?,?,?)";
		String updateQuery = "update accounts set balance=? where account_number=?";

		try {
			connection.setAutoCommit(false);

			if (receiverAccount.equals("SELF")) {
				double newBalance = getCurrentBalance(senderAccount)
						+ (transactionType.equals("credit") ? amount : -amount);

				// Insert self transaction
				preparedStatement = connection.prepareStatement(selfQuery);
				preparedStatement.setString(1, senderAccount);
				preparedStatement.setString(2, "SELF");
				preparedStatement.setString(3, transactionType);
				preparedStatement.setDouble(4, amount); // Set amount
				preparedStatement.setString(5, senderAccount);
				preparedStatement.setDouble(6, newBalance); // Set new balance
				preparedStatement.executeUpdate();

				// Update sender's balance
				preparedStatement = connection.prepareStatement(updateQuery);
				preparedStatement.setDouble(1, newBalance);
				preparedStatement.setString(2, senderAccount);
				preparedStatement.executeUpdate();

			} else {
				double newSenderBalance = getCurrentBalance(senderAccount) - amount;
				double newReceiverBalance = getCurrentBalance(receiverAccount) + amount;

				// Insert transaction for sender (debit)
				preparedStatement = connection.prepareStatement(debitQuery);
				preparedStatement.setString(1, senderAccount);
				preparedStatement.setString(2, receiverAccount);
				preparedStatement.setString(3, "debit");
				preparedStatement.setDouble(4, amount); // Set amount
				preparedStatement.setString(5, senderAccount);
				preparedStatement.setDouble(6, newSenderBalance); // Set new sender balance
				preparedStatement.executeUpdate();

				// Insert transaction for receiver (credit)
				preparedStatement = connection.prepareStatement(creditQuery);
				preparedStatement.setString(1, senderAccount);
				preparedStatement.setString(2, receiverAccount);
				preparedStatement.setString(3, "credit");
				preparedStatement.setDouble(4, amount); // Set amount
				preparedStatement.setString(5, receiverAccount);
				preparedStatement.setDouble(6, newReceiverBalance); // Set new receiver balance
				preparedStatement.executeUpdate();

				// Update sender's balance
				preparedStatement = connection.prepareStatement(updateQuery);
				preparedStatement.setDouble(1, newSenderBalance);
				preparedStatement.setString(2, senderAccount);
				preparedStatement.executeUpdate();

				// Update receiver's balance
				preparedStatement = connection.prepareStatement(updateQuery);
				preparedStatement.setDouble(1, newReceiverBalance);
				preparedStatement.setString(2, receiverAccount);
				preparedStatement.executeUpdate();
			}

			connection.commit();
		} catch (SQLException e) {
			try {
				connection.rollback(); 
			} catch (SQLException rollbackEx) {
				rollbackEx.printStackTrace(); 
			}
			e.printStackTrace(); 
		}
	}

	private double getCurrentBalance(String accountNumber) {
		String balanceQuery = "SELECT balance FROM accounts WHERE account_number = ?";
		double balance = 0.0;
		try (PreparedStatement preparedStatement = connection.prepareStatement(balanceQuery)) {
			preparedStatement.setString(1, accountNumber);
			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				balance = resultSet.getDouble("balance");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return balance;
	}

	public void closeConnection() {
		try {
			if (preparedStatement != null) {
				preparedStatement.close();
			}
			if (statement != null) {
				statement.close();
			}
			if (connection != null) {
				connection.close();
			}
			System.out.println("Connection closed.");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updateFirstName(int customerId, String firstName) {
		String sql = "UPDATE customers SET first_name = ? WHERE customer_id = ?";
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, firstName);
			preparedStatement.setInt(2, customerId);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updateLastName(int customerId, String lastName) {
		String sql = "UPDATE customers SET last_name = ? WHERE customer_id = ?";
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, lastName);
			preparedStatement.setInt(2, customerId);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean verifyPassword(int customerId, String oldPassword) {
		String sql = "SELECT password FROM customers WHERE customer_id = ?";
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, customerId);
			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				String storedPassword = resultSet.getString("password");
				return storedPassword.equals(oldPassword);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public void updatePassword(int customerId, String newPassword) {
		String sql = "UPDATE customers SET password = ? WHERE customer_id = ?";
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, newPassword);
			preparedStatement.setInt(2, customerId);
			preparedStatement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();

		}
	}
}
