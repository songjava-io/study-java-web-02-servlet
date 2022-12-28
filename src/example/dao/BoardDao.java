package example.dao;

import java.sql.SQLException;
import java.util.List;

import example.domain.Board;
import example.ibatis.BaseSqlMapConfig;



/**
 * 게시판 Dao
 * @author youtube
 *
 */
public class BoardDao {

	/**
	 * 게시물 목록 조회 리턴
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<Board> selectBoardList() throws SQLException {
		return BaseSqlMapConfig.getInstance().queryForList("selectBoardList");
	}
	
}
