package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static db.JdbcUtil.*;

public class BoardDAO {
	
	Connection con;
	PreparedStatement pstmt, pstmt2;
	ResultSet rs;
	// 글쓰기 작업 수행
	public int insertBoard(BoardBean board) {
		int insertCount = 0;
		int num = 1;	// 새글 번호를 저장할 변수 (초기값 1)

		try {
			con = getConnection();
			// 1) 새글 번호 계산
			// 현재 게시물들 중 가장 큰 num 값 조회하여 조회 결과가 없을 경우 num = 1로 설정하고,
			// 아니면, 해당 num 값 + 1 을 수행한 값을 num으로 설정
			String sql = "SELECT MAX(num) FROM board"; // board 테이블의 num 컬럼 중 최대값 조회
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			// rs.next() 메서드를 통해 다음 레코드 존재 여부 확인
			// => 다음 레코드가 존재하는 경우 기존 게시물이 있다는 의미이므로
			//    조회된 값(num의 최대값 + 1)을 num 변수에 저장
			if(rs.next()) {	// 등록된 게시물이 하나라도 존재할 경우(= 최대값 조회될 경우)
				num = rs.getInt(1) + 1;
			}
			
//			System.out.println(num);
			
			// 2) 글 쓰기 작업 수행
			String insertSql = "INSERT INTO board VALUES (?,?,?,?,?,now(),0)";
			
			pstmt2 = con.prepareStatement(insertSql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, board.getName());
			pstmt2.setString(3, board.getPass());
			pstmt2.setString(4, board.getSubject());
			pstmt2.setString(5, board.getContent());
			
			insertCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - insertBoard()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		
		return insertCount;
	}
	
	// 글 목록 조회
	public ArrayList<BoardBean> selectBoardList(int pageNum, int listLimit) {
		ArrayList<BoardBean> boardList = null;
		
		try {
			con = getConnection();
			
			// 현재 페이지에서 불러올 목록의 첫번째 행 번호 계산
			int startRow = (pageNum - 1) * listLimit;
				
			// 글번호 기준으로 내림차순 정렬
			// SELECT 컬럼명 FROM 테이블명 ORDER BY 정렬할 컬럼명 정렬방식;
			//    (정렬방식 - 오름차순 DESC, 내림차순 ASC)
			// SELECT 컬럼명 FROM 테이블명 LIMIT 시작행번호, 목록갯수;
			String sql = "SELECT * FROM board ORDER BY num DESC LIMIT ?,?";
			// 목록갯수는 파라미터로 전달받은 listLimit 값 사용
			// 시작행 번호 : (페이지번호 - 1) * 목록갯수 값 사용

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			rs = pstmt.executeQuery();
				
			boardList = new ArrayList<BoardBean>();
				
			while(rs.next()) {
				BoardBean board = new BoardBean();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getDate("date"));
				board.setReadcount(rs.getInt("readcount"));

				boardList.add(board);
			}
			
//			System.out.println(boardList);
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectBoardList()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return boardList;
	}
	
	// 전체 게시물 목록 갯수 조회
	public int selectListCount() {
		int listCount = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FROM board"; 
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 조회된 결과값의 첫번째 값을 저장
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectListCount()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return listCount;
			
	}
	
	// num에 해당하는 레코드 조회
	public BoardBean selectBoard(int num) {
		BoardBean board = null;
		
		try {
			// 1,2단계
			con = getConnection();
			
			// 3단계
			String sql = "SELECT * FROM board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			// 4단계
			rs = pstmt.executeQuery();
				
			// rs.next()로 레코드 존재 여부 확인
			if(rs.next()) {
//				System.out.println(rs.getInt("num"));
//				System.out.println(rs.getString("name"));
//				System.out.println(rs.getString("pass"));
//				System.out.println(rs.getString("subject"));
//				System.out.println(rs.getString("content"));
//				System.out.println(rs.getDate("date"));
//				System.out.println(rs.getInt("readcount"));
				
				board = new BoardBean();	// 레코드를 boardBean 객체에 저장
				board.setNum(num);
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getDate("date"));
				board.setReadcount(rs.getInt("readcount"));

//				System.out.println(board);
					
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectBoard()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return board;
	}
	
	// 조회수 증가
	public void updateReadCount(int num) {
			
		try {
			// 1, 2단계
			con = getConnection();
			
			// 3단계, 전달받은 num에 해당하는 글 조회수(readcount) 증가
			String sql = "UPDATE board SET readcount=readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
				
			// 4단계
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - updateReadCount()");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		
	}
	
	// 글 수정
	public int updateBoard(BoardBean board) {
		int updateCount = 0;		
		
		try {
			con = getConnection();
			
			// 입력받은 pass가 일치한 지 확인
			String sql = "SELECT * FROM board WHERE num=? AND pass=?";	// 방법2
//			String sql = "SELECT pass FROM board WHERE num=?";	// 방법1
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			pstmt.setString(2, board.getPass());
				
			rs = pstmt.executeQuery();
				
			// 방법1
//			if(rs.next()) {
//				if(rs.getString("pass").equals(board.getPass())) {	// 조회해서 나온 pass가 board 객체에 저장된 pass와 같은지 판별
//					String updateSql = "UPDATE board SET name=?,subject=?,content=? WHERE num=?";
//						
//					pstmt2 = con.prepareStatement(updateSql);
//					pstmt2.setString(1, board.getName());
//					pstmt2.setString(2, board.getSubject());
//					pstmt2.setString(3, board.getContent());
//					pstmt2.setInt(4, board.getNum());
//					
//					updateCount = pstmt2.executeUpdate();
//				}
//			}
				
			// 방법2
			if(rs.next()) {  // rs.next()가 true이면 pass가 일치한다는 것
				
				// 데이터 수정 작업
				String updateSql = "UPDATE board SET name=?,subject=?,content=? WHERE num=?";
				
				pstmt2 = con.prepareStatement(updateSql);
				pstmt2.setString(1, board.getName());
				pstmt2.setString(2, board.getSubject());
				pstmt2.setString(3, board.getContent());
				pstmt2.setInt(4, board.getNum());
					
				updateCount = pstmt2.executeUpdate();
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - updateBoard()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(pstmt2);
			close(con);
		}
			
		return updateCount;
	}
		
	// 글 삭제
	public int deleteBoard(int num, String pass) {
		int deleteCount = 0;
			
		try {
			con = getConnection();
				
			// 패스워드 일치 확인
			// 글번호와 패스워드가 모두 일치하는 게시물 조회
			String sql = "SELECT * FROM board WHERE num=? AND pass=?";
				
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
				
			rs = pstmt.executeQuery();
			
			// rs.next()가 true이면 패스워드가 일치한 레코드가 있으므로 삭제 작업 진행
			if(rs.next()) {
				// num에 해당하는 레코드 삭제 작업
				String deleteSql = "DELETE FROM board WHERE num=?";
				
				pstmt2 = con.prepareStatement(deleteSql);
				pstmt2.setInt(1, num);
				
				deleteCount = pstmt2.executeUpdate();
			}
				
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - deleteBoard()");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		return deleteCount;
	}
	
	// 최신 글 5개 조회
	public ArrayList<BoardBean> selectRecentBoardList() {
		ArrayList<BoardBean> boardList = null;
		
		try {
			con = getConnection();
			
			// num 기준으로 5개만 내림차순으로 정렬
			// 최근 5개의 게시물 = LIMIT 5 적용
			String sql = "SELECT * FROM board ORDER BY num DESC LIMIT 0,5";
//			String sql = "SELECT * FROM board ORDER BY num DESC LIMIT ?";
			pstmt = con.prepareStatement(sql);
//			pstmt.setInt(1, 5);
			
			rs = pstmt.executeQuery();
			
			// 전체 레코드 저장할 ArrayList 생성
			boardList = new ArrayList<BoardBean>();
			
			while(rs.next()) {
				// 1개 레코드 저장할 boardBean 객체 생성
				BoardBean boardBean = new BoardBean();
					
				boardBean.setNum(rs.getInt("num"));
				boardBean.setName(rs.getString("name"));
				boardBean.setPass(rs.getString("pass"));
				boardBean.setSubject(rs.getString("subject"));
				boardBean.setContent(rs.getString("content"));
				boardBean.setDate(rs.getDate("date"));
				boardBean.setReadcount(rs.getInt("readcount"));
				
				// boardList(ArrayList) 객체에 1개의 레코드가 저장된 boardBean 객체를 저장
				boardList.add(boardBean);
					
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectRecentBoardList()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return boardList;
	}
	
	// 검색기준(selectSearch)에 대한 데이터에 검색어(search)가 포함된 목록 조회 
	// 파라미터 : search, selectSearch, pageNum, listLimit
	// 리턴타입 : ArrayList<BoardBean>(searchList)
	public ArrayList<BoardBean> selectSearchBoardList(String search, String selectSearch, int pageNum, int listLimit) {
		ArrayList<BoardBean> searchList = null;
		
		try {
			// 1,2단계 : DB연결
			con = getConnection();
			
			// 시작페이지 계산
			int startRow = (pageNum - 1) * listLimit;
			
			// 3단계 : SQL 구문 작성 후 전달
			// search가 포함된 selectSearch(subject or name or content) 조회
			// num을 기준으로 startRow부터 listLimit 만큼 조회
			String sql = "SELECT * FROM board WHERE " + selectSearch + " LIKE ? ORDER BY num DESC LIMIT ?,?";
			// sql 구문을 작성할 때 외부 데이터를 그대로 넣게 되면 sql injection attack의 대상이 됨 
			// ?를 써야하는 것들은 ''이 들어가는 것들!!
			// 컬럼명은 ''가 들어가지 않으므로 연결연산자(+)를 사용해야함
			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, selectSearch);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			
			// 4단계 : SQL 구문 실행
			rs = pstmt.executeQuery();
			
			searchList = new ArrayList<BoardBean>();
			
			while(rs.next()) {
				
				BoardBean boardBean = new BoardBean();
				boardBean.setNum(rs.getInt("num"));
				boardBean.setName(rs.getString("name"));
				boardBean.setPass(rs.getString("pass"));
				boardBean.setSubject(rs.getString("subject"));
				boardBean.setContent(rs.getString("content"));
				boardBean.setDate(rs.getDate("date"));
				boardBean.setReadcount(rs.getInt("readcount"));
				
				searchList.add(boardBean);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - searchBoardList()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		
		return searchList;
	}
	
	// 검색기준(selectSearch)에 대한 데이터에 검색어(search)가 포함된 게시물의 갯수 조회
	// 파라미터 : search, selectSearch, pageNum, listLimit / 리턴타입 : ArrayList<BoardBean> (searchList)
	public int selectSearchListCount(String search, String selectSearch) {
		int searchListCount = 0;
		
		try {
			con = getConnection();
			
			// sql 구문을 작성할 때 외부 데이터를 그대로 넣게 되면 sql injection attack의 대상이 됨 
			// ?를 써라!
			String sql = "SELECT COUNT(num) FROM board WHERE " + selectSearch + " LIKE ?"; 
			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, selectSearch);
			pstmt.setString(1, "%" + search + "%");
			
			rs = pstmt.executeQuery();
//			System.out.println(rs.next());
			if(rs.next()) {
//				 조회된 결과값의 첫번째 값을 저장
				searchListCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectSearchListCount()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return searchListCount;
	}
}
