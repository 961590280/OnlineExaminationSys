package com.cw.oes.mybatis.dao;

import java.util.List;

import com.cw.oes.mybatis.model.Examination;

public interface ExaminationMapper {
    int deleteByPrimaryKey(String uuid);

    int insert(Examination record);

    int insertSelective(Examination record);

    Examination selectByPrimaryKey(String uuid);

    int updateByPrimaryKeySelective(Examination record);

    int updateByPrimaryKey(Examination record);
    
    List<Examination> selectExams();
    
    List<Examination> selectExamsPernal();
    
    List<String> selectExamsNameByKey(String key);
    
    List<Examination> selectExamsInfoByKey(String key);
    
}