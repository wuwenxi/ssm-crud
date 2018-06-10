package test;

import com.wwx.ssm.crud.bean.Employee;
import com.wwx.ssm.crud.dao.DepartmentMapper;
import com.wwx.ssm.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Random;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class springTest {

    private static final String[] GENDER = new String[]{"M","W"};

    @Autowired
    DepartmentMapper mapper1;

    @Autowired
    EmployeeMapper mapper2;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void test01(){
        //mapper.insertSelective(new Department(null,"后勤部"));
        /**
         * 只执行一次sql添加
         * */
        //mapper2.insertSelective(new Employee(null,"jack","M","jack@wwx.com",2));

        //批量执行sqlSession

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=1;i<=1000;i++){
            String name = UUID.randomUUID().toString().substring(0,5);
            mapper.insertSelective(new Employee(i,name,
                    GENDER[new Random().nextInt(2)],name + "@wwx.com",
                    new Random().nextInt(3)+1));
        }

        System.out.println("批量完成");
    }

    @Test
    public void test02(){
        //批量删除
     /*   EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=1003;i<2001;i++){
            mapper.deleteByPrimaryKey(i);
        }*/
     mapper2.deleteByPrimaryKey(3002);
    }
}
