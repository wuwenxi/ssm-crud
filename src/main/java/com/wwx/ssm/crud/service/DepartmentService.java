package com.wwx.ssm.crud.service;

import com.wwx.ssm.crud.bean.Department;
import com.wwx.ssm.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper mapper;

    public List<Department> getAllDept() {
        return mapper.selectByExample(null);
    }
}
