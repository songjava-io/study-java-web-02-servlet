package example.service;

import java.sql.SQLException;
import java.util.List;

import example.dao.BoardDao;
import example.domain.Board;

public class BoardService {

	private BoardDao boardDao = new BoardDao();
	
	public List<Board> selectBoardList() throws SQLException {
		return boardDao.selectBoardList();
	}
	
}
