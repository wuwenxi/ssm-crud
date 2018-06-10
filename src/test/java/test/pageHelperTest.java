package test;


import com.github.pagehelper.PageInfo;
import com.wwx.ssm.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml",
        "classpath:dispatcherServlet.xml" })
public class pageHelperTest {

    //获取IOC
    @Autowired
    WebApplicationContext context;
    //得到虚拟mvc
    MockMvc mockMvc;

    @Before
    public void init(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void test01() throws Exception{

        //模拟请求  得到返回值
        MvcResult result = mockMvc.perform(
                MockMvcRequestBuilders.get("/emp").param("pn","5")).andReturn();

        //请求成功以后，请求域中会有pageInfo；我们可以取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo info = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码:"+info.getPageNum());
        System.out.println("总页码"+info.getPages());
        //获取分页信息
        int[] num = info.getNavigatepageNums();
        for (int i:num){
            System.out.println(" "+i);
        }
        //获取员工信息
        List<Employee> employees = info.getList();
        for (Employee emp:employees){
            System.out.println("员工名字：======> " + emp.getEmpName() + "\n员工部门：======> " + emp.getDepartment());
        }
    }

}
