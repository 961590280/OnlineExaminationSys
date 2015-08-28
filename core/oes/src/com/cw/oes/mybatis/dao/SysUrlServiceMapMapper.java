package com.cw.oes.mybatis.dao;

import java.util.List;

import com.cw.oes.mybatis.model.SysUrlServiceMap;

public interface SysUrlServiceMapMapper {
    int deleteByPrimaryKey(String urlFlag);

    int insert(SysUrlServiceMap record);

    int insertSelective(SysUrlServiceMap record);

    SysUrlServiceMap selectByPrimaryKey(String urlFlag);
    
    List<SysUrlServiceMap> selectAll();

    int updateByPrimaryKeySelective(SysUrlServiceMap record);

    int updateByPrimaryKey(SysUrlServiceMap record);
}