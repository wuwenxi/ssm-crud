package com.wwx.ssm.crud.controller;

import com.github.pagehelper.PageInfo;
import com.github.pagehelper.page.PageMethod;
import com.wwx.ssm.crud.bean.Employee;
import com.wwx.ssm.crud.bean.Msg;
import com.wwx.ssm.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService service;

    @RequestMapping("/emp")
    @ResponseBody
    public Msg getEmpWithJson(
            @RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //查询当前传入页面，已经每一页大小
        PageMethod.startPage(pn,5);

        List<Employee> emp = service.getAllEmp();

        PageInfo<Employee> page = new PageInfo<Employee>(emp,5);

        return Msg.success().add("pageInfo",page);
    }


    /*
    *更新员工
    * */
    @ResponseBody
    @RequestMapping(value = "/update/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        System.out.println("员工信息："+ employee);
        service.updateEmp(employee);
        return Msg.success();
    }

    /*
    *按id查找员工
    * */
    @RequestMapping(value = "/getEmp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){
        Employee employee = service.getEmp(id);
        return Msg.success().add("employee",employee);
    }


    /*
    *           进行JSR303数据校验
    * */
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ResponseBody
    public Msg SaveEmp(@Valid  Employee employee, BindingResult result){
        //校验出错
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<String, Object>();
            List<FieldError> list = result.getFieldErrors();
            for (FieldError error:list) {
                System.out.println("错误字段:"+error.getField());
                System.out.println("错误信息内容："+error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorField",map);
        }else {
            service.saveEmp(employee);
            return Msg.success();
        }
    }


    /*
    * 后端校验
    * */
    @ResponseBody
    @RequestMapping(value = "/checkUser",method = RequestMethod.POST)
    public Msg checkUser(@RequestParam("empName") String empName){
        //后端验证
        String name ="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,4})";
        if(!empName.matches(name)){
            return Msg.fail().add("msg","用户名必须为6到16为字符或2到4位的中文字符");
        }

        //进行数据库查询
        if(service.checkUser(empName)){
            return Msg.success();
        }else {
            return Msg.fail().add("msg","用户名不可用");
        }
    }

   //@RequestMapping("/emp")
    public String getEmp(@RequestParam(value = "pn",defaultValue = "1") Integer pn,
                         Model model){
        PageMethod.startPage(pn,5);

        List<Employee> emp = service.getAllEmp();

        PageInfo<Employee> info = new PageInfo<Employee>(emp,5);

        model.addAttribute("pageInfo",info);

        return "list";
    }
}
