package knuAirDB;

import java.io.*;
import java.sql.*;
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

	}

	public void reservation() {

	}

	public void myPage() {
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
			String sql = "delete from membership where AccountNo = " + accountNo;
			stmt.addBatch(sql);
			sql = "delete from account where AccountNo = " + accountNo;
			stmt.addBatch(sql);
			int count[] = stmt.executeBatch();
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("[������ �����Ǿ����ϴ�.]");
	}
	
	public void changeInformation(int cmd) {
		String sql = "";
		switch(cmd) {
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
