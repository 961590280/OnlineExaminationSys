package com.cw.oes.mybatis.dao;

import java.util.List;

import com.cw.oes.mybatis.model.PaperTopicLinkKey;
import com.cw.oes.mybatis.model.Topic;

public interface PaperTopicLinkMapper {
    int deleteByPrimaryKey(PaperTopicLinkKey key);

    int insert(PaperTopicLinkKey record);

    int insertSelective(PaperTopicLinkKey record);
    List<Topic> selectPaperTopic (String paperPid);
}