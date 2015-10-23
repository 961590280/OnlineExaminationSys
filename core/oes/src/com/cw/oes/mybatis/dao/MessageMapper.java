package com.cw.oes.mybatis.dao;

import com.cw.oes.mybatis.model.Message;

public interface MessageMapper {
    int deleteByPrimaryKey(String uuid);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectByPrimaryKey(String uuid);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);
}