package news;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static db.JdbcUtil.*;

public class NewsDAO {
	
	// DB 작업에 필요한 변수 선언
	Connection con;
	PreparedStatement pstmt, pstmt2;
	ResultSet rs;
	
	//  입력받은 폼 데이터를 news_board 테이블에 insert하는 insertBoard() 메서드 정의
	//	  파라미터 : NewsBean(bean) , 리턴타입 : int(insertCount)
	public int insertBoard(NewsBean bean) {
		int insertCount = 0;
		int num = 1;	// 글번호, 초기값 1
		
		try {
			// 1, 2단계 : DB 연결
			con = getConnection();
			
			//------------ 글 번호 계산 ---------------
			// 3단계 : SQL 구문 작성 후 전달(select)			
			String selectSql = "SELECT num FROM news_board";
			pstmt = con.prepareStatement(selectSql);
			
			// 4단계 : SQL 구문 실행 및 처리(select)
			rs = pstmt.executeQuery();
			
			//rs.next()가 true이면 조회된 num에 +1
			//			  false이면 num = 1
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
			//-----------------------------------------
			
			// 3단계 : SQL 구문 작성 후 전달(insert)
			String sql = "INSERT INTO news_board VALUES (?,?,?,?,?,now(),0)";
			
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, bean.getName());
			pstmt2.setString(3, bean.getPass());
			pstmt2.setString(4, bean.getSubject());
			pstmt2.setString(5, bean.getContent());
			
			// 4단계 : SQL 구문 실행 및 처리(insert)
			insertCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -insertBoard()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		return insertCount;
	}
	
	// NewsDAO 객체 생성 후 전체 페이지 계산하는 selectListCount() 메서드 호출
	// 파라미터 : 없음 , 리턴타입 : int(listCount)
	public int selectListCount() {
		int listCount = 0;
		
		try {
			// 1, 2단계 : DB 연결
			con = getConnection();
			
			// 3단계 : SQL 구문 작성 후 전달
			String sql = "SELECT COUNT(num) FROM news_board";
			pstmt = con.prepareStatement(sql);
			
			// 4단계
			rs = pstmt.executeQuery();
			
			// 조회 시 나오는 num의 갯수(총 게시물 수)를 listCount에 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -selectListCount()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
			close(con);
		}
		return listCount;
	}
	
	// NewsDAO 객체의 selectNewsList() 메서드 호출
	// 리턴타입 : ArrayList<NewsBean>(newsList) / 파라미터 : pageNum, listLimit
	public ArrayList<NewsBean> selectNewsList(int pageNum, int listLimit) {
		ArrayList<NewsBean> newsList = null;
		
		try {
			// 1, 2단계 : DB 연결
			con = getConnection();
			
			int startRow = (pageNum - 1) * listLimit; 
			
			// 3단계 : SQL 구문 작성 후 전달
			String sql = "SELECT * FROM news_board ORDER BY num DESC LIMIT ?,?";
			pstmt  = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			// 4단계 : SQL 구문 실행
			rs = pstmt.executeQuery();
			
			newsList = new ArrayList<NewsBean>();
			
			while(rs.next()) {
				NewsBean bean = new NewsBean();
				
				bean.setNum(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPass(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setContent(rs.getString(5));
				bean.setDate(rs.getDate(6));
				bean.setReadcount(rs.getInt(7));
				
				newsList.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -selectNewsList()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
			close(con);
		}
		return newsList;
	}
	
	// NewsDAO 객체의 selectNews() 메서드를 호출해서
	// num에 해당하는 레코드를 출력
	// 파라미터 : num / 리턴타입 : NewsBean (news)
	public NewsBean selectNews(int num) {
		NewsBean news = null;
		
		try {
			// 1, 2단계
			con = getConnection();
			
			// 3단계
			String sql = "SELECT * FROM news_board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			// 4단계
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				news = new NewsBean(rs.getInt(1), rs.getString(2), 
					   rs.getString(3), rs.getString(4), rs.getString(5), 
					   rs.getDate(6), rs.getInt(7));
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -selectNews()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
			close(con);
		}
		return news;
	}
	
	// NewsDAO 객체를 생성한 후 정보를 update하는 updateNews() 메서들 호출
	// 리턴타입 : int(updateCount) / 파라미터 : bean(NewsBean)
	public int updateNews(NewsBean bean) {
		int updateCount = 0;
		
		try {
			// 1, 2단계 : DB연결
			con = getConnection();
			
			// 3단계 : SQL 작성 후 전달 (select 구문)
			// 글번호(num)에 해당하는 비밀번호(pass) 일치 여부 확인
			String selectSql = "SELECT * FROM news_board WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(selectSql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getPass());
			
			// 4단계 : SQL 구문 실행
			rs = pstmt.executeQuery();
			
			// 글번호(num)과 비밀번호(pass)가 일치하는 레코드가 없을 경우 0 리턴
			//													있을 경우 update 구문 작업 진행
			if(!rs.next()) {
				return 0;
			}
			
			// 3단계 : SQL 작성 후 전달 (update 구문)
			String updateSql = "UPDATE news_board SET name=?,subject=?,content=? WHERE num=?"; 
			pstmt2 = con.prepareStatement(updateSql);
			
			pstmt2.setString(1, bean.getName());
			pstmt2.setString(2, bean.getSubject());
			pstmt2.setString(3, bean.getContent());
			pstmt2.setInt(4, bean.getNum());
			
			// 4단계 : SQL 구문 실행
			updateCount = pstmt2.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -updateNews()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		
		return updateCount;
		
		}
	
	//글목록 클릭 시 조회수가 증가하는 updateReadCount() 메서드 호출
	//리턴타입 : int(updateCount) / 파라미터 : num
	public void updateReadCount(int num) {
		
		try {
			// 1, 2단계 : DB연결
			con = getConnection();
			
			// 3단계 : SQL 작성 후 전달 (update 구문)
			String sql = "UPDATE news_board SET readCount=readCount+1 WHERE num=?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			// 4단계 : SQL 구문 실행
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -updateReadCount()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(pstmt);
			close(con);
		}
	}
	
	// 비밀번호가 일치할 경우 num에 해당하는 레코드를 삭제하는 deleteNews() 메서드 호출
	// 리턴타입 : int(deleteCount) / 파라미터 : num
	public int deleteNews(int num, String pass) {
		int deleteCount = 0;
		
		try {
			// 1, 2단계 : DB연결
			con = getConnection();
			
			// 3단계 : SQL 작성 후 전달 (select 구문)
			// 글번호(num)에 해당하는 비밀번호(pass) 일치 여부 확인
			String selectSql = "SELECT * FROM news_board WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(selectSql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
						
			// 4단계 : SQL 구문 실행
			rs = pstmt.executeQuery();
						
			// 글번호(num)과 비밀번호(pass)가 일치하는 레코드가 없을 경우 리턴
			//													있을 경우 update 구문 작업 진행
			if(!rs.next()) {
				return 0;
			}
			
			// 3단계 : SQL 작성 후 전달 (delete 구문)
			String deleteSql = "DELETE FROM news_board WHERE num=?"; 
			pstmt2 = con.prepareStatement(deleteSql);
			pstmt2.setInt(1, num);
			
			// 4단계 : SQL 구문 실행
			deleteCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -deleteNews()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		
		return deleteCount;
	}
	
	// NewsDAO 객체 생성 후 전체 페이지 계산하는 selectSearchNewsListCount() 메서드 호출
	// 검색타입(searchType) 설정했을 때 검색어(keyword)를 포함하는 경우
	// 파라미터 : keyword, searchType / 리턴타입 : int(searchListCount)
	public int selectSearchNewsListCount(String keyword, String searchType) {
		int searchListCount = 0;
		
		try {
			// 1, 2단계 : DB 연결
			con = getConnection();
			
			// 3단계 : SQL 구문 작성 후 전달
			String sql = "SELECT COUNT(num) FROM news_board WHERE " + searchType + " LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			
			// 4단계
			rs = pstmt.executeQuery();
			
			// 조회 시 나오는 num의 갯수(총 게시물 수)를 listCount에 저장
			if(rs.next()) {
				searchListCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -selectSearchNewsListCount()");
			e.printStackTrace();
		} finally { 
			// 자원 반환
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return searchListCount;
	}
	
	// NewsDAO 객체의 selectSearchNewsList() 메서드 호출
	// 검색타입(searchType) 설정했을 때 검색어(keyword)를 포함하는 경우
	// 리턴타입 : ArrayList<NewsBean>(newsList) / 파라미터 : pageNum, listLimit, keyword, searchType
	public ArrayList<NewsBean> selectSearchNewsList(int pageNum, int listLimit, String keyword, String searchType) {
		ArrayList<NewsBean> newsList = null;
		
		try {
			// 1, 2단계 : DB 연결
			con = getConnection();
			
			int startRow = (pageNum - 1) * listLimit; 
			
			// 3단계 : SQL 구문 작성 후 전달
			String sql = "SELECT * FROM news_board WHERE " + searchType + " LIKE ? ORDER BY num DESC LIMIT ?,?";
			pstmt  = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			
			// 4단계 : SQL 구문 실행
			rs = pstmt.executeQuery();
			
			newsList = new ArrayList<NewsBean>();
			
			while(rs.next()) {
				NewsBean bean = new NewsBean();
				
				bean.setNum(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPass(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setContent(rs.getString(5));
				bean.setDate(rs.getDate(6));
				bean.setReadcount(rs.getInt(7));
				
				newsList.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -selectNewsList()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return newsList;
		
	}
	// NewsDAO 객체의 selectRecentNewsList() 메서드 호출
	// 최근 5개의 public news 게시물 조회
	// 리턴타입 : ArrayList<NewsBean> / 파라미터 : 없음
	public ArrayList<NewsBean> selectRecentNewsList() {
		ArrayList<NewsBean> newsList = null;
		
		try {
			// 1, 2단계 : DB 연결
			con = getConnection();
			
			// 3단계 : SQL 구문 작성 후 전달
			String sql = "SELECT * FROM news_board ORDER BY num DESC LIMIT ?,?";
			pstmt  = con.prepareStatement(sql);
			pstmt.setInt(1, 0);
			pstmt.setInt(2, 5);
			
			// 4단계 : SQL 구문 실행
			rs = pstmt.executeQuery();
			
			newsList = new ArrayList<NewsBean>();
			
			while(rs.next()) {
				NewsBean bean = new NewsBean();
				
				bean.setNum(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPass(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setContent(rs.getString(5));
				bean.setDate(rs.getDate(6));
				bean.setReadcount(rs.getInt(7));
				
				newsList.add(bean);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 -selectRecentNewsList()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return newsList;
	}
}