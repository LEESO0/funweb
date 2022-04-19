package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static db.JdbcUtil.*;

public class MemberDAO {
	
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 회원 추가작업
	public int insertMember(MemberBean member) {
		int insertCount = 0;
		
		// 1, 2 단계
		con = getConnection();
		try {
			
			// 3단계
			String sql = "INSERT INTO member VALUES (?,?,?,?,now(),?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getPhone());
			pstmt.setString(7, member.getMobile());
			
			// 4단계
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - insertMeber()");
		} finally {
			close(pstmt);
			close(con);
		}
		return insertCount;
	}
	
	// 로그인 작업
	public boolean checkUser(MemberBean member) {
		boolean isLoginSuccess = false;
		
		// 1, 2단계
		con = getConnection();
		
		try {
			// 3단계 : 아이디와 패스워드가 일치하는 레코드 조회
			String sql = "SELECT * FROM member WHERE id=? AND pass=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			
			// 4단계
			rs = pstmt.executeQuery();
			
			// ResultSet 객체의 다음 레코드가 존재할 경우 로그인 성공
			if (rs.next()) {
				isLoginSuccess = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - checkUser()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return isLoginSuccess;
	}
	
	// 회원 상세 정보 조회
	public MemberBean selectMemberInfo(String id) {
		MemberBean member = null;
		
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			// ResultSet 객체의 다음 레코드가 존재할 경우
			// 모든 컬럼 데이터를 MemberBean 객체에 저장
			if(rs.next()) {
				member = new MemberBean();
				
				member.setId(id);
				member.setPass(rs.getString("pass"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setDate(rs.getDate("date"));
				member.setAddress(rs.getString("address"));
				member.setPhone(rs.getString("phone"));
				member.setMobile(rs.getString("mobile"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - selectMemberInfo()");
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		
		return member;
	}
	
	// 회원 정보 수정
	public int updateMember(MemberBean member) {
		int updateCount = 0;
		
		con = getConnection();
		
		try {
			
			// 단, pass값(패스워드)이 없을 경우 이름, 이메일, 주소, 전화번호, 폰번호만 수정
			// 아니면 패스워드, 이름, 이메일, 주소, 전화번호, 폰번호만 수정
			if(member.getPass().equals("")) {		// 패스워드 입력 안했을 경우
				String sql = "UPDATE member SET name=?, email=?, address=?, phone=?, mobile=? WHERE id=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member.getName());
				pstmt.setString(2, member.getEmail());
				pstmt.setString(3, member.getAddress());
				pstmt.setString(4, member.getPhone());
				pstmt.setString(5, member.getMobile());
				pstmt.setString(6, member.getId());
			} else {		// 패스워드 입력했을 경우
				String sql = "UPDATE member SET pass=?, name=?, email=?, address=?, phone=?, mobile=? WHERE id=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member.getPass());
				pstmt.setString(2, member.getName());
				pstmt.setString(3, member.getEmail());
				pstmt.setString(4, member.getAddress());
				pstmt.setString(5, member.getPhone());
				pstmt.setString(6, member.getMobile());
				pstmt.setString(7, member.getId());
			}
			
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - updateMember()");
		} finally {
			close(pstmt);
			close(con);
		}
		
		
		return updateCount;
	}
	
	public boolean checkId(String id) {
		boolean isDuplicate = false;
		
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isDuplicate = true;
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - checkId()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return isDuplicate;
	}
	
	public boolean checkLogin(String id, String pass) {
		boolean isCheckLogin = false;
		
		con = getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isCheckLogin = true;
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - checkLogin()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return isCheckLogin;
	}
}
