package com.wwx.ssm.crud.controller;


import com.wwx.ssm.crud.bean.Department;
import com.wwx.ssm.crud.bean.Msg;
import com.wwx.ssm.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    DepartmentService service;


    //请求方式为post
    @RequestMapping(value = "/dept")
    @ResponseBody
    public Msg getDept(){

        List<Department> dept = service.getAllDept();

        return Msg.success().add("dept",dept);
    }
}
