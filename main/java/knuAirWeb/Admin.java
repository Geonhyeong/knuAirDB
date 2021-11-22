package knuAirWeb;

import java.io.*;
import java.sql.*;
import java.util.Scanner;

public class Admin {
	Connection conn = null;
	Statement stmt = null;
	String id = null;
	Scanner sc = new Scanner(System.in);

	public Admin(Connection _conn, Statement _stmt, Identification _id) {
		conn = _conn;
		stmt = _stmt;
		id = _id.id;

		menu();
	}

	public void menu() {
		while (true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|                    Admin                    |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|        1. Manage        2. Analysis         |");
			System.out.println("|                                             |");
			System.out.println("|        3. My Page       4. DeleteAccount    |");
			System.out.println("|                                             |");
			System.out.println("|        5. Logout                            |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");

			switch (sc.nextLine()) {
			case "1":
				manage();
				break;
			case "2":
				analysis();
				break;
			case "3":
				myPage();
				break;
			case "4":
				deleteAccount();
				return;
			case "5":
				return;
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}

	public void manage() {
		
		System.out.println("+---------------------------------------------+");
		System.out.println("|                                             |");
		System.out.println("|               Admin - Manage                |");
		System.out.println("|                                             |");
		System.out.println("|                                             |");
		System.out.println("|       1. Airplane         2. Airline        |");
		System.out.println("|                                             |");
		System.out.println("|       3. Airport          4. Leg            |");
		System.out.println("|                                             |");
		System.out.println("|       5. Account          6. Back           |");
		System.out.println("|                                             |");
		System.out.println("+---------------------------------------------+");
		System.out.print(">> ");
		
		switch (sc.nextLine()) {
		case "1":
			manageAirplane();
			break;
		case "2":
			manageAirline();
			break;
		case "3":
			manageAirport();
			break;
		case "4":
			manageLeg();
			break;
		case "5":
			manageAccount();
			break;
		case "6":
			return;
		default:
			System.out.println("Wrong input!!");
			System.exit(1);
		}
	}
	
	public void manageAirplane() {
		
		String airplaneid = "";
		String airlineid = "";
		String type = "";
		String economy_seats = "";
		String business_seats = "";
		String first_seats = "";
		
		ResultSet rs;
		
		while(true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Manage - Airplane              |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|        1. Insert           2. Update        |");
			System.out.println("|                                             |");
			System.out.println("|        3. Delete           4. Lookup        |");
			System.out.println("|                                             |");
			System.out.println("|        5. Back                              |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			
			switch (sc.nextLine()) {
			case "1": // Insert 
				
				String sql = "select max(airplaneid) from airplane";
				
				try {
					rs = stmt.executeQuery(sql);
					if (rs.next()) {
						airplaneid = rs.getString(1);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("[ Insert?ï† Airplane ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
				int airplaneidNo = Integer.parseInt(airplaneid.substring(3,8)) + 1;
				airplaneid = "APL00"+ airplaneidNo + "";
				System.out.print("Airline ID: ");
				airlineid = sc.nextLine();
				System.out.print("Type: ");
				type = sc.nextLine();
				System.out.print("Number of Economy seats: ");
				economy_seats = sc.nextLine();
				System.out.print("Number of Business seats: ");
				business_seats = sc.nextLine();
				System.out.print("Number of First seats: ");
				first_seats = sc.nextLine();
				
				
				try {
					sql = "INSERT INTO AIRPLANE VALUES ('" + airplaneid + "','" + airlineid + "', '" + type + "', '" + economy_seats + "','" + business_seats + "','" + first_seats + "')";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					
					System.out.println("[?Ñ±Í≥µÏ†Å?úºÎ°? Insert ?êò?óà?äµ?ãà?ã§]");
					System.out.println("[ Insert ?†ïÎ≥? ]");
					System.out.println("| Airplane ID : " + airplaneid);
					System.out.println("| Airline ID : " + airlineid);
					System.out.println("| Type : " + type);
					System.out.println("| Number of Economy seats : " + economy_seats);
					System.out.println("| Number of Business seats : " + business_seats);
					System.out.println("| Number of First seats : " + first_seats);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				break;
				
			case "2": // Update
				
				String newAirplaneID = "";
				while(true) {
					System.out.println("[ Update?ï† AirplaneID ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
					System.out.print("Î≥?Í≤ΩÌï† Airplane ID : ");
					airplaneid = sc.nextLine();
					try {
						sql = "select airplaneid from airplane where airplaneid = '" + airplaneid + "'";
						rs = stmt.executeQuery(sql);
						while(rs.next()) {
							newAirplaneID = rs.getString(1);
						}
						if (newAirplaneID.equals(airplaneid)) {
							break;
						}
						else {
							System.out.println("[ ?ûÖ?†•?ïú AirplaneIDÍ∞? Ï°¥Ïû¨?ïòÏß? ?ïä?äµ?ãà?ã§. ]");
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
				while(true) {
					
					int outFlag = 0;
					
					System.out.println("+---------------------------------------------+");
					System.out.println("|                                             |");
					System.out.println("|              Update - Airplane              |");
					System.out.println("|                                             |");
					System.out.println("|                                             |");
					System.out.println("|      1. Airline ID        2. Type           |");
					System.out.println("|                                             |");
					System.out.println("|      3. Number of Economy Seats             |");
					System.out.println("|                                             |");
					System.out.println("|      4. Number of Business Seats            |");
					System.out.println("|                                             |");
					System.out.println("|      5. Number of First Seats               |");
					System.out.println("|                                             |");
					System.out.println("|      6. Back                                |");
					System.out.println("|                                             |");
					System.out.println("+---------------------------------------------+");
					System.out.print(">> ");
				
					switch(sc.nextLine()) {
					case "1":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Airline ID : ");
						String newAirlineid = sc.nextLine();
						sql = "UPDATE AIRPLANE SET airlineid = '" + newAirlineid + "' where airplaneid = '" + airplaneid + "'";
						break;
					case "2":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Type : ");
						String newType = sc.nextLine();
						sql = "UPDATE AIRPLANE SET type = '" + newType + "' where airplaneid = '" + airplaneid + "'";
						break;
					case "3":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Number of Economy Seats : ");
						String newEconomySeats = sc.nextLine();
						sql = "UPDATE AIRPLANE SET economy_seats = '" + newEconomySeats + "' where airplaneid = '" + airplaneid + "'";
						break;
					case "4":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Number of Business Seats : ");
						String newBusinessSeats = sc.nextLine();
						sql = "UPDATE AIRPLANE SET business_seats = '" + newBusinessSeats + "' where airplaneid = '" + airplaneid + "'";
						break;
					case "5":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Number of First Seats : ");
						String newFirstSeats = sc.nextLine();
						sql = "UPDATE AIRPLANE SET business_seats = '" + newFirstSeats + "' where airplaneid = '" + airplaneid + "'";
						break;
					case "6":
						outFlag = 1;
						break;
					default:
						System.out.println("Wrong input!!");
						System.exit(1);	
					}
					
					if(outFlag == 1) {
						break;
					}
					
					try {
						int result = stmt.executeUpdate(sql);
						conn.commit();
						System.out.println("[?Ñ±Í≥µÏ†Å?úºÎ°? Î≥?Í≤ΩÎêò?óà?äµ?ãà?ã§.]");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				break;
				
			case "3": // Delete
				System.out.println("[ Delete?ï† AirplaneID ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
				System.out.print("?Ç≠?†ú?ï† Airplane ID : ");
				airplaneid = sc.nextLine();
				try {
					sql = "delete from airplane where airplaneid = '" + airplaneid + "'";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					System.out.println("[ ?Ç≠?†ú?êò?óà?äµ?ãà?ã§. ]");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
				
			case "4": // lookup
				try {
					System.out.println("<<<<<<<<<< Airlines Name List >>>>>>>>>>");
					sql = "SELECT Name FROM Airline";
					rs = stmt.executeQuery(sql);
					int count = 0;

					while (rs.next()) {
						String al_name = rs.getString(1);
						System.out.print("| " + al_name + " ");
						count++;
						if (count % 7 == 0)
							System.out.println("|");
					}
					System.out.println();
					System.out.print("Please input Airline Name [referencing above list] : ");
					String al_name = sc.nextLine();
					sql = " SELECT AP.AIRLINEID, AVG((AP.ECONOMY_SEATS + AP.BUSINESS_SEATS + AP.FIRST_SEATS)) as AVG_SEATSCOUNT "
							+ "FROM AIRPLANE AP, AIRLINE AL " + "WHERE AL.NAME = '" + al_name
							+ "' AND AL.AIRLINEID = AP.AIRLINEID GROUP BY AP.AIRLINEID";

					rs = stmt.executeQuery(sql);

					System.out.println("AirlineID | Avg_seats_count");
					System.out.println("---------------------------");

					while (rs.next()) {
						String al_id = rs.getString(1);
						int avg_seats_count = rs.getInt(2);
						System.out.println(al_id + "  |  " + avg_seats_count);
					}
					rs.close();
					System.out.println();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
				
			case "5": // Back
				return;
				
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
		
	}

	public void manageAirline() {
		
		String airlineid = "";
		String name = "";
		String diff_seat = "";
		String diff_beggage = "";
		
		ResultSet rs;
		
		while(true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Manage - Airline               |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|        1. Insert          2. Update         |");
			System.out.println("|                                             |");
			System.out.println("|        3. Delete          4. Lookup         |");
			System.out.println("|                                             |");
			System.out.println("|        5. Back                              |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			
			switch (sc.nextLine()) {
			case "1": // Insert 
				
				String sql = "select max(airlineid) from airline";
				
				try {
					rs = stmt.executeQuery(sql);
					if (rs.next()) {
						airlineid = rs.getString(1);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("[ Insert?ï† Airline ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
				int airplaneidNo = Integer.parseInt(airlineid.substring(2,6)) + 1;
				airlineid = "AL0"+ airplaneidNo + "";
				System.out.print("Name: ");
				name = sc.nextLine();
				System.out.print("Price ratio difference of seat: ");
				diff_seat = sc.nextLine();
				System.out.print("Price ratio difference of beggage: ");
				diff_beggage = sc.nextLine();
					
				try {
					sql = "INSERT INTO AIRLINE VALUES ('" + airlineid + "','" + name + "', '" + diff_seat + "', '" + diff_beggage + "')";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					
					System.out.println("[?Ñ±Í≥µÏ†Å?úºÎ°? Insert ?êò?óà?äµ?ãà?ã§]");
					System.out.println("[ Insert ?†ïÎ≥? ]");
					System.out.println("| Airline ID : " + airlineid);
					System.out.println("| Name : " + name);
					System.out.println("| Price ratio difference of seat : " + diff_seat);
					System.out.println("| Price ratio difference of beggage : " + diff_beggage);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				break;
				
			case "2": // Update
				
				String newAirlineID = "";
				while(true) {
					System.out.println("[ Update?ï† AirlineID ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
					System.out.print("Î≥?Í≤ΩÌï† Airline ID : ");
					airlineid = sc.nextLine();
					try {
						sql = "select airlineid from airline where airlineid = '" + airlineid + "'";
						rs = stmt.executeQuery(sql);
						while(rs.next()) {
							newAirlineID = rs.getString(1);
						}
						if (newAirlineID.equals(airlineid)) {
							break;
						}
						else {
							System.out.println("[ ?ûÖ?†•?ïú AirlineIDÍ∞? Ï°¥Ïû¨?ïòÏß? ?ïä?äµ?ãà?ã§. ]");
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
				while(true) {
					
					int outFlag = 0;
					
					System.out.println("+---------------------------------------------+");
					System.out.println("|                                             |");
					System.out.println("|              Update - Airline               |");
					System.out.println("|                                             |");
					System.out.println("|                                             |");
					System.out.println("|  1. Name                                    |");
					System.out.println("|                                             |");
					System.out.println("|  2. Price ratio difference of seat          |");
					System.out.println("|                                             |");
					System.out.println("|  3. Price ratio difference of beggage       |");
					System.out.println("|                                             |");
					System.out.println("|  4. Back                                    |");
					System.out.println("|                                             |");
					System.out.println("+---------------------------------------------+");
					System.out.print(">> ");
				
					switch(sc.nextLine()) {
					case "1":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Name : ");
						String newName = sc.nextLine();
						sql = "UPDATE AIRLINE SET airlineid = '" + newName + "' where airlineid = '" + airlineid + "'";
						break;
					case "2":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Price ratio difference of seat : ");
						String newDiff_Seat = sc.nextLine();
						sql = "UPDATE AIRLINE SET diff_seat = '" + newDiff_Seat + "' where airlineid = '" + airlineid + "'";
						break;
					case "3":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Price ratio difference of beggage : ");
						String newDiff_Beggage = sc.nextLine();
						sql = "UPDATE AIRLINE SET diff_beggage = '" + newDiff_Beggage + "' where airlineid = '" + airlineid + "'";
						break;						
					case "4":
						outFlag = 1;
						break;
					default:
						System.out.println("Wrong input!!");
						System.exit(1);	
					}
					
					if(outFlag == 1) {
						break;
					}
					
					try {
						int result = stmt.executeUpdate(sql);
						conn.commit();
						System.out.println("[?Ñ±Í≥µÏ†Å?úºÎ°? Î≥?Í≤ΩÎêò?óà?äµ?ãà?ã§.]");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				break;
				
			case "3": // Delete
				try {
					System.out.println("[ Delete?ï† AirlineID ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
					System.out.print("?Ç≠?†ú?ï† Airline ID : ");
					airlineid = sc.nextLine();
					
					sql = "delete from airline where airlineid = '" + airlineid + "'";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					System.out.println("[ ?Ç≠?†ú?êò?óà?äµ?ãà?ã§. ]");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			case "4":
				lookupAirline();
				break;
				
			case "5": // Back
				return;
				
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}

	public void lookupAirline() {
		while (true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Lookup - Airline               |");
			System.out.println("|                                             |");
			System.out.println("|       1. Í≥µÌï≠ IDÎ°? Í≤??Éâ?ïòÍ∏?                     |");
			System.out.println("|                                             |");
			System.out.println("|       2. Back                               |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			
			switch (sc.nextLine()) {
			case "1":
				try {
					String sql = "select airportid from airport";
					ResultSet rs = stmt.executeQuery(sql);
					int count = 0;

					System.out.println("<<<<<< AirportID List >>>>>>");
					while (rs.next()) {
						String airport_id = rs.getString(1);
						System.out.print("| " + airport_id + " ");
						count++;
						if (count % 10 == 0)
							System.out.println("|");
					}

					System.out.print("Please input airport_id [referencing above list] : ");
					String airport_id = sc.nextLine();

					sql = "SELECT AL.Name " + "FROM AIRLINE AL "
							+ "WHERE EXISTS( SELECT * FROM LEG L, ASSIGNED_BY AB, AIRPLANE AP " + "WHERE  (L.Dep_airportID = '"
							+ airport_id + "' OR L.Arr_airportID = '" + airport_id + "' ) "
							+ "AND L.LegID = AB.LegID  AND AB.AirplaneID = AP.AirplaneID AND AP.AirlineID = AL.AirlineID )";
					rs = stmt.executeQuery(sql);
					count = 0;

					System.out.println("<< query 9 result >>");
					System.out.println("Airline Name");
					System.out.println("------------");

					while (rs.next()) {
						String airline_name = rs.getString(1);
						System.out.println(airline_name);
						count++;
					}
					rs.close();
					System.out.println();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			case "2":
				return;
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}
	
	public void manageAirport() {
		
		String airportid = "";
		String name = "";
		String city = "";
		String total_gates = "";
		
		ResultSet rs;
		String sql;
		
		while(true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Manage - Airport               |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|        1. Insert          2. Update         |");
			System.out.println("|                                             |");
			System.out.println("|        3. Delete          4. Back           |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			
			switch (sc.nextLine()) {
			case "1": // Insert 
				
				
				System.out.println("[ Insert?ï† Airport ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
				System.out.print("Airport ID: ");
				airportid = sc.nextLine();
				System.out.print("Name: ");
				name = sc.nextLine();
				System.out.print("City: ");
				city = sc.nextLine();
				System.out.print("Total number of gates: ");
				total_gates = sc.nextLine();
				
				
				
				try {
					sql = "INSERT INTO AIRPORT VALUES ('" + airportid + "','" + name + "', '" + city + "', '" + total_gates + "')";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					
					System.out.println("[?Ñ±Í≥µÏ†Å?úºÎ°? Insert ?êò?óà?äµ?ãà?ã§]");
					System.out.println("[ Insert ?†ïÎ≥? ]");
					System.out.println("| Airport ID : " + airportid);
					System.out.println("| Name : " + name);
					System.out.println("| City : " + city);
					System.out.println("| Total number of gates : " + total_gates);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				break;
				
			case "2": // Update
				
				String newAirportID = "";
				while(true) {
					System.out.println("[ Update?ï† AirportID ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
					System.out.print("Î≥?Í≤ΩÌï† Airport ID : ");
					airportid = sc.nextLine();
					try {
						sql = "select airportid from airport where airportid = '" + airportid + "'";
						rs = stmt.executeQuery(sql);
						while(rs.next()) {
							newAirportID = rs.getString(1);
						}
						if (newAirportID.equals(airportid)) {
							break;
						}
						else {
							System.out.println("[ ?ûÖ?†•?ïú AirportIDÍ∞? Ï°¥Ïû¨?ïòÏß? ?ïä?äµ?ãà?ã§. ]");
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
				while(true) {
					
					int outFlag = 0;
					
					System.out.println("+---------------------------------------------+");
					System.out.println("|                                             |");
					System.out.println("|              Update - Airport               |");
					System.out.println("|                                             |");
					System.out.println("|                                             |");
					System.out.println("|          1. Name            2. City         |");
					System.out.println("|                                             |");
					System.out.println("|          3. Number of total gates           |");
					System.out.println("|                                             |");
					System.out.println("|          4. Back                            |");
					System.out.println("|                                             |");
					System.out.println("+---------------------------------------------+");
					System.out.print(">> ");
				
					switch(sc.nextLine()) {
					case "1":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Name : ");
						String newName = sc.nextLine();
						sql = "UPDATE AIRPORT SET airportid = '" + newName + "' where airportid = '" + airportid + "'";
						break;
					case "2":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ City : ");
						String newCity = sc.nextLine();
						sql = "UPDATE AIRPORT SET city = '" + newCity + "' where airportid = '" + airportid + "'";
						break;
					case "3":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Number of total gates : ");
						String newTotal_Gates = sc.nextLine();
						sql = "UPDATE AIRPORT SET total_gates = '" + newTotal_Gates + "' where airportid = '" + airportid + "'";
						break;
					
					case "4":
						outFlag = 1;
						break;
					default:
						System.out.println("Wrong input!!");
						System.exit(1);	
					}
					
					if(outFlag == 1) {
						break;
					}
					
					try {
						int result = stmt.executeUpdate(sql);
						conn.commit();
						System.out.println("[?Ñ±Í≥µÏ†Å?úºÎ°? Î≥?Í≤ΩÎêò?óà?äµ?ãà?ã§.]");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				break;
				
			case "3": // Delete
				try {
					System.out.println("[ Delete?ï† AirportID ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
					System.out.print("?Ç≠?†ú?ï† Airport ID : ");
					airportid = sc.nextLine();

					sql = "delete from airport where airportid = '" + airportid + "'";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					System.out.println("[ ?Ç≠?†ú?êò?óà?äµ?ãà?ã§. ]");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
				
			case "4": // Back
				return;
				
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}
	
	public void manageLeg() {
		
		String legid = "";
		String dep_airportid = "";
		String arr_airportid = "";
		String dep_gate = "";
		String sched_dep_time = "";
		String sched_arr_time = "";
		String adminno = "";
		String price = "";
		
		ResultSet rs;
		
		while(true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Manage - Leg                   |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|        1. Insert          2. Update         |");
			System.out.println("|                                             |");
			System.out.println("|        3. Delete          4. Lookup         |");
			System.out.println("|                                             |");
			System.out.println("|        5. Back                              |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			
			switch (sc.nextLine()) {
			case "1": // Insert 
				
				String sql = "select max(legid) from leg";
				
				try {
					rs = stmt.executeQuery(sql);
					if (rs.next()) {
						legid = rs.getString(1);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("[ Insert?ï† Leg ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
				int legidNo = Integer.parseInt(legid.substring(3,8)) + 1;
				legid = "LEG00"+ legidNo + "";
				System.out.print("Depart Airport ID: ");
				dep_airportid = sc.nextLine();
				System.out.print("Arrive Airport ID: ");
				arr_airportid = sc.nextLine();
				System.out.print("Departure Gate: ");
				dep_gate = sc.nextLine();
				System.out.print("Scheduled departure time(yyyymmdd hhmmss): ");
				sched_dep_time = sc.nextLine();
				System.out.print("Scheduled arrival time(yyyymmdd hhmmss): ");
				sched_arr_time = sc.nextLine();
				System.out.print("AdminNo: ");
				adminno = sc.nextLine();
				System.out.print("Price: ");
				price = sc.nextLine();
				
				
				try {
					sql = "INSERT INTO LEG VALUES ('" + legid + "','" + dep_airportid + "', '" + arr_airportid + "', '" + dep_gate + "',TO_DATE('" + sched_dep_time + "', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('" + sched_arr_time + "', 'YYYY-MM-DD HH24:MI:SS'),'" + adminno + "','" + price + "')";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					
					System.out.println("[?Ñ±Í≥µÏ†Å?úºÎ°? Insert ?êò?óà?äµ?ãà?ã§]");
					System.out.println("[ Insert ?†ïÎ≥? ]");
					System.out.println("| Leg ID : " + legid);
					System.out.println("| Depart Airport ID : " + dep_airportid);
					System.out.println("| Arrive Airport ID : " + arr_airportid);
					System.out.println("| Departure Gate : " + dep_gate);
					System.out.println("| Scheduled departure time(yyyymmdd hhmmss) : " + sched_dep_time);
					System.out.println("| Scheduled arrival time(yyyymmdd hhmmss) : " + sched_arr_time);
					System.out.println("| AdminNo : " + adminno);
					System.out.println("| Price : " + price);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				break;
				
			case "2": // Update
				
				String newLegID = "";
				while(true) {
					System.out.println("[ Update?ï† LegID ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
					System.out.print("Î≥?Í≤ΩÌï† Leg ID : ");
					legid = sc.nextLine();
					try {
						sql = "select legid from leg where legid = '" + legid + "'";
						rs = stmt.executeQuery(sql);
						while(rs.next()) {
							newLegID = rs.getString(1);
						}
						if (newLegID.equals(legid)) {
							break;
						}
						else {
							System.out.println("[ ?ûÖ?†•?ïú LegIDÍ∞? Ï°¥Ïû¨?ïòÏß? ?ïä?äµ?ãà?ã§. ]");
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
				while(true) {
					
					int outFlag = 0;
					
					System.out.println("+---------------------------------------------+");
					System.out.println("|                                             |");
					System.out.println("|              Update - Leg                   |");
					System.out.println("|                                             |");
					System.out.println("|                                             |");
					System.out.println("|  1. Depart AirportID  2. Arrive AirportID   |");
					System.out.println("|                                             |");
					System.out.println("|  3. Departure gate                          |");
					System.out.println("|                                             |");
					System.out.println("|  4. Scheduled departure time                |");
					System.out.println("|                                             |");
					System.out.println("|  5. Scheduled arrival time                  |");
					System.out.println("|                                             |");
					System.out.println("|  6. AdminNo           7. Price              |");
					System.out.println("|                                             |");
					System.out.println("|  8. Back                                    |");
					System.out.println("|                                             |");
					System.out.println("+---------------------------------------------+");
					System.out.print(">> ");
				
					switch(sc.nextLine()) {
					case "1":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Depart Airport ID : ");
						String newDepAirportID = sc.nextLine();
						sql = "UPDATE LEG SET dep_airportid = '" + newDepAirportID + "' where legid = '" + legid + "'";
						break;
					case "2":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Arrive AirportID : ");
						String newArrAirportID = sc.nextLine();
						sql = "UPDATE LEG SET arr_airportid = '" + newArrAirportID + "' where legid = '" + legid + "'";
						break;
					case "3":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Departure gate : ");
						String newDepGate = sc.nextLine();
						sql = "UPDATE LEG SET dep_gate = '" + newDepGate + "' where legid = '" + legid + "'";
						break;
					case "4":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Scheduled departure time : ");
						String newSchedDepTime = sc.nextLine();
						sql = "UPDATE LEG SET sched_dep_time = '" + newSchedDepTime + "' where legid = '" + legid + "'";
						break;
					case "5":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Scheduled arrival time : ");
						String newSchedArrTime = sc.nextLine();
						sql = "UPDATE LEG SET sched_arr_time = '" + newSchedArrTime + "' where legid = '" + legid + "'";
						break;
					case "6":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ AdminNo : ");
						String newAdminNo = sc.nextLine();
						sql = "UPDATE LEG SET adminno = '" + newAdminNo + "' where legid = '" + legid + "'";
						break;
					case "7":
						System.out.print("Î≥?Í≤ΩÌï† ?ÉàÎ°úÏö¥ Price : ");
						String newPrice = sc.nextLine();
						sql = "UPDATE LEG SET price = '" + newPrice + "' where legid = '" + legid + "'";
						break;
					case "8":
						outFlag = 1;
						break;
					default:
						System.out.println("Wrong input!!");
						System.exit(1);	
					}
					
					if(outFlag == 1) {
						break;
					}
					
					try {
						int result = stmt.executeUpdate(sql);
						conn.commit();
						System.out.println("[?Ñ±Í≥µÏ†Å?úºÎ°? Î≥?Í≤ΩÎêò?óà?äµ?ãà?ã§.]");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				break;
				
			case "3": // Delete
				try {
					System.out.println("[ Delete?ï† LegID ?†ïÎ≥¥Î?? ?ûÖ?†•?ïò?ãú?ò§ ]");
					System.out.print("?Ç≠?†ú?ï† Leg ID : ");
					legid = sc.nextLine();
					
					sql = "delete from leg where legid = '" + legid + "'";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					System.out.println("[ ?Ç≠?†ú?êò?óà?äµ?ãà?ã§. ]");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			
			case "4":
				lookupLeg();
				break;
			
			case "5": // Back
				return;
				
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}
	
	public void lookupLeg()
	{
		while (true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Lookup - Leg                   |");
			System.out.println("|                                             |");
			System.out.println("|       1. Ï∂úÎ∞ú Í≥µÌï≠?úºÎ°? Í≤??Éâ?ïòÍ∏?                   |");
			System.out.println("|                                             |");
			System.out.println("|       2. ÎπÑÌñâÍ∏? ???ûÖ?úºÎ°? Í≤??Éâ?ïòÍ∏?                 |");
			System.out.println("|                                             |");
			System.out.println("|       3. Í∞?Í≤©ÏúºÎ°? Í≤??Éâ?ïòÍ∏?                      |");
			System.out.println("|                                             |");
			System.out.println("|       4. Back                               |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			
			switch (sc.nextLine()) {
			case "1":
				try {
					System.out.println("<<<<<< City List >>>>>>");
					String sql = "SELECT Distinct city from airport";
					ResultSet rs = stmt.executeQuery(sql);
					int count = 0;

					while (rs.next()) {
						String city = rs.getString(1);
						System.out.print("| " + city + " ");
						count++;
						if (count % 10 == 0)
							System.out.println("|");
					}

					System.out.println();
					System.out.print("Please input City Name [referencing above list] : ");
					String city = sc.nextLine();

					sql = "SELECT LEGID, DEP_AIRPORTID, ARR_AIRPORTID, DEP_GATE, SCHEDULED_DEP_TIME, SCHEDULED_ARR_TIME, PRICE "
							+ "FROM LEG " + "WHERE DEP_AIRPORTID IN (SELECT AIRPORTID FROM AIRPORT WHERE CITY ='" + city + "')";
					rs = stmt.executeQuery(sql);

					System.out.println("Leg_id | Dep_airport_id | Arr_airport_id | Dep_gate | Dep_time | Arr_time | Price");
					System.out.println("---------------------------------------------------------------------------------");

					while (rs.next()) {
						String leg_id = rs.getString(1);
						String dep_airport_id = rs.getString(2);
						String arr_airport_id = rs.getString(3);
						int dep_gate = rs.getInt(4);
						Date dep_time = rs.getDate(5);
						Date arr_time = rs.getDate(6);
						int price = rs.getInt(7);

						System.out.println(leg_id + "  |  " + dep_airport_id + "  |  " + arr_airport_id + "  |  " + dep_gate
								+ "  |  " + dep_time + "  |  " + arr_time + "  |  " + price);
					}
					rs.close();
					System.out.println();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			case "2":
				try {
					String sql = "Select type from airplane";
					ResultSet rs = stmt.executeQuery(sql);
					int count = 0;

					while (rs.next()) {
						String type = rs.getString(1);
						System.out.print("| " + type + " ");
						count++;
						if (count % 6 == 0)
							System.out.println("|");
					}
					System.out.println();
					System.out.print("Please input Airplane Type(name) [referencing above list] : ");
					String type = sc.nextLine();
					sql = "SELECT DEP_AIRPORTID, ARR_AIRPORTID, DEP_GATE, SCHEDULED_DEP_TIME, SCHEDULED_ARR_TIME, PRICE "
							+ "			      FROM LEG L, ASSIGNED_BY A WHERE L.LEGID = A.LEGID AND A.AIRPLANEID IN "
							+ "			      (SELECT AIRPLANEID FROM AIRPLANE WHERE TYPE = '" + type + "')";
					rs = stmt.executeQuery(sql);

					System.out.println("Dep_airport_id | Arr_airport_id | Dep_gate | Dep_time | Arr_time | price");
					System.out.println("------------------------------------------------------------------------");

					while (rs.next()) {
						String dep_airport_id = rs.getString(1);
						String arr_airport_id = rs.getString(2);
						int dep_gate = rs.getInt(3);
						Date dep_time = rs.getDate(4);
						Date arr_time = rs.getDate(5);
						int price = rs.getInt(6);

						System.out.println(dep_airport_id + "  |  " + arr_airport_id + "  |  " + dep_gate + "  |  " + dep_time
								+ "  |  " + arr_time + "  |  " + price);
					}
					rs.close();
					System.out.println();

				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			case "3":
				try {
					System.out.print("Please input Leg Price [Type 'INT'] >= ");
					int price = sc.nextInt();
					sc.nextLine();
					String sql = "SELECT DEP_AIRPORT, ARR_AIRPORT, DEP_DATE, ARR_DATE FROM ( SELECT DEP_AIRPORTID AS DEP_AIRPORT, ARR_AIRPORTID AS ARR_AIRPORT, SCHEDULED_DEP_TIME AS DEP_DATE, SCHEDULED_ARR_TIME AS ARR_DATE FROM LEG WHERE PRICE >="
							+ price + ")";
					ResultSet rs = stmt.executeQuery(sql);
					
					System.out.println("Dep_airport_id | Arr_airport_id | Dep_date | Arr_date");
					System.out.println("-----------------------------------------------------");

					while (rs.next()) {
						String dep_airport_id = rs.getString(1);
						String arr_airport_id = rs.getString(2);
						Date dep_date = rs.getDate(3);
						Date arr_date = rs.getDate(4);

						System.out.println(dep_airport_id + " | " + arr_airport_id + " | " + dep_date + " | " + arr_date);
					}
					rs.close();
					System.out.println();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			case "4":
				return;
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}
	
	public void manageAccount() {
		while (true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Manage - Account               |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|       1. Lookup                             |");
			System.out.println("|                                             |");
			System.out.println("|       2. Back                               |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			
			switch (sc.nextLine()) {
			case "1":
				lookupAccount();
				break;
			case "2":
				return;
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}
	
	public void lookupAccount() {
		while (true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Lookup - Account               |");
			System.out.println("|                                             |");
			System.out.println("|       1. ???ûÖ?úºÎ°? Í≤??Éâ                         |");
			System.out.println("|                                             |");
			System.out.println("|       2. Î©§Î≤Ñ?ã≠?úºÎ°? Í≤??Éâ                        |");
			System.out.println("|                                             |");
			System.out.println("|       3. Back                               |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			
			switch (sc.nextLine()) {
			case "1":
				try {
					System.out.print("Please input Account Type >> ['Admin'/'Passenger'] : ");
					String type = sc.nextLine();
					String sql = "SELECT Fname, Lname FROM Account Where Type = '" + type + "'";
					ResultSet rs = stmt.executeQuery(sql);

					System.out.println("Fname\t|\tLname");
					System.out.println("-------------");

					while (rs.next()) {
						String fname = rs.getString(1);
						String lname = rs.getString(2);
						System.out.println(fname + "\t|\t" + lname);
					}
					rs.close();
					System.out.println();

				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			case "2":
				lookupAccountMembership();
				break;
			case "3":
				return;
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}
	
	public void lookupAccountMembership() {
		while (true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Lookup - Membership            |");
			System.out.println("|                                             |");
			System.out.println("|       1. ?Ñ±Î≥ÑÎ°ú ?Ñ∏Î∂? Í≤??Éâ?ïòÍ∏?                    |");
			System.out.println("|                                             |");
			System.out.println("|       2. ?òà?ïΩ?ïú ?Ç¨?ûå?ì§Îß? Í≤??Éâ?ïòÍ∏?                 |");
			System.out.println("|                                             |");
			System.out.println("|       3. Í∑∏ÎÉ• Í≤??Éâ?ïòÍ∏?                         |");
			System.out.println("|                                             |");
			System.out.println("|       4. Î©§Î≤Ñ?ã≠ Î≥? ?Ç¨?ûå ?àò?? ?èâÍ∑? ?ó¨?ñâ?öü?àò Ï∂úÎ†•      |");
			System.out.println("|                                             |");
			System.out.println("|       5. Back                               |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			
			switch (sc.nextLine()) {
			case "1":
				try {
					System.out.print("Please input Membership Title ['Rubi'/'Diamond'/'Gold'/'Silver'] : ");
					String title = sc.nextLine();
					System.out.print("Please input Sex ['M'/'F'] : ");
					String in_sex = sc.nextLine();
					String sql = "SELECT A.FName, A.LName, A.Sex " + "FROM ACCOUNT A "
							+ "WHERE EXISTS( SELECT * FROM MEMBERSHIP M WHERE  M.Title = '" + title
							+ "' AND M.AccountNo = A.AccountNo ) AND A.Sex = '" + in_sex + "'";
					ResultSet rs = stmt.executeQuery(sql);

					System.out.println("Fname\t| Lname\t| Sex");
					System.out.println("-------------------");

					while (rs.next()) {
						String fname = rs.getString(1);
						String lname = rs.getString(2);
						String sex = rs.getString(3);
						System.out.println(fname + "\t| " + lname + "\t| " + sex);
					}
					rs.close();
					System.out.println();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			case "2":
				try {
					System.out.print("Please input Membership ['Rubi'/'Diamond'/'Gold'/'Silver'] : ");
					String title = sc.nextLine();
					String sql = "SELECT ACCOUNTID, FNAME, LNAME, AGE, PHONE, SEX " + "FROM ACCOUNT A, MEMBERSHIP M "
							+ "WHERE A.ACCOUNTNO = M.ACCOUNTNO AND TITLE = '" + title + "'  INTERSECT "
							+ "SELECT ACCOUNTID, FNAME, LNAME, AGE, PHONE, SEX FROM ACCOUNT WHERE ACCOUNTNO IN (SELECT PASSENGERNO FROM ETICKET)";
					ResultSet rs = stmt.executeQuery(sql);

					System.out.println("AccountID | Fname | Lname | Age | Phone_number | Sex");
					System.out.println("----------------------------------------------------");

					while (rs.next()) {
						String account_id = rs.getString(1);
						String fname = rs.getString(2);
						String lname = rs.getString(3);
						int age = rs.getInt(4);
						String phone = rs.getString(5);
						String sex = rs.getString(6);
						System.out.println(
								account_id + " | " + fname + " | " + lname + " | " + age + " | " + phone + " | " + sex);
					}
					rs.close();
					System.out.println();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			case "3":
				try {
					System.out.print("Please input Membership Title ['Rubi'/'Diamond'/'Gold'/'Silver'] : ");
					String title = sc.nextLine();
					String sql = "SELECT FNAME, LNAME, PHONE FROM ACCOUNT "
							+ "WHERE ACCOUNTNO IN (SELECT ACCOUNTNO FROM MEMBERSHIP WHERE TITLE = '" + title + "')";
					ResultSet rs = stmt.executeQuery(sql);

					System.out.println("Fname | Lname | Phone_number");
					System.out.println("----------------------------");

					while (rs.next()) {
						String fname = rs.getString(1);
						String lname = rs.getString(2);
						String phone = rs.getString(3);
						System.out.println(fname + " | " + lname + " | " + phone);
					}
					rs.close();
					System.out.println();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			case "4":
				try {
					String sql = "SELECT M.Title, COUNT(*), AVG(Travel_count) "
							+ "FROM ((MEMBERSHIP M JOIN ACCOUNT A ON M.AccountNo=A.AccountNo) JOIN ETICKET E ON A.AccountNo=E.PassengerNo) GROUP BY M.Title";
					ResultSet rs = stmt.executeQuery(sql);

					System.out.println("Membership | Passenger_count | Avg_travel_count");
					System.out.println("-----------------------------------------------");

					while (rs.next()) {
						String m_title = rs.getString(1);
						int passenger_count = rs.getInt(2);
						float avg_travel_count = rs.getFloat(3);
						System.out.println(m_title + "  |  " + passenger_count + "  |  " + avg_travel_count);
					}
					rs.close();
					System.out.println();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
				
			case "5":
				return;
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}

	public void analysis()
	{
		ResultSet rs = null;
		System.out.println("+---------------------------------------------+");
		System.out.println("|                                             |");
		System.out.println("|               Admin - Analysis              |");
		System.out.println("|                                             |");
		System.out.println("|                                             |");
		System.out.println("|     1. ?ó¨?ñâ ?öü?àòÍ∞? ?èâÍ∑†Î≥¥?ã§ ?†Å?? Í≥ÑÏ†ï ?†ïÎ≥? Ï°∞Ìöå?ïòÍ∏?    |");
		System.out.println("|                                             |");
		System.out.println("|     2. ?òà?ïΩ?êú ?ã∞Ïº? ?òÑ?ô©?ùÑ ?èÑ?ãú ?ù¥Î¶ÑÏúºÎ°? Ï°∞Ìöå?ïòÍ∏?      |");
		System.out.println("|                                             |");
		System.out.println("|     3. ?äπ?†ï ?Ç†Ïß? ?ù¥?õÑ?óê Ï∂úÎ∞ú?ïò?äî Î™®Îì† ?Ç¨?ûå?ì§ Ï°∞Ìöå?ïòÍ∏?  |");
		System.out.println("|                                             |");
		System.out.println("|     4. NÍ∞? ?ù¥?ÉÅ ?òà?ïΩ?êú ?ï≠Í≥µÍ∂å ?†ïÎ≥? Ï°∞Ìöå?ïòÍ∏?          |");
		System.out.println("|                                             |");
		System.out.println("|     5. Back                                 |");
		System.out.println("|                                             |");
		System.out.println("+---------------------------------------------+");
		System.out.print(">> ");
		
		switch (sc.nextLine()) {
		case "1":
			try {
				String sql = "SELECT M.Title, A.FName, A.Lname FROM ACCOUNT A, MEMBERSHIP M, (SELECT M.Title AS title, AVG(M.Travel_count) AS trv "
						+ "FROM MEMBERSHIP M GROUP BY M.Title) Avg_Travel "
						+ "WHERE A.AccountNo = M.AccountNo AND M.Title = Avg_Travel.title AND M.Travel_count < Avg_Travel.trv";
				rs = stmt.executeQuery(sql);
				
				System.out.println("Membership | Fname | Lname");
				System.out.println("--------------------------");

				while (rs.next()) {
					String m_title = rs.getString(1);
					String fname = rs.getString(2);
					String lname = rs.getString(3);
					System.out.println(m_title + " | " + fname + " | " + lname);
				}
				rs.close();
				System.out.println();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		case "2":
			try {
				System.out.println("<<<<<< City List >>>>>>");
				String sql = "SELECT Distinct city from airport";
				rs = stmt.executeQuery(sql);
				int count = 0;

				while (rs.next()) {
					String city = rs.getString(1);
					System.out.print("| " + city + " ");
					count++;
					if (count % 10 == 0)
						System.out.println("|");
				}

				System.out.println();
				System.out.print("Please input Dep_city [referencing above list] : ");
				String dep_city = sc.nextLine();
				System.out.print("Please input Arr_city [referencing above list] : ");
				String arr_city = sc.nextLine();

				sql = "SELECT E_TICKETID, PASSENGERNO FROM ETICKET E, LEG L "
						+ "WHERE E.LEGID = L.LEGID AND DEP_AIRPORTID IN (SELECT AIRPORTID FROM AIRPORT WHERE CITY = '"
						+ dep_city + "') " + "AND ARR_AIRPORTID IN (SELECT AIRPORTID FROM AIRPORT WHERE CITY = '" + arr_city
						+ "') ORDER BY PASSENGERNO";
				rs = stmt.executeQuery(sql);

				System.out.println("Eticket_id | Passenger_no");
				System.out.println("-------------------------");

				while (rs.next()) {
					String eticket_id = rs.getString(1);
					int passenger_no = rs.getInt(2);
					System.out.println(eticket_id + " | " + passenger_no);
				}

				rs.close();
				System.out.println();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		case "3":
			try {
				System.out.print("Please input Dep Time [Format : 20211201 000000] : ");
				String dep_time = sc.nextLine();

				String sql = "WITH " + "DEP AS" + "(" + "    SELECT L.LEGID, L.DEP_AIRPORTID, L.ARR_AIRPORTID, AP.NAME "
						+ "    FROM LEG L, AIRPORT AP " + "    WHERE AP.AIRPORTID = L.DEP_AIRPORTID " + "), " + "ARR AS "
						+ "( " + "    SELECT L.LEGID, L.DEP_AIRPORTID, L.ARR_AIRPORTID, AP.NAME "
						+ "    FROM LEG L, AIRPORT AP " + "    WHERE AP.AIRPORTID = L.ARR_AIRPORTID " + ") "
						+ "SELECT A.ACCOUNTID, TO_CHAR(L.SCHEDULED_DEP_TIME, 'YYYY-MM-DD HH24:MI:SS') AS DEP_TIME, DEP.NAME AS DEP_AIRPORT, ARR.NAME AS ARR_AIRPORT "
						+ "FROM ACCOUNT A, ETICKET E, LEG L, DEP, ARR " + "WHERE L.SCHEDULED_DEP_TIME >= TO_DATE('"
						+ dep_time + "', 'YYYY-MM-DD HH24:MI:SS')  " + "    AND E.PASSENGERNO = A.ACCOUNTNO  "
						+ "    AND E.LEGID = L.LEGID  " + "    AND DEP.DEP_AIRPORTID = L.DEP_AIRPORTID "
						+ "    AND ARR.ARR_AIRPORTID = L.ARR_AIRPORTID " + "    AND DEP.LEGID = L.LEGID "
						+ "    AND ARR.LEGID = L.LEGID " + "ORDER BY DEP_TIME ASC ";
				rs = stmt.executeQuery(sql);

				System.out.println("AccountID | dep_time | dep_airport | arr_airport");
				System.out.println("------------------------------------------------");

				while (rs.next()) {
					String account_id = rs.getString(1);
					String dep_time_date = rs.getString(2);
					String dep_airport = rs.getString(3);
					String arr_airport = rs.getString(4);
					System.out.println(account_id + " | " + dep_time_date + " | " + dep_airport + " | " + arr_airport);
				}
				rs.close();
				System.out.println();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		case "4":
			try {
				System.out.print("Please input Count [Type 'INT'] : ");
				int group_count = sc.nextInt();
				sc.nextLine();
				String sql = "SELECT E.LEGID, COUNT(*) AS NUMTICKETS FROM LEG L, ETICKET E "
						+ "WHERE L.LEGID = E.LEGID GROUP BY E.LEGID HAVING COUNT(*) >= " + group_count
						+ " ORDER BY NUMTICKETS DESC";
				rs = stmt.executeQuery(sql);

				System.out.println("Leg_id | Num_tickets");
				System.out.println("--------------------");

				while (rs.next()) {
					String leg_id = rs.getString(1);
					int num_tickets = rs.getInt(2);
					System.out.println(leg_id + " | " + num_tickets);
				}
				rs.close();
				System.out.println();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			break;
		case "5":
			return;
		default:
			System.out.println("Wrong input!!");
			System.exit(1);
		}
	}
	
	public void myPage() {
		String sql = "select fname, lname, age, phone, email, sex, address, type from account where AccountID = '" + id
				+ "'";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				String fname = rs.getString(1);
				String lname = rs.getString(2);
				String age = rs.getString(3);
				String phone = rs.getString(4);
				String email = rs.getString(5);
				String sex = rs.getString(6);
				String address = rs.getString(7);
				String type = rs.getString(8);

				System.out.println("[ ?Ç¥ ?†ïÎ≥? ]");
				System.out.println("| ID : " + id);
				System.out.println("| ?Ñ± : " + lname);
				System.out.println("| ?ù¥Î¶? : " + fname);
				System.out.println("| ?Çò?ù¥ : " + age);
				System.out.println("| ?†Ñ?ôîÎ≤àÌò∏ : " + phone);
				System.out.println("| ?ù¥Î©îÏùº : " + email);
				System.out.println("| ?Ñ±Î≥? : " + sex);
				System.out.println("| Ï£ºÏÜå : " + address);
				System.out.println("| Í≥ÑÏ†ï ?ú†?òï : " + type);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("+---------------------------------------------+");
		System.out.println("|                                             |");
		System.out.println("|            My Page - ChangeMode             |");
		System.out.println("|                                             |");
		System.out.println("|                                             |");
		System.out.println("|  1. ChangePassword    2. ChangeFirstName    |");
		System.out.println("|                                             |");
		System.out.println("|  3. ChangeLastName    4. ChangePhoneNumber  |");
		System.out.println("|                                             |");
		System.out.println("|  5. ChangeEmail       6. ChangeSex          |");
		System.out.println("|                                             |");
		System.out.println("|  7. ChangeAddress     8. ChangeAge          |");
		System.out.println("|                                             |");
		System.out.println("|  9. Back                                    |");
		System.out.println("|                                             |");
		System.out.println("+---------------------------------------------+");
		System.out.print(">> ");
		switch (sc.nextLine()) {
		case "1":
			changeInformation(1);
			break;
		case "2":
			changeInformation(2);
			break;
		case "3":
			changeInformation(3);
			break;
		case "4":
			changeInformation(4);
			break;
		case "5":
			changeInformation(5);
			break;
		case "6":
			changeInformation(6);
			break;
		case "7":
			changeInformation(7);
			break;
		case "8":
			changeInformation(8);
			break;
		case "9":
			return;
		default:
			System.out.println("Wrong input!!");
			System.exit(1);
		}
	}

	public void deleteAccount() {
		try {
			String sql = "delete from account where Accountid = '" + id + "'";
			int result = stmt.executeUpdate(sql);
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("[Í≥ÑÏ†ï?ù¥ ?Ç≠?†ú?êò?óà?äµ?ãà?ã§.]");
	}

	public void changeInformation(int cmd) {
		String sql = "";
		switch (cmd) {
		case 1:
			System.out.print("Î≥?Í≤ΩÌï† ?å®?ä§?õå?ìú[ÏµúÎ? 15?ûê] : ");
			String newPassword = sc.nextLine();
			sql = "update account set pwd = '" + newPassword + "' where accountid = '" + id + "'";
			break;
		case 2:
			System.out.print("Î≥?Í≤ΩÌï† First name[ÏµúÎ? 15?ûê] : ");
			String newFname = sc.nextLine();
			sql = "update account set fname = '" + newFname + "' where accountid = '" + id + "'";
			break;
		case 3:
			System.out.print("Î≥?Í≤ΩÌï† Last name[ÏµúÎ? 15?ûê] : ");
			String newLname = sc.nextLine();
			sql = "update account set lname = '" + newLname + "' where accountid = '" + id + "'";
			break;
		case 4:
			System.out.print("Î≥?Í≤ΩÌï† ?†Ñ?ôîÎ≤àÌò∏[xxx-xxxx-xxxx] : ");
			String newPhone = sc.nextLine();
			sql = "update account set phone = '" + newPhone + "' where accountid = '" + id + "'";
			break;
		case 5:
			System.out.print("Î≥?Í≤ΩÌï† ?ù¥Î©îÏùº[ÏµúÎ? 30?ûê] : ");
			String newEmail = sc.nextLine();
			sql = "update account set email = '" + newEmail + "' where accountid = '" + id + "'";
			break;
		case 6:
			System.out.print("Î≥?Í≤ΩÌï† ?Ñ±Î≥?[M or F] : ");
			String newSex = sc.nextLine();
			sql = "update account set sex = '" + newSex + "' where accountid = '" + id + "'";
			break;
		case 7:
			System.out.print("Î≥?Í≤ΩÌï† Ï£ºÏÜå[ÏµúÎ? 50?ûê] : ");
			String newAddress = sc.nextLine();
			sql = "update account set address = '" + newAddress + "' where accountid = '" + id + "'";
			break;
		case 8:
			System.out.print("Î≥?Í≤ΩÌï† ?Çò?ù¥ : ");
			String newAge = sc.nextLine();
			sql = "update account set age = " + newAge + " where accountid = '" + id + "'";
			break;
		case 9:
			return;
		default:
			System.out.println("Wrong input!!");
			System.exit(1);
		}
		
		try {
			int result = stmt.executeUpdate(sql);
			conn.commit();
			System.out.println("[?Ñ±Í≥µÏ†Å?úºÎ°? Î≥?Í≤ΩÎêò?óà?äµ?ãà?ã§.]");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
