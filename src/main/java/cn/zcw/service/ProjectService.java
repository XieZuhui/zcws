package cn.zcw.service;



import cn.zcw.bean.*;
import cn.zcw.util.PageBean;

import javax.servlet.http.HttpSession;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public interface ProjectService {

    List<Type> getProjectTypeAll();

    List<Tag> getProjectTagAll();

    String saveProject(Map<String, String> map, Integer memberid, HttpSession session);
    Project_type addProjectTypeTemp(Map<String, String> map);
    Project_tag addProjectTagTemp(Map<String, String> map);
    Project_member addProjectMenberTemp(Map<String, String> map, int memberid);
    Project addProjectTemp(Map<String, String> map);

    int saveProjectToDB(Project project, Project_type project_type, Project_tag project_tag, Project_member project_member,  List<Return> returnList);

    PageBean<Project> selectProjects(Integer type, String status, Integer orderby,
                                     Integer pageno, Integer pageSize,String querytext);

    Project findProjectById(Integer id);

    List<Return> findReturn(Integer projectid);

    Return findReturnByKey(Integer returnid);

    Project_member findProject_member(Integer projectid);

    List<Project> findProjectByType(Integer type);
}
