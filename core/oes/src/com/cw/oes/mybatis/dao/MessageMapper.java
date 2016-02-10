package com.cw.oes.mybatis.dao;

import java.util.List;
import java.util.Map;

import com.cw.oes.mybatis.model.Message;

public interface MessageMapper {
    int deleteByPrimaryKey(String uuid);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectByPrimaryKey(String uuid);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);
    
    List<Message> getNewMessage(Map select);
}