package cn.zcw.bean;

public class Project_tag {

    private Integer id;

    private Integer projectid;

    private Integer tagid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProjectid() {
        return projectid;
    }

    public void setProjectid(Integer projectid) {
        this.projectid = projectid;
    }

    public Integer getTagid() {
        return tagid;
    }

    public void setTagid(Integer tagid) {
        this.tagid = tagid;
    }

    public Project_tag() {
    }

    public Project_tag(Integer projectid, Integer tagid) {
        this.projectid = projectid;
        this.tagid = tagid;
    }

    @Override
    public String toString() {
        return "Project_tag{" +
                "id=" + id +
                ", projectid=" + projectid +
                ", tagid=" + tagid +
                '}';
    }
}