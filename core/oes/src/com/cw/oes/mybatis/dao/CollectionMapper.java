package com.cw.oes.mybatis.dao;

import com.cw.oes.mybatis.model.Collection;
import com.cw.oes.mybatis.model.CollectionKey;

public interface CollectionMapper {
    int deleteByPrimaryKey(CollectionKey key);

    int insert(Collection record);

    int insertSelective(Collection record);

    Collection selectByPrimaryKey(CollectionKey key);

    int updateByPrimaryKeySelective(Collection record);

    int updateByPrimaryKey(Collection record);
}