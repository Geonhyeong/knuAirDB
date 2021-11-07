package knuAirDB;

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
			System.out.println("|        1. Manage        2. MyPage           |");
			System.out.println("|                                             |");
			System.out.println("|        3. Logout        4. DeleteAccount    |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");

			switch (sc.nextLine()) {
			case "1":
				manage();
				break;
			case "2":
				myPage();
				break;
			case "3":
				return;
			case "4":
				deleteAccount();
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
		System.out.println("|       5. Back                               |");
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
			System.out.println("|        3. Delete           4. Back          |");
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
				System.out.println("[ Insert할 Airplane 정보를 입력하시오 ]");
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
					
					System.out.println("[성공적으로 Insert 되었습니다]");
					System.out.println("[ Insert 정보 ]");
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
					System.out.println("[ Update할 AirplaneID 정보를 입력하시오 ]");
					System.out.print("변경할 Airplane ID : ");
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
							System.out.println("[ 입력한 AirplaneID가 존재하지 않습니다. ]");
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
						System.out.print("변경할 새로운 Airline ID : ");
						String newAirlineid = sc.nextLine();
						sql = "UPDATE AIRPLANE SET airlineid = '" + newAirlineid + "' where airplaneid = '" + airplaneid + "'";
						break;
					case "2":
						System.out.print("변경할 새로운 Type : ");
						String newType = sc.nextLine();
						sql = "UPDATE AIRPLANE SET type = '" + newType + "' where airplaneid = '" + airplaneid + "'";
						break;
					case "3":
						System.out.print("변경할 새로운 Number of Economy Seats : ");
						String newEconomySeats = sc.nextLine();
						sql = "UPDATE AIRPLANE SET economy_seats = '" + newEconomySeats + "' where airplaneid = '" + airplaneid + "'";
						break;
					case "4":
						System.out.print("변경할 새로운 Number of Business Seats : ");
						String newBusinessSeats = sc.nextLine();
						sql = "UPDATE AIRPLANE SET business_seats = '" + newBusinessSeats + "' where airplaneid = '" + airplaneid + "'";
						break;
					case "5":
						System.out.print("변경할 새로운 Number of First Seats : ");
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
						System.out.println("[성공적으로 변경되었습니다.]");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				break;
				
			case "3": // Delete
				System.out.println("[ Delete할 AirplaneID 정보를 입력하시오 ]");
				System.out.print("삭제할 Airplane ID : ");
				airplaneid = sc.nextLine();
				try {
					sql = "delete from airplane where airplaneid = '" + airplaneid + "'";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					System.out.println("[ 삭제되었습니다. ]");
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
			System.out.println("|        3. Delete          4. Back           |");
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
				System.out.println("[ Insert할 Airline 정보를 입력하시오 ]");
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
					
					System.out.println("[성공적으로 Insert 되었습니다]");
					System.out.println("[ Insert 정보 ]");
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
					System.out.println("[ Update할 AirlineID 정보를 입력하시오 ]");
					System.out.print("변경할 Airline ID : ");
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
							System.out.println("[ 입력한 AirlineID가 존재하지 않습니다. ]");
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
						System.out.print("변경할 새로운 Name : ");
						String newName = sc.nextLine();
						sql = "UPDATE AIRLINE SET airlineid = '" + newName + "' where airlineid = '" + airlineid + "'";
						break;
					case "2":
						System.out.print("변경할 새로운 Price ratio difference of seat : ");
						String newDiff_Seat = sc.nextLine();
						sql = "UPDATE AIRLINE SET diff_seat = '" + newDiff_Seat + "' where airlineid = '" + airlineid + "'";
						break;
					case "3":
						System.out.print("변경할 새로운 Price ratio difference of beggage : ");
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
						System.out.println("[성공적으로 변경되었습니다.]");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				break;
				
			case "3": // Delete
				System.out.println("[ Delete할 AirlineID 정보를 입력하시오 ]");
				System.out.print("삭제할 Airline ID : ");
				airlineid = sc.nextLine();
				try {
					sql = "delete from airline where airlineid = '" + airlineid + "'";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					System.out.println("[ 삭제되었습니다. ]");
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
				
				
				System.out.println("[ Insert할 Airport 정보를 입력하시오 ]");
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
					
					System.out.println("[성공적으로 Insert 되었습니다]");
					System.out.println("[ Insert 정보 ]");
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
					System.out.println("[ Update할 AirportID 정보를 입력하시오 ]");
					System.out.print("변경할 Airport ID : ");
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
							System.out.println("[ 입력한 AirportID가 존재하지 않습니다. ]");
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
						System.out.print("변경할 새로운 Name : ");
						String newName = sc.nextLine();
						sql = "UPDATE AIRPORT SET airportid = '" + newName + "' where airportid = '" + airportid + "'";
						break;
					case "2":
						System.out.print("변경할 새로운 City : ");
						String newCity = sc.nextLine();
						sql = "UPDATE AIRPORT SET city = '" + newCity + "' where airportid = '" + airportid + "'";
						break;
					case "3":
						System.out.print("변경할 새로운 Number of total gates : ");
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
						System.out.println("[성공적으로 변경되었습니다.]");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				break;
				
			case "3": // Delete
				System.out.println("[ Delete할 AirportID 정보를 입력하시오 ]");
				System.out.print("삭제할 Airport ID : ");
				airportid = sc.nextLine();
				try {
					sql = "delete from airport where airportid = '" + airportid + "'";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					System.out.println("[ 삭제되었습니다. ]");
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
			System.out.println("|        3. Delete          4. Back           |");
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
				System.out.println("[ Insert할 Leg 정보를 입력하시오 ]");
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
					
					System.out.println("[성공적으로 Insert 되었습니다]");
					System.out.println("[ Insert 정보 ]");
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
					System.out.println("[ Update할 LegID 정보를 입력하시오 ]");
					System.out.print("변경할 Leg ID : ");
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
							System.out.println("[ 입력한 LegID가 존재하지 않습니다. ]");
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
						System.out.print("변경할 새로운 Depart Airport ID : ");
						String newDepAirportID = sc.nextLine();
						sql = "UPDATE LEG SET dep_airportid = '" + newDepAirportID + "' where legid = '" + legid + "'";
						break;
					case "2":
						System.out.print("변경할 새로운 Arrive AirportID : ");
						String newArrAirportID = sc.nextLine();
						sql = "UPDATE LEG SET arr_airportid = '" + newArrAirportID + "' where legid = '" + legid + "'";
						break;
					case "3":
						System.out.print("변경할 새로운 Departure gate : ");
						String newDepGate = sc.nextLine();
						sql = "UPDATE LEG SET dep_gate = '" + newDepGate + "' where legid = '" + legid + "'";
						break;
					case "4":
						System.out.print("변경할 새로운 Scheduled departure time : ");
						String newSchedDepTime = sc.nextLine();
						sql = "UPDATE LEG SET sched_dep_time = '" + newSchedDepTime + "' where legid = '" + legid + "'";
						break;
					case "5":
						System.out.print("변경할 새로운 Scheduled arrival time : ");
						String newSchedArrTime = sc.nextLine();
						sql = "UPDATE LEG SET sched_arr_time = '" + newSchedArrTime + "' where legid = '" + legid + "'";
						break;
					case "6":
						System.out.print("변경할 새로운 AdminNo : ");
						String newAdminNo = sc.nextLine();
						sql = "UPDATE LEG SET adminno = '" + newAdminNo + "' where legid = '" + legid + "'";
						break;
					case "7":
						System.out.print("변경할 새로운 Price : ");
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
						System.out.println("[성공적으로 변경되었습니다.]");
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				break;
				
			case "3": // Delete
				System.out.println("[ Delete할 LegID 정보를 입력하시오 ]");
				System.out.print("삭제할 Leg ID : ");
				legid = sc.nextLine();
				try {
					sql = "delete from leg where legid = '" + legid + "'";
					int result = stmt.executeUpdate(sql);
					conn.commit();
					System.out.println("[ 삭제되었습니다. ]");
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

				System.out.println("[ 내 정보 ]");
				System.out.println("| ID : " + id);
				System.out.println("| 성 : " + lname);
				System.out.println("| 이름 : " + fname);
				System.out.println("| 나이 : " + age);
				System.out.println("| 전화번호 : " + phone);
				System.out.println("| 이메일 : " + email);
				System.out.println("| 성별 : " + sex);
				System.out.println("| 주소 : " + address);
				System.out.println("| 계정 유형 : " + type);
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
		int accountNo = -1;

		try {
			String sql = "select accountno from account where accountid ='" + id + "'";
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				accountNo = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			String sql = "delete from account where AccountNo = " + accountNo;
			int result = stmt.executeUpdate(sql);
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("[계정이 삭제되었습니다.]");
	}

	public void changeInformation(int cmd) {
		String sql = "";
		switch (cmd) {
		case 1:
			System.out.print("변경할 패스워드[최대 15자] : ");
			String newPassword = sc.nextLine();
			sql = "update account set pwd = '" + newPassword + "' where accountid = '" + id + "'";
			break;
		case 2:
			System.out.print("변경할 First name[최대 15자] : ");
			String newFname = sc.nextLine();
			sql = "update account set fname = '" + newFname + "' where accountid = '" + id + "'";
			break;
		case 3:
			System.out.print("변경할 Last name[최대 15자] : ");
			String newLname = sc.nextLine();
			sql = "update account set lname = '" + newLname + "' where accountid = '" + id + "'";
			break;
		case 4:
			System.out.print("변경할 전화번호[xxx-xxxx-xxxx] : ");
			String newPhone = sc.nextLine();
			sql = "update account set phone = '" + newPhone + "' where accountid = '" + id + "'";
			break;
		case 5:
			System.out.print("변경할 이메일[최대 30자] : ");
			String newEmail = sc.nextLine();
			sql = "update account set email = '" + newEmail + "' where accountid = '" + id + "'";
			break;
		case 6:
			System.out.print("변경할 성별[M or F] : ");
			String newSex = sc.nextLine();
			sql = "update account set sex = '" + newSex + "' where accountid = '" + id + "'";
			break;
		case 7:
			System.out.print("변경할 주소[최대 50자] : ");
			String newAddress = sc.nextLine();
			sql = "update account set address = '" + newAddress + "' where accountid = '" + id + "'";
			break;
		case 8:
			System.out.print("변경할 나이 : ");
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
			System.out.println("[성공적으로 변경되었습니다.]");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
