package com.cw.oes.mybatis.dao;

import java.util.List;

import com.cw.oes.mybatis.model.Tag;
import com.cw.oes.mybatis.model.TagOtherLinkKey;

public interface TagOtherLinkMapper {
    int deleteByPrimaryKey(TagOtherLinkKey key);

    int insert(TagOtherLinkKey record);

    int insertSelective(TagOtherLinkKey record);
    
    List<Tag> getPersonalTags(String userId);
}