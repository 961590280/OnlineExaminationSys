package com.cw.oes.mybatis.dao;

import com.cw.oes.mybatis.model.Topic;

public interface TopicMapper {
    int insert(Topic record);
    int insertSelective(Topic record);
    int isExistedById(String uuid);
}