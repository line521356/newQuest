package cn.kepu.questionnaire.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.TransactionManagementConfigurer;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.io.IOException;


@Configuration
@MapperScan(basePackages="cn.kepu.questionnaire.dao")
public class MyBatisConfig implements TransactionManagementConfigurer{

	private static String MYBATIS_CONFIG = "mybatis-config.xml";
	
	@Resource
	DataSource dataSource;
	
	@Resource
	Environment env;
	
	
	@Bean(name="sqlSessionFactoryBean")
	public SqlSessionFactoryBean createSqlSessionFactoryBean() throws IOException {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		/** 设置mybatis configuration 扫描路径 */                
        sqlSessionFactoryBean.setConfigLocation(new ClassPathResource(MYBATIS_CONFIG));
        /** 设置typeAlias 包扫描路径 */
		sqlSessionFactoryBean.setTypeAliasesPackage(env.getProperty("mybatis.typeAliasesPackage"));
		/** 添加mapper 扫描路径 */ 
		sqlSessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources(env.getProperty("mybatis.mapperLocations")));
		/** 设置datasource */
		sqlSessionFactoryBean.setDataSource(dataSource);
		return sqlSessionFactoryBean;
	}
	
	@Bean
	public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
		return new SqlSessionTemplate(sqlSessionFactory);
	}
	
	@Override
	@Bean
	public PlatformTransactionManager annotationDrivenTransactionManager() {
		return new DataSourceTransactionManager(dataSource);
	}


}
