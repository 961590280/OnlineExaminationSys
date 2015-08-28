package com.cw.oes.mybatis.dao;

import com.cw.oes.mybatis.model.Paper;

public interface PaperMapper {
    int deleteByPrimaryKey(String uuid);

    int insert(Paper record);

    int insertSelective(Paper record);

    Paper selectByPrimaryKey(String uuid);

    int updateByPrimaryKeySelective(Paper record);

    int updateByPrimaryKey(Paper record);
}