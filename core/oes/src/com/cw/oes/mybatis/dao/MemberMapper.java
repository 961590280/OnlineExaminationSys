package com.cw.oes.mybatis.dao;

import com.cw.oes.mybatis.model.Member;

public interface MemberMapper {
    int deleteByPrimaryKey(String uuid);

    int insert(Member record);
    int register(Member record);
    int emailIsUsed(String email);
    int insertSelective(Member record);

    Member selectByPrimaryKey(String uuid);
    Member selectByEmail(String code);

    int updateByPrimaryKeySelective(Member record);

    int updateByPrimaryKey(Member record);
}