package com.wwx.ssm.crud.service;

import com.wwx.ssm.crud.bean.Employee;
import com.wwx.ssm.crud.bean.EmployeeExample;
import com.wwx.ssm.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.Valid;
import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper mapper;

    public List<Employee> getAllEmp() {
        return mapper.selectWithDept();
    }

    public void saveEmp(Employee employee) {
        mapper.insertSelective(employee);
    }


    public boolean checkUser(String empName) {
        //查出所有员工信息
        // TODO Auto-generated method stub
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = mapper.countByExample(example);
        return count == 0;
    }

    public Employee getEmp(int id) {
        return mapper.selectByPrimaryKey(id);
    }

    public void updateEmp(Employee employee) {
        mapper.updateByPrimaryKeySelective(employee);
    }
}
