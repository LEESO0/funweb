package study;

/*
CREATE TABLE study_board (
	num INT PRIMARY KEY, 
	id VARCHAR(16) NOT NULL,
	subject VARCHAR(50) NOT NULL,
	introduction VARCHAR(200) NOT NULL,
	contactType VARCHAR(10) NOT NULL,
	studyType VARCHAR(15) NOT NULL,
    space VARCHAR(15) NOT NULL,
	week VARCHAR(10) NOT NULL,
    times INT NOT NULL,
    likeCount INT NOT NULL
);
*/
public class StudyBean {
	private int num;	// 글번호
	private String id;		// 작성자이름(아이디)
	private String subject;		// 글제목
	private String introduction;		// 소개
	private String contactType;		// 온/오프
	private String studyType;		// 분야
	private String space;		// 지역
	private String week;		// 요일
	private int times;		//스터디 횟수
	private int likeCount;		// 좋아요 수
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getContactType() {
		return contactType;
	}
	public void setContactType(String contactType) {
		this.contactType = contactType;
	}
	public String getStudyType() {
		return studyType;
	}
	public void setStudyType(String studyType) {
		this.studyType = studyType;
	}
	public String getSpace() {
		return space;
	}
	public void setSpace(String space) {
		this.space = space;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public int getTimes() {
		return times;
	}
	public void setTimes(int times) {
		this.times = times;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
}
