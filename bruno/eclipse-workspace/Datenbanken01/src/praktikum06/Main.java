package praktikum06;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;
import java.util.*;

/**
 *
 * @author Inge
 * Diese Klasse enthält Beispiele für alle wichtigen Statement-Interfaces 
 * der SQL-API auf der Datenbank flugdb der Vorlesung sowie Beispiele 
 * für Objekte vom Typ ResultSetMetaData
 * 
 * 2. Connection aufbauen (für Studenten auf dem fbi-postgreSQL-Server): 
 * mydatabase = st-Account
 * myuser     = st-Account 
 * mypassword = st-Account-Passwort (oder Zugang über Team-Account)
 * 
 */

public class Main {

    private Connection con;
    private Statement stmt;
    private String query;
    private PreparedStatement pStmt;
    private CallableStatement cStmt;
    private ResultSet rs;
    private int maxTicketId;
    private int maxJourneyId;
    

    public static void main(String args[]) throws SQLException {
    	Main m = new Main();
    	while(true) {
    		int amount = m.consoleUI();
    		long startTime = System.nanoTime();
    		
    		m.createTickets(amount);
    		
    		long endTime = System.nanoTime();
    		long timeElapsed = endTime - startTime;

    		System.out.println("Execution time in milliseconds : " + 
    								timeElapsed / 1000000);
    	}
    }
    
    private int consoleUI() {
    	int ticketCount = 0;
    	BufferedReader bin = new BufferedReader(
    		new InputStreamReader(System.in));
    	System.out.println("Bitte Anzahl eingeben: ");
    	try {
    		ticketCount = Integer.parseInt(bin.readLine());
    	} catch (Exception e) {
    		System.out.println("Fehlerhafte Eingabe! " + e.toString());
    	}
    	
    	return ticketCount;
    }

	private void createTickets(int ticketCount) throws SQLException {

        // Treiber-Klasse für postgresql-Driver laden und registrieren
        String driverClass =
                "org.postgresql.Driver";
        try {
            Class.forName(driverClass);
            System.out.println("Treiber-Klasse geladen");
        } catch (ClassNotFoundException exc) {
            System.out.println("c1: " + exc.getMessage());
            System.exit(1);
        }

        // Connection to database
        try {
        	String url = "jdbc:postgresql://localhost:5433/tokyo";
            con = DriverManager.getConnection(url, "postgres", "Obx5r5RkFgK6y5EeyCdt");
            System.out.println("Connected with database server");
            con.setAutoCommit(false);
            con.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
            con.commit();
        } catch (SQLException exc) {
            System.out.println("c2: " + exc.getMessage());
        }
        
        // Find höchste ticket & journey id aus

        try {
            stmt = con.createStatement();
            query = "Select max(ticketid) from ticketcard";

            // PILOT-Tabelle lesen
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                maxTicketId = rs.getInt(1);
                System.out.println("Höchste Ticket ID: " + maxTicketId);
            }
            rs.close();
            
            query = "Select max(journeyid) from journey";

            // PILOT-Tabelle lesen
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                maxJourneyId = rs.getInt(1);
                System.out.println("Höchste Journey ID: " + maxJourneyId);
            }
            rs.close();
            
        } catch (SQLException exc) {
            System.out.println("c3: " + exc.getMessage());
            throw new SQLException(exc);
        }
        
        // 4. PreparedStatement
        try {
        	for (int i = 0; i < ticketCount; i++) {
                pStmt = con.prepareStatement("insert into ticketcard values (?,?,?,?)");
                pStmt.setInt(1, ++maxTicketId);
                if(maxTicketId % 2 == 0) {
                	pStmt.setNull(2, Types.INTEGER);
                    pStmt.setString(4, "C");
                    pStmt.setInt(3, 500);
                } else {
                	pStmt.setInt(2, 5);
                    pStmt.setString(4, "T");
                    pStmt.setInt(3, 540);
                }
                pStmt.executeUpdate();
                
                // create journey
                pStmt = con.prepareStatement("insert into journey values (?,?,?,?,?,?,?,?)");
                pStmt.setInt(1, ++maxJourneyId);
                pStmt.setNull(2, Types.INTEGER);
                pStmt.setString(3, "Tokyo Metro");
                pStmt.setInt(4, maxTicketId);
                pStmt.setInt(5, 9);
                pStmt.setDate(6,  java.sql.Date.valueOf("2020-01-25"));
                pStmt.setBoolean(7, false);
                pStmt.setInt(8, 0);
                
                pStmt.executeUpdate();
                

                pStmt = con.prepareStatement("UPDATE journey SET endstationid = ? WHERE journeyid = ?");
                
                pStmt.setInt(1, 13);
                pStmt.setInt(2, maxJourneyId);
                
                pStmt.executeUpdate();
                
                // update journey
        	}
            con.commit();
            System.out.println("Inserts & Update gemacht");
        } catch (SQLException exc) {
            con.rollback();
            System.out.println("c4: " + exc.getMessage());
        }

        // 6. Connection schliessen
        try {
            con.close();
        } catch (SQLException exc) {
            System.out.println("close connection: " + exc.getMessage());
        }
	}
}

