package cn.zcw.controller;


import cn.zcw.bean.*;
import cn.zcw.service.ProjectService;

import cn.zcw.util.PageBean;
import cn.zcw.util.UploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Project")
public class ProjectController {

    @Autowired
    private ProjectService projectService;


    /**
     * 加载项目类别初始数据
     * @return
     */
    @ResponseBody
    @RequestMapping("/loadTypeData.do")
    public List loadProjectTypeData(Model model) {
        List<Type> types = projectService.getProjectTypeAll();
        //System.out.println(types);
        System.out.println("/loadTypeData.do");
        //model.addAttribute("types",types);
        return types;
    }

    @RequestMapping("/selectTypes.do")
    public String selectTypes(HttpServletRequest request) {
        List<Type> types = projectService.getProjectTypeAll();
        //System.out.println(types);
        System.out.println("/loadTypeData.do");
      request.getSession().setAttribute("types",types);
        return "/Project/selectProjects.do?pageno=1&pageSize=12";
    }

    @ResponseBody
    @RequestMapping("/loadTagData.do")
    public List loadProjectTagData(){
        List<Tag> tags = projectService.getProjectTagAll();
        return tags;
    }

    @ResponseBody
    @RequestMapping("/savaProject.do")
    public Object saveProject(HttpServletRequest request){
        System.out.println("/savaProject.do");
        HttpSession session = request.getSession();
        AJAXResult result = new AJAXResult();
        Map<String, String> map = UploadUtil.upload2(request);
        Member member = (Member)session.getAttribute("loginedUser");
        String flag = projectService.saveProject(map,member.getId(),session);
        if(flag == "success"){
            result.setSuccess(true);
        }else {result.setSuccess(false);}
        return result;
    }

    @ResponseBody
    @RequestMapping("/savaProjectTemp.do")
    public Object saveProjectTemp(HttpServletRequest request){
        System.out.println("/savaProjectTemp.do");
        HttpSession session = request.getSession();
        AJAXResult result = new AJAXResult();
        Map<String, String> map = UploadUtil.upload2(request);
        Member member = (Member)session.getAttribute("loginedUser");
        Project project = projectService.addProjectTemp(map);
        Project_type project_type = projectService.addProjectTypeTemp(map);
        Project_tag project_tag = projectService.addProjectTagTemp(map);
        Project_member project_member = projectService.addProjectMenberTemp(map,member.getId());
       session.setAttribute("waitProject",project);
       session.setAttribute("waitProject_type",project_type);
       session.setAttribute("waitProject_tag",project_tag);
       session.setAttribute("waitProject_member",project_member);
        result.setSuccess(true);
        return result;
    }

    @RequestMapping("/saveReturnTemp.do")
    public String saveReturnTemp(ReturnDatas datas,HttpServletRequest request){
        //System.out.println(datas.getDatas().size());
        List<Return> returnList = datas.getDatas();
        for(Return ret : returnList){
            if(ret.getContent()==null){
                returnList.remove(ret);
            }
        }
        HttpSession session = request.getSession();
        session.setAttribute("waitReturns",returnList);
        return "redirect:/member/start-step-3.jsp";
    }

    /**
     * 将session中保存的项目数据存储到数据库中
     * @param request
     * @return
     */
    @RequestMapping("/saveProjectToDB.do")
    public String saveProjectToDB(HttpServletRequest request){
        HttpSession session = request.getSession();
        Project project = (Project) session.getAttribute("waitProject");
        Project_tag project_tag = (Project_tag) session.getAttribute("waitProject_tag");
        Project_type project_type = (Project_type) session.getAttribute("waitProject_type");
        Project_member project_member = (Project_member) session.getAttribute("waitProject_member");
        List<Return> returnIterator = ( List<Return>) session.getAttribute("waitReturns");
        int flag = projectService.saveProjectToDB(project,project_type,project_tag,project_member,returnIterator);
        if(flag >= 4){
        return "redirect:/";}else{
            return "/error.jsp";
        }
    }

    @RequestMapping("/selectProjects.do")
    public String selectProjects(Model model,Integer type,String status, Integer orderby,Integer pageno, Integer pageSize,String querytext){
        PageBean<Project> pb = new PageBean<>();
        pb = projectService.selectProjects(type,status,orderby,pageno,pageSize,querytext);
        model.addAttribute("pb",pb);
        return "/member/projects.jsp";
    }

    /**
     * ajax方法取得project
     * @param model
     * @param type
     * @param status
     * @param orderby
     * @param pageno
     * @param pageSize
     * @param querytext
     * @return
     */
    @ResponseBody
    @RequestMapping("/findProjects.do")
    public Object findProjects(Model model,Integer type,String status, Integer orderby,Integer pageno, Integer pageSize,String querytext){
        AJAXResult result = new AJAXResult();
        PageBean<Project> pb = new PageBean<>();

        pb = projectService.selectProjects(type,status,orderby,pageno,pageSize,querytext);
        if(pb.getDatas().size()!=0){
            result.setSuccess(true);
            result.setPageBean(pb);
            return result;
        }
        model.addAttribute("pb",pb);
        result.setSuccess(false);
        return result;
    }

    @RequestMapping("/findProjectById.do")
    public String findProjectById(Integer id,Model model){
        Project project = projectService.findProjectById(id);
        model.addAttribute("project",project);
        List<Return> returnList = projectService.findReturn(id);
        model.addAttribute("Returns",returnList);
        return "/member/project.jsp";
    }

    @RequestMapping("/findReturn.do")
    public String findReturn(Integer returnid,Integer projectid,Model model){
        Return ret = projectService.findReturnByKey(returnid);
        model.addAttribute("ret",ret);
        Project project = projectService.findProjectById(projectid);
        model.addAttribute("project",project);
        Project_member project_member = projectService.findProject_member(projectid);
        model.addAttribute("p_member",project_member);
        return "/member/pay-step-1.jsp";
    }

    @ResponseBody
    @RequestMapping("/findProjectByType.do")
    public Object findProjectByType(Integer type){
        AJAXResult<Project> result = new AJAXResult<>();
        List<Project> projects = projectService.findProjectByType(type);
        if(!projects.isEmpty()){
            result.setSuccess(true);
            result.setDatas(projects);
            return result;
        }
        result.setSuccess(false);
        return result;
    }
}
