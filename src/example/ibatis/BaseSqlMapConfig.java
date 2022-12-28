package example.ibatis;

import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class BaseSqlMapConfig {

	private static final SqlMapClient SQL_MAP_CLIENT;
	
	static {
		System.out.println("BaseSqlMapConfig 설정 시작");
		try {
			// sql 설정 파일 경로를 가져옴
			String resource = "./config/ibatis/sql-map-config.xml";
			// resoruce 경로의 xml을 Reader 가져옴
			Reader reader = Resources.getResourceAsReader(resource);
			SQL_MAP_CLIENT = SqlMapClientBuilder.buildSqlMapClient(reader);
			System.out.println("SQL_MAP_CLIENT : " + SQL_MAP_CLIENT);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("ibatis config error");
		}
	}
	
	public static SqlMapClient getInstance() {
		return SQL_MAP_CLIENT;
	}
	
}
