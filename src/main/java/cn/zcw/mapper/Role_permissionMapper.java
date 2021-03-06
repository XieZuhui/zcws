package cn.zcw.mapper;

import cn.zcw.bean.Role_permission;
import cn.zcw.bean.Role_permissionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface Role_permissionMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    int countByExample(Role_permissionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    int deleteByExample(Role_permissionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    int insert(Role_permission record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    int insertSelective(Role_permission record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    List<Role_permission> selectByExample(Role_permissionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    Role_permission selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") Role_permission record, @Param("example") Role_permissionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") Role_permission record, @Param("example") Role_permissionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Role_permission record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_role_permission
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Role_permission record);
}