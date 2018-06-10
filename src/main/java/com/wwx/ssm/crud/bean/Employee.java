package com.wwx.ssm.crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,4})",
            message = "用户名必须为6到16为字符或2到4位的中文字符")
    private String empName;

    private String empGender;

    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
            message = "邮箱格式不正确")
    private String empEmail;

    private Integer empDid;

    private Department department;

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getEmpGender() {
        return empGender;
    }

    public void setEmpGender(String empGender) {
        this.empGender = empGender == null ? null : empGender.trim();
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail == null ? null : empEmail.trim();
    }

    public Integer getEmpDid() {
        return empDid;
    }

    public void setEmpDid(Integer empDid) {
        this.empDid = empDid;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Employee() {
    }

    public Employee(Integer empId, String empName, String empGender, String empEmail, Integer empDid) {
        this.empId = empId;
        this.empName = empName;
        this.empGender = empGender;
        this.empEmail = empEmail;
        this.empDid = empDid;
    }

    public Employee(Integer empId, String empName, String empGender, String empEmail, Integer empDid, Department department) {
        this.empId = empId;
        this.empName = empName;
        this.empGender = empGender;
        this.empEmail = empEmail;
        this.empDid = empDid;
        this.department = department;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", empGender='" + empGender + '\'' +
                ", empEmail='" + empEmail + '\'' +
                ", empDid=" + empDid +
                ", department=" + department +
                '}';
    }
}