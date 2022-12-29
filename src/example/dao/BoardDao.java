package example.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

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
	public List<Board> selectBoardList(Map<String, Object> paramMap) 
			throws SQLException {
		return BaseSqlMapConfig.getInstance().
			queryForList("selectBoardList", paramMap);
	}

	/**
	 * 게시물 조회
	 * @param boardSeq
	 * @return
	 * @throws SQLException
	 */
	public Board selectBoard(String boardSeq) throws SQLException  {
		return (Board) BaseSqlMapConfig.getInstance()
			.queryForObject("selectBoard", boardSeq);
	}
	
}
