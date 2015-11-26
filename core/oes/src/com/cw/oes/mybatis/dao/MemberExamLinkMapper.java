package com.cw.oes.mybatis.dao;

import java.util.List;
import java.util.Map;

import com.cw.oes.mybatis.model.Member;
import com.cw.oes.mybatis.model.MemberExamLinkKey;

public interface MemberExamLinkMapper {
    int deleteByPrimaryKey(MemberExamLinkKey key);
    int insert(MemberExamLinkKey record);
    int beginExam(MemberExamLinkKey record);
    int commitAnswer(MemberExamLinkKey record);
    int insertSelective(MemberExamLinkKey record);
    List<MemberExamLinkKey> selectByMemberId(String memberId);
    List<MemberExamLinkKey> personalExamRecords(Map<String,Object> map);
    List<MemberExamLinkKey> selectByExamId(String examId);
    MemberExamLinkKey selectByMemberIdExamIdCreateTime(MemberExamLinkKey record);
    
}