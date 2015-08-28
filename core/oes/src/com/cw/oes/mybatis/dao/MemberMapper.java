package com.cw.oes.mybatis.dao;

import com.cw.oes.mybatis.model.Member;

public interface MemberMapper {
    int deleteByPrimaryKey(String uuid);

    int insert(Member record);

    int insertSelective(Member record);

    Member selectByPrimaryKey(String uuid);
    Member selectByCode(String code);

    int updateByPrimaryKeySelective(Member record);

    int updateByPrimaryKey(Member record);
}