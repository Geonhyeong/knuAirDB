package knuAirDB;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Scanner;

public class Passenger {
	Connection conn = null;
	Statement stmt = null;
	String id = null;

	Scanner sc = new Scanner(System.in);

	public Passenger(Connection _conn, Statement _stmt, Identification _id) {
		conn = _conn;
		stmt = _stmt;
		id = _id.id;

		menu();
	}

	public void menu() {
		while (true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|                  Passenger                  |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|       1. Search        2. Reservation       |");
			System.out.println("|                                             |");
			System.out.println("|       3. My Page       4. Logout            |");
			System.out.println("|                                             |");
			System.out.println("|       5. DeleteAccount                      |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");

			switch (sc.nextLine()) {
			case "1":
				search();
				break;
			case "2":
				reservation();
				break;
			case "3":
				myPage();
				break;
			case "4":
				return;
			case "5":
				deleteAccount();
				return;
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}

	public void search() {
		System.out.print("��� ���ø� �Է��ϼ��� >> ");
		String dep_port = sc.nextLine();
		System.out.print("���� ���ø� �Է��ϼ��� >> ");
		String arr_port = sc.nextLine();
		System.out.print("��� ��¥�� �Է��ϼ���(yyyy-mm-dd) >> ");
		String date = sc.nextLine();

		String sql = "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where city = '"
				+ dep_port + "' and airportid=dep_airportid)\r\n" + "intersect\r\n"
				+ "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where city = '"
				+ arr_port + "' and airportid=arr_airportid)\r\n" + "intersect\r\n"
				+ "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where scheduled_dep_time like to_date('"
				+ date + "', 'yyyy-mm-dd'))";

		System.out.println(
				"======================================================================================================================");
		try {
			ResultSet rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			for (int i = 1; i <= cnt; i++) {
				System.out.print(rsmd.getColumnName(i) + "\t\t");
			}
			System.out.print('\n');
			while (rs.next()) {
				System.out.print(rs.getString(1) + "\t");
				System.out.print(rs.getString(2) + "\t\t");
				System.out.print(rs.getString(3) + "\t\t");
				System.out.print(rs.getInt(4) + "\t\t");
				SimpleDateFormat sdfDate = new SimpleDateFormat("YYYY-MM-DD HH:MM:SS");
				Date depDate = rs.getDate(5);
				String strDepDate = sdfDate.format(depDate);
				System.out.print(strDepDate + "\t");
				Date arrDate = rs.getDate(6);
				String strArrDate = sdfDate.format(arrDate);
				System.out.print(strArrDate + "\t");
				System.out.print(rs.getInt(7) + "\r\n");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(
				"======================================================================================================================");

	}

	public void reservation() {
		System.out.print("�����ϰ��� �ϴ� LEGID�� �Է��ϼ��� >> ");
		String legid = sc.nextLine();

		String sql = "select economy_avail_seats, business_avail_seats, first_avail_seats from assigned_by where legid = '"
				+ legid + "'";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			int eco = 0;
			int bus = 0;
			int fir = 0;
			if (rs.next()) {
				eco = rs.getInt(1);
				bus = rs.getInt(2);
				fir = rs.getInt(3);
				System.out.println("[ �ش� ������� ���� �¼��� ������ �����ϴ�. ]");
				System.out.println("[Economy] : " + eco);
				System.out.println("[Business] : " + bus);
				System.out.println("[First] : " + fir);
			} else
				System.out.println("�ش� LEG�� �������� �ʽ��ϴ�.");

			System.out.println("������ �¼��� ���� ���� ������ �Է����ּ���.");
			System.out.print("Economy >> ");
			int res_eco = sc.nextInt();
			System.out.print("Business >> ");
			int res_bus = sc.nextInt();
			System.out.print("First >> ");
			int res_fir = sc.nextInt();
			sc.nextLine(); // fflush()
			System.out.print("���� �ֽ��ϱ�?(yes/no) >> ");
			String isBeggage = sc.nextLine();

			sql = "select airplaneid from assigned_by where legid = '" + legid + "'";
			rs = stmt.executeQuery(sql);
			String airplaneid = "";

			if (rs.next()) {
				airplaneid = rs.getString(1);
			}

			sql = "select diff_seat, diff_beggage from airline al, airplane ap where airplaneid = '" + airplaneid
					+ "' and al.airlineid = ap.airlineid";
			rs = stmt.executeQuery(sql);
			float diff_seat = 0;
			float diff_beggage = 0;

			if (rs.next()) {
				diff_seat = rs.getFloat(1);
				diff_beggage = rs.getFloat(2);
			}
			// System.out.println(airplaneid + " : " + diff_seat + ", " + diff_beggage);
			System.out.println();

			sql = "select price from leg where legid = '" + legid + "'";
			rs = stmt.executeQuery(sql);
			int price_eco = 0;
			if (rs.next()) {
				price_eco = rs.getInt(1);
			}

			int price_bus = (int) (price_eco * diff_seat);
			int price_fir = (int) (price_bus * diff_seat);
			int price_all = price_eco * res_eco + price_bus * res_bus + price_fir * res_fir;
			int price_beg = 0;
			if (isBeggage.compareTo("yes") == 0)
				price_beg = (int) (price_eco * diff_beggage);
			System.out.println("economy �¼� �� : " + res_eco);
			System.out.println("economy �¼� �� ���� : " + price_eco);
			System.out.println("business �¼� �� : " + res_bus);
			System.out.println("business �¼� �� ���� : " + price_bus);
			System.out.println("first �¼� �� : " + res_fir);
			System.out.println("first �¼� �� ���� : " + price_fir);
			System.out.println("Ƽ�� ���� : " + price_all);
			System.out.println("���Ϲ� ���� : " + price_beg);

			sql = "select title, account.accountno, membershipid, travel_count from account, membership where account.accountno = membership.accountno and accountid = '"
					+ id + "'";
			rs = stmt.executeQuery(sql);
			String membership_title = "";
			int accountNo = 0;
			String membershipId = "";
			int travel_count = 0;
			if (rs.next()) {
				membership_title = rs.getString(1);
				accountNo = rs.getInt(2);
				membershipId = rs.getString(3);
				travel_count = rs.getInt(4);
			}

			int disc = 0;
			if (membership_title.compareTo("Silver") == 0) {
				disc = (int) (price_all * 0.05);
			} else if (membership_title.compareTo("Gold") == 0) {
				disc = (int) (price_all * 0.1);
			} else if (membership_title.compareTo("Diamond") == 0) {
				disc = (int) (price_all * 0.15);
			} else if (membership_title.compareTo("Rubi") == 0) {
				disc = (int) (price_all * 0.2);
			}

			System.out.println("���ι޴� ���� : " + disc);
			System.out.println("�� �����ݾ� : " + (price_all + price_beg - disc));
			System.out.print("�����Ͻðڽ��ϱ�? (y/n) >> ");
			String isReserve = sc.nextLine();

			if (isReserve.compareTo("y") == 0) {
				sql = "INSERT INTO ETICKET VALUES ('" + (1000000000 + accountNo) + "', '" + legid + "', " + accountNo
						+ ", " + price_eco + ", " + price_all + ", " + price_beg + ", " + disc + ", " + res_eco + ", "
						+ res_bus + ", " + res_fir + ")";
				stmt.executeUpdate(sql);

				sql = "update assigned_by set economy_avail_seats=" + (eco - res_eco) + ", business_avail_seats = " + (bus - res_bus) + ", first_avail_seats=" + (fir - res_fir) + " where legid = '" + legid + "'";
				stmt.executeUpdate(sql);
				
				travel_count += 1;
				if (travel_count == 11) {
					membership_title = "Gold";
				} else if (travel_count == 21) {
					membership_title = "Diamond";
				} else if (travel_count == 36) {
					membership_title = "Rubi";
				}
				
				sql = "update membership set travel_count=" + travel_count + ", title='" + membership_title + "' where membershipid='" + membershipId + "'";
				stmt.executeUpdate(sql);

				conn.commit();
				System.out.println("���Ÿ� �Ϸ��߽��ϴ�.");
			} else {
				return;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void myPage() {
		while(true)
		{
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|                   My Page                   |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|       1. My Reservation                     |");
			System.out.println("|                                             |");
			System.out.println("|       2. Show My Information                |");
			System.out.println("|                                             |");
			System.out.println("|       3. Change My Information              |");
			System.out.println("|                                             |");
			System.out.println("|       4. Back                               |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");
			switch (sc.nextLine()) {
			case "1":
				showReservation();
				break;
			case "2":
				showInfo();
				break;
			case "3":
				myPageChangeMode();
				break;
			case "4":
				return;
			}
		}
	}
	
	public void showReservation()
	{
		try {
			String sql = "select * from eticket, account where passengerno=accountno and accountid='" + id + "'";
			ResultSet rs = stmt.executeQuery(sql);
			
			System.out.println("LegID\t\tPassengerNo\t\tTotal_Price\t\tNum_of_Economy\tNum_of_Business\tNum_of_First");
			
			while (rs.next()) {
				System.out.print(rs.getString(2) + "\t\t");
				System.out.print(rs.getInt(3) + "\t\t");
				int total_price = rs.getInt(5) + rs.getInt(6) - rs.getInt(7);
				System.out.print(total_price + "\t\t");
				System.out.print(rs.getInt(8) + "\t\t");
				System.out.print(rs.getInt(9) + "\t\t");
				System.out.print(rs.getInt(10) + "\r\n");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void showInfo()
	{
		String sql = "select fname, lname, age, phone, email, sex, address, type, title, travel_count from account a, membership m where a.AccountID = '"
				+ id + "' and a.AccountNo = m.AccountNo";
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
				String m_title = rs.getString(9);
				int travel_count = rs.getInt(10);

				System.out.println("[ �� ���� ]");
				System.out.println("| ID : " + id);
				System.out.println("| �� : " + lname);
				System.out.println("| �̸� : " + fname);
				System.out.println("| ���� : " + age);
				System.out.println("| ��ȭ��ȣ : " + phone);
				System.out.println("| �̸��� : " + email);
				System.out.println("| ���� : " + sex);
				System.out.println("| �ּ� : " + address);
				System.out.println("| ���� ���� : " + type);
				System.out.println("| ����� ��� : " + m_title);
				System.out.println("| ���� Ƚ�� : " + travel_count);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void myPageChangeMode() {
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
			String sql = "delete from account where AccountId = '" + id + "'";
			int result = stmt.executeUpdate(sql);
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("[������ �����Ǿ����ϴ�.]");
	}

	public void changeInformation(int cmd) {
		String sql = "";
		switch (cmd) {
		case 1:
			System.out.print("������ �н�����[�ִ� 15��] : ");
			String newPassword = sc.nextLine();
			sql = "update account set pwd = '" + newPassword + "' where accountid = '" + id + "'";
			break;
		case 2:
			System.out.print("������ First name[�ִ� 15��] : ");
			String newFname = sc.nextLine();
			sql = "update account set fname = '" + newFname + "' where accountid = '" + id + "'";
			break;
		case 3:
			System.out.print("������ Last name[�ִ� 15��] : ");
			String newLname = sc.nextLine();
			sql = "update account set lname = '" + newLname + "' where accountid = '" + id + "'";
			break;
		case 4:
			System.out.print("������ ��ȭ��ȣ[xxx-xxxx-xxxx] : ");
			String newPhone = sc.nextLine();
			sql = "update account set phone = '" + newPhone + "' where accountid = '" + id + "'";
			break;
		case 5:
			System.out.print("������ �̸���[�ִ� 30��] : ");
			String newEmail = sc.nextLine();
			sql = "update account set email = '" + newEmail + "' where accountid = '" + id + "'";
			break;
		case 6:
			System.out.print("������ ����[M or F] : ");
			String newSex = sc.nextLine();
			sql = "update account set sex = '" + newSex + "' where accountid = '" + id + "'";
			break;
		case 7:
			System.out.print("������ �ּ�[�ִ� 50��] : ");
			String newAddress = sc.nextLine();
			sql = "update account set address = '" + newAddress + "' where accountid = '" + id + "'";
			break;
		case 8:
			System.out.print("������ ���� : ");
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
			System.out.println("[���������� ����Ǿ����ϴ�.]");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
