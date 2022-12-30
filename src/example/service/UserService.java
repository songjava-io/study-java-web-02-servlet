package example.service;

import java.sql.SQLException;

import example.dao.UserDao;
import example.domain.User;

/**
 * 회원 서비스
 * @author youtube
 *
 */
public class UserService {
	
	private UserDao userDao = new UserDao();

	/**
	 * 회원 조회
	 * @param user
	 * @return
	 * @throws SQLException
	 */
	public User selectUser(User user) throws SQLException  {
		return userDao.selectUser(user);
	}
	
}
