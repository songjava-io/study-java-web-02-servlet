package example.dao;

import java.sql.SQLException;

import example.domain.User;
import example.ibatis.BaseSqlMapConfig;

/**
 * 회원 Dao
 * @author youtube
 *
 */
public class UserDao {

	/**
	 * 회원 조회
	 * @param user
	 * @return
	 * @throws SQLException
	 */
	public User selectUser(User user) throws SQLException  {
		return (User) BaseSqlMapConfig.getInstance()
			.queryForObject("selectUser", user);
	}
	
}
