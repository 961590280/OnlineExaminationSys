package com.cw.oes.mybatis.dao;

import com.cw.oes.mybatis.model.ExamNote;

public interface ExamNoteMapper {
    int deleteByPrimaryKey(String uuid);

    int insert(ExamNote record);

    int insertSelective(ExamNote record);

    ExamNote selectByPrimaryKey(String uuid);
    ExamNote getNoteByPid(ExamNote note);

    int updateByPrimaryKeySelective(ExamNote record);

    int updateByPrimaryKey(ExamNote record);
}