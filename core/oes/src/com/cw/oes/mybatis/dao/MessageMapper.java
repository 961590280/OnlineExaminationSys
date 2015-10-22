package com.cw.oes.mybatis.dao;

import com.cw.oes.mybatis.model.Message;
import com.cw.oes.mybatis.model.MessageKey;

public interface MessageMapper {
    int deleteByPrimaryKey(MessageKey key);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectByPrimaryKey(MessageKey key);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);
}