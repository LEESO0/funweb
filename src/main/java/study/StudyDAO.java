package study;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static db.JdbcUtil.*;

public class StudyDAO {
	
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	// 글 작성
	// insert 될때마다 글번호 +1
	public int insertStudy(StudyBean bean) {
		int insertCount = 0;
		int num = 0;
		try {
			con = getConnection();
			
			String calNumSql = "SELECT MAX(num) FROM study_board ORDER BY num DESC";
			
			pstmt = con.prepareStatement(calNumSql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
		
			String sql = "INSERT INTO study_board VALUES (?,?,?,?,?,?,?,?,?,0)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bean.getId());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getIntroduction());
			pstmt.setString(5, bean.getContactType());
			pstmt.setString(6, bean.getStudyType());
			pstmt.setString(7, bean.getSpace());
			pstmt.setString(8, bean.getWeek());
			pstmt.setInt(9, bean.getTimes());
			
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - insertStudy()");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return insertCount;
	}
	
	//StudyDAO 객체 생성 후 전체 페이지 계산하는 selectStudyListCount() 메서드 호출
	//파라미터 : 없음 , 리턴타입 : int(listCount)
	public int selectStudyListCount() {
		int listCount = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FROM study_board ORDER BY num DESC";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectStudyListCount()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return listCount;
	}
	
	// 모든 스터디 목록 조회 후 출력하는 selectStudyList() 메서드 호출
	// 리턴타입 : ArrayList<StudyBean>(studyList) / 파라미터 : pageNum, listLimit
	public ArrayList<StudyBean> selectStudyList(int pageNum, int listLimit) {
		ArrayList<StudyBean> studyList = null;
		
		try {
			con = getConnection();
			
			// 현재 페이지의 시작 페이지번호
			int start = (pageNum - 1) * listLimit;
			
			String sql = "SELECT * FROM study_board ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, listLimit);
			
			rs = pstmt.executeQuery();
			
			studyList = new ArrayList<StudyBean>();
			
			while(rs.next()) {
				StudyBean bean = new StudyBean();
				bean.setNum(rs.getInt(1));
				bean.setId(rs.getString(2));
				bean.setSubject(rs.getString(3));
				bean.setIntroduction(rs.getString(4));
				bean.setContactType(rs.getString(5));
				bean.setStudyType(rs.getString(6));
				bean.setSpace(rs.getString(7));
				bean.setWeek(rs.getString(8));
				bean.setTimes(rs.getInt(9));
				bean.setLikeCount(rs.getInt(10));
				
				studyList.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectStudyList()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return studyList;
	}
	
	// num에 해당하는 레코드를 출력하는 selectStudy() 메서드 호출
	// 리턴타입 : StudyBean / 파라미터 : num
	public StudyBean selectStudy(int num) {
		StudyBean bean = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM study_board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			bean = new StudyBean();
			
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setId(rs.getString(2));
				bean.setSubject(rs.getString(3));
				bean.setIntroduction(rs.getString(4));
				bean.setContactType(rs.getString(5));
				bean.setStudyType(rs.getString(6));
				bean.setSpace(rs.getString(7));
				bean.setWeek(rs.getString(8));
				bean.setTimes(rs.getInt(9));
				bean.setLikeCount(rs.getInt(10));
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectStudy()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return bean;
	}
	
	// num에 해당하는 글의 pass가 일치한 경우 글을 삭제하는 메서드 deleteStudy() 호출
	// 리턴타입 : int(deleteCount) / 파라미터 : num, pass
	public int deleteStudy(int num, String pass) {
		int deleteCount = 0;
		String id = "";
		try {
			con = getConnection();
			
			// 글번호에 해당하는 작성자명(아이디)를 study_board 테이블에서 조회
			String selectIdSql = "SELECT id FROM study_board WHERE num=?";
			pstmt = con.prepareStatement(selectIdSql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 조회 결과가 있을 경우 id 값을 저장
				id = rs.getString(1);
			}
			
			// id값과 pass값이 일치하는 데이터가 있는지를 member 테이블에서 조회
			String selectPassSql = "SELECT * FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(selectPassSql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			
			// 일치하는 데이터가 있을 경우 삭제 작업 진행
			if(rs.next()) {
				String deleteSql = "DELETE FROM study_board WHERE num=?";
				pstmt = con.prepareStatement(deleteSql);
				pstmt.setInt(1, num);
				
				deleteCount = pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - deleteStudy()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return deleteCount;
	}
	
	// 데이터를 수정하는 updateStudy() 메서드 호출
	// 리턴타입 : int(updateCount) / 파라미터 : studyBean
	public int updateStudy(StudyBean bean, String pass) {
		int updateCount = 0;
		String id = "";
		try {
			con = getConnection();
			
			// 글번호에 해당하는 작성자명(아이디)를 study_board 테이블에서 조회
			String selectIdSql = "SELECT id FROM study_board WHERE num=?";
			pstmt = con.prepareStatement(selectIdSql);
			pstmt.setInt(1, bean.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				id = rs.getString(1);
			}
			
			// id값과 pass값이 일치하는 데이터가 있는지를 member 테이블에서 조회
			String selectPassSql = "SELECT * FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(selectPassSql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			
			// 일치하는 데이터가 있을 경우 수정 작업 진행
			if (rs.next()) {
				String updateSql = "UPDATE study_board SET subject=?,introduction=?,contactType=?,studyType=?,space=?,week=?,times=? WHERE num=?";
				
				pstmt = con.prepareStatement(updateSql);
				pstmt.setString(1, bean.getSubject());
				pstmt.setString(2, bean.getIntroduction());
				pstmt.setString(3, bean.getContactType());
				pstmt.setString(4, bean.getStudyType());
				pstmt.setString(5, bean.getSpace());
				pstmt.setString(6, bean.getWeek());
				pstmt.setInt(7, bean.getTimes());
				pstmt.setInt(8, bean.getNum());
				
				updateCount = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - updateStudy()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return updateCount;
	}
	
	// 체크된 데이터의 값을 가지는 스터디 목록 조회 후 출력하는 selectCheckedStudyList() 메서드 호출
	// 리턴타입 : ArrayList<StudyBean>(studyList) / 파라미터 : pageNum, listLimit, contactType, studyType, times, week, space
	public ArrayList<StudyBean> selectCheckedStudyList(int pageNum, int listLimit, String contactType, String studyType, int times, String week, String space) {
		ArrayList<StudyBean> studyList = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM  study_board WHERE contactType=? AND studyType=? AND space=? AND times=? AND week=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, contactType);
			pstmt.setString(2, studyType);
			pstmt.setString(3, space);
			pstmt.setInt(4, times);
			pstmt.setString(5, week);
			
			rs = pstmt.executeQuery();
			
			studyList = new ArrayList<StudyBean>();
			
			while(rs.next()) {
				StudyBean bean = new StudyBean();
				bean.setNum(rs.getInt(1));
				bean.setId(rs.getString(2));
				bean.setSubject(rs.getString(3));
				bean.setIntroduction(rs.getString(4));
				bean.setContactType(rs.getString(5));
				bean.setStudyType(rs.getString(6));
				bean.setSpace(rs.getString(7));
				bean.setWeek(rs.getString(8));
				bean.setTimes(rs.getInt(9));
				bean.setLikeCount(rs.getInt(10));
				
				studyList.add(bean);
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectCheckedStudyList()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return studyList;
	}
	
	//StudyDAO 객체 생성 후 체크된 데이터의 값을 가지는 페이지의 총 갯수 계산하는 selectChecktedStudyListCount() 메서드 호출
	//파라미터 : contactType, studyType, times, week, space , 리턴타입 : int(listCount)
	public int selectChecktedStudyListCount(String contactType, String studyType, int times, String week, String space) {
		int listCount = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FRON study_board WHERE contactType=? AND studyType=? AND space=? AND times=? AND week=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, contactType);
			pstmt.setString(2, studyType);
			pstmt.setString(3, space);
			pstmt.setInt(4, times);
			pstmt.setString(5, week);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectChecktedStudyListCount()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return listCount;
	}
	
	// num에 해당하는 레코드의 좋아요 수를 증가시키는 updateLikeCount() 메서드 호출
	// 리턴타입 : void / 파라미터 : num
	public int updateLikeCount(int num) {
		int updateLikeCount = 0;
		
		try {
			con = getConnection();
			
			String sql = "UPDATE study_board SET likeCount=likeCount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			updateLikeCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - updateLikeCount()");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return updateLikeCount;
	}
	
	// Best Study List에 좋아요가 높은 순으로 3개의 레코드만 출력하는 selectBestStudyList() 출력
	// 리턴타입 : ArrayList<StudyBean> (bestStudyList) / 파라미터 : 없음
	public ArrayList<StudyBean> selectBestStudyList() {
		ArrayList<StudyBean> studyList = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM study_board ORDER BY likeCount DESC LIMIT 3";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			studyList = new ArrayList<StudyBean>();
			
			while(rs.next()) {
				StudyBean bean = new StudyBean();
				bean.setNum(rs.getInt(1));
				bean.setId(rs.getString(2));
				bean.setSubject(rs.getString(3));
				bean.setIntroduction(rs.getString(4));
				bean.setContactType(rs.getString(5));
				bean.setStudyType(rs.getString(6));
				bean.setSpace(rs.getString(7));
				bean.setWeek(rs.getString(8));
				bean.setTimes(rs.getInt(9));
				bean.setLikeCount(rs.getInt(10));
				
				studyList.add(bean);
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectBestStudyList()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return studyList;
	}
}





