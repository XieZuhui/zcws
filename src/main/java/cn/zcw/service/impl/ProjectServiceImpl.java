package cn.zcw.service.impl;

import cn.zcw.bean.*;
import cn.zcw.mapper.*;
import cn.zcw.service.ProjectService;
import cn.zcw.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.servlet.http.HttpSession;

import java.util.List;
import java.util.Map;

@Service
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private TypeMapper typeMapper;
    @Autowired
    private TagMapper tagMapper;
    @Autowired
    private ProjectMapper projectMapper;
    @Autowired
    private Project_typeMapper project_typeMapper;
    @Autowired
    private Project_tagMapper project_tagMapper;
    @Autowired
    private Project_memberMapper project_memberMapper;
    @Autowired
    private ReturnMapper returnMapper;

    public List<Type> getProjectTypeAll(){
        TypeExample typeExample = new TypeExample();
        List<Type> types = typeMapper.selectByExample(typeExample);
        return types;
    }

    public List<Tag> getProjectTagAll(){
        TagExample tagExample = new TagExample();
        List<Tag> tags = tagMapper.selectByExample(tagExample);
        return tags;
    }

    public String saveProject(Map<String, String> map, Integer memberid , HttpSession session){
        String str = null;
        try{
        if(map != null) {
            // 如果有新的要添加的标签 则 添加标签数据
            //添加项目数据  生成新的项目id
            int pid=addProject(map,session);
            System.out.println("PID:"+pid);
            if(pid!=0) {
                //根据添加新的项目id 添加两个中间表数据 t_project_tag、t_project_type
                int num=addProjectTagType(map,pid);
                //根据添加新的项目id 添加项目和会员 关联表数据 t_project_menber
                num += addProjectMenber(map,pid,memberid);
                if(num>=3) {
                   str = "success";
                }else {
                    str = "error";
                }
            }else {
                str = "error";
            }
        }else {
            str = "error";
        }
    }catch(Exception e) {
        e.printStackTrace();
    }
        return  str;
    }

    private int addProject(Map<String, String> map,HttpSession session) {
        String prjname = map.get("prjname");
        String remark = map.get("remark");
        String money = map.get("money");
        String day = map.get("day");
        //上传的图片地址 保存
        String iconpath = map.get("iconpath");
        String imgpath = map.get("imgpath");
        System.out.println(day);
        //TODO 保存之前 按照规则进行验证
        Double money1 = Double.parseDouble(money);//筹资金额不能低于100元,不能高于1000000000元
        int day1 = Integer.parseInt(day);//般10-90天，建议30天
        Project project = new Project(prjname, remark, money1, day1);
        project.setIconpath(iconpath);
        project.setImgpath(imgpath);
        session.setAttribute("waitProject",project);//暂时存在session中等待下一步操作
        int num = projectMapper.insertSelective(project);
        if(num>=1) {
            return project.getId();
        }
        return 0;
    }

    /**
     *获取project
     * @param map
     * @return
     */
    public Project addProjectTemp(Map<String, String> map){
        String prjname = map.get("prjname");
        String remark = map.get("remark");
        String money = map.get("money");
        String day = map.get("day");
        //上传的图片地址 保存
        String iconpath = map.get("iconpath");
        String imgpath = map.get("imgpath");
        System.out.println(day);
        //TODO 保存之前 按照规则进行验证
        Double money1 = Double.parseDouble(money);//筹资金额不能低于100元,不能高于1000000000元
        int day1 = Integer.parseInt(day);//般10-90天，建议30天
        Project project = new Project(prjname, remark, money1, day1);
        project.setIconpath(iconpath);
        project.setImgpath(imgpath);
        project.setSupporter(0);
        return project;
    }

    @Override
    public int saveProjectToDB(Project project, Project_type project_type, Project_tag project_tag, Project_member project_member, List<Return> returnList) {
        Project project1 = project;
        int num = projectMapper.insertSelective(project1);
        int flag = 0;
        if(num>=1) {

             int projectid = project1.getId();
             project_type.setProjectid(projectid);
             flag+=project_typeMapper.insertSelective(project_type);
             project_tag.setProjectid(projectid);
             flag+=project_tagMapper.insertSelective(project_tag);
             project_member.setProjectid(projectid);
             flag+=project_memberMapper.insertSelective(project_member);
             for(Return ret : returnList){
                 ret.setProjectid(projectid);
             }
             System.out.println("returnList.size-----------"+returnList.size());
             flag+=returnMapper.insertBatch(returnList);
        }
        return flag;
    }

    @Override
    public PageBean<Project> selectProjects(Integer type, String status, Integer orderby,
                                            Integer pageno, Integer pageSize,String querytext) {
        Integer selectPageno = (pageno-1)*pageSize;
        ProjectExample projectExample = new ProjectExample();
        ProjectExample.Criteria criteria = projectExample.createCriteria();
        PageBean<Project> pb =new PageBean<>();
        pb.setPageno(pageno);
        pb.setPagesize(pageSize);
        if(type!=null){
            projectExample.setTypeid(type);
        }
        if(status!=null&&status!=""){
            criteria.andStatusEqualTo(status);
        }
        if(querytext!=null&&querytext!=""){
            criteria.andNameEqualTo(querytext);
        }
        //1表示按发布日期排序，2支持金额，3支持人数
        if(orderby!=null){
        if(orderby==1){
            projectExample.setOrderByClause("deploydate DESC");
        }
        if(orderby==2){
            projectExample.setOrderByClause("supportmoney DESC");
        }
        if(orderby==3){
            projectExample.setOrderByClause("supporter DESC");
        }
        }
        projectExample.setLeftLimit(selectPageno);
        projectExample.setLimitSize(pageSize);
        pb.setTotalsize(projectMapper.selectByTypeCount(projectExample));
        List<Project>  projects=projectMapper.selectByType(projectExample);
        pb.setDatas(projects);
        System.out.println(projects.toString());
        return pb;
    }

    @Override
    public Project findProjectById(Integer id) {
        Project project = projectMapper.selectByPrimaryKey(id);
        return project;
    }

    @Override
    public List<Return> findReturn(Integer projectid) {
        ReturnExample returnExample = new ReturnExample();
        returnExample.createCriteria().andProjectidEqualTo(projectid);
        List<Return> returnList = returnMapper.selectByExample(returnExample);
        return returnList;
    }

    @Override
    public Return findReturnByKey(Integer returnid) {
        return returnMapper.selectByPrimaryKey(returnid);
    }

    @Override
    public Project_member findProject_member(Integer projectid) {
        Project_memberExample project_memberExample = new Project_memberExample();
        project_memberExample.createCriteria().andProjectidEqualTo(projectid);
        List<Project_member> project_members = project_memberMapper.selectByExample(project_memberExample);
        return project_members.size()!=0?project_members.get(0):null;
    }

    @Override
    public List<Project> findProjectByType(Integer type) {
        ProjectExample projectExample = new ProjectExample();
        projectExample.setTypeid(type);
        projectExample.setLeftLimit(0);
        projectExample.setLimitSize(4);
        return projectMapper.selectByType(projectExample);
    }

    private int addProjectTagType(Map<String, String> map,int pid) {
        int num=0;
        //保存项目和类别 中间表信息
        String typeid = map.get("typeid");
        if(typeid!=null && !"".equals(typeid)) {
            int tid  = Integer.parseInt(typeid);
            Project_type ptv = new Project_type(pid,tid);
            num += project_typeMapper.insertSelective(ptv);
        }
        //保存项目和标签 中间表信息
        //拆分 tag的id
        String tagIds = map.get("tagIds");
        String[] ids = tagIds.split(",");
        for (int i = 0; i < ids.length; i++) {
            if(!"".equals(ids[i])) {
                int tid  = Integer.parseInt(ids[i]);
                Project_tag ptv = new  Project_tag(pid,tid);
                num += project_tagMapper.insertSelective(ptv);
            }
        }
        return num;
    }


    public Project_type addProjectTypeTemp(Map<String, String> map) {
        int num=0;
        //保存项目和类别 中间表信息
        String typeid = map.get("typeid");
        Project_type ptv = new Project_type();
        if(typeid!=null && !"".equals(typeid)) {
            int tid  = Integer.parseInt(typeid);

            ptv.setTypeid(tid);
            //num += project_typeMapper.insertSelective(ptv);
        }
        if(ptv.getTypeid()==0){
            return null;
        }
        return ptv;
    }
    public Project_tag addProjectTagTemp(Map<String, String> map) {
        //保存项目和标签 中间表信息
        //拆分 tag的id
        String tagIds = map.get("tagIds");
        String[] ids = tagIds.split(",");
        Project_tag ptv = new  Project_tag();
        for (int i = 0; i < ids.length; i++) {
            if(!"".equals(ids[i])) {
                int tid  = Integer.parseInt(ids[i]);

                ptv.setTagid(tid);
                //num += project_tagMapper.insertSelective(ptv);
            }
        }
        if(ptv.getTagid()==0){
            return null;
        }
        return ptv;
    }

    /**
     * 根据添加新的项目id 添加项目和会员 关联表数据
     * @param
     * @return
     */
    private int addProjectMenber(Map<String, String> map,int projectid,int memberid) {
        String introduce = map.get("introduce");
        String particulars = map.get("particulars");
        String contactTel = map.get("contactTel");
        String customerTel = map.get("customerTel");
        //int memberid = 1;//TODO 从session中保存的用户对象中获取用户id
        Project_member pm = new Project_member(projectid, memberid, introduce, particulars, contactTel, customerTel);
        return project_memberMapper.insertSelective(pm);
    }

    public Project_member addProjectMenberTemp(Map<String, String> map,int memberid) {
        String introduce = map.get("introduce");
        String particulars = map.get("particulars");
        String contactTel = map.get("contactTel");
        String customerTel = map.get("customerTel");
        //int memberid = 1;//TODO 从session中保存的用户对象中获取用户id
        Project_member pm = new Project_member( memberid, introduce, particulars, contactTel, customerTel);
        return pm;
    }
}
