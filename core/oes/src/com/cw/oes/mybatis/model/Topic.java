package com.cw.oes.mybatis.model;

public class Topic extends Model{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String uuid;

    private String content;

    private String type;

    private String answer;

    private String opn1;

    private String opn2;

    private String opn3;

    private String opn4;

    private String opn5;

    private String opn6;

    private String opn7;

    private String isCorrect;

    private String difficulty;

    private String createTime;

    private String editTime;

    public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}


    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer == null ? null : answer.trim();
    }

    public String getOpn1() {
        return opn1;
    }

    public void setOpn1(String opn1) {
        this.opn1 = opn1 == null ? null : opn1.trim();
    }

    public String getOpn2() {
        return opn2;
    }

    public void setOpn2(String opn2) {
        this.opn2 = opn2 == null ? null : opn2.trim();
    }

    public String getOpn3() {
        return opn3;
    }

    public void setOpn3(String opn3) {
        this.opn3 = opn3 == null ? null : opn3.trim();
    }

    public String getOpn4() {
        return opn4;
    }

    public void setOpn4(String opn4) {
        this.opn4 = opn4 == null ? null : opn4.trim();
    }

    public String getOpn5() {
        return opn5;
    }

    public void setOpn5(String opn5) {
        this.opn5 = opn5 == null ? null : opn5.trim();
    }

    public String getOpn6() {
        return opn6;
    }

    public void setOpn6(String opn6) {
        this.opn6 = opn6 == null ? null : opn6.trim();
    }

    public String getOpn7() {
        return opn7;
    }

    public void setOpn7(String opn7) {
        this.opn7 = opn7 == null ? null : opn7.trim();
    }

    public String getIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(String isCorrect) {
        this.isCorrect = isCorrect == null ? null : isCorrect.trim();
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty == null ? null : difficulty.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime == null ? null : editTime.trim();
    }
}