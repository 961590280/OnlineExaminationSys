package com.cw.oes.mybatis.dao;

import java.util.List;

import com.cw.oes.mybatis.model.Tag;

public interface TagMapper {
    int deleteByPrimaryKey(String uuid);

    int insert(Tag record);

    int insertSelective(Tag record);

    Tag selectByPrimaryKey(String uuid);
    
    List<Tag> selectByKeyword(String key);

    int updateByPrimaryKeySelective(Tag record);

    int updateByPrimaryKey(Tag record);
}