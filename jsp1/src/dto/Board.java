package dto;

public class Board {
		
	private int bNum;
	private String title;
	private String content;
	private String regDate;
	private String writer;
	
	public int getbNum() {
		return bNum;
	}
	
	public void setbNum(int bNum) {
		this.bNum = bNum;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getRegDate() {
		return regDate;
	}
	
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getWriter() {
		return writer;
	}
	
	public void setWriter(String writer) {
		this.writer = writer;
	}

	@Override
	public String toString() {
		return "Board [bNum=" + bNum + ", title=" + title + ", content=" + content + ", regDate=" + regDate
				+ ", writer=" + writer + "]";
	}	
	
}
