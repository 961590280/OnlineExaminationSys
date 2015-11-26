<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="cutImgPanle" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" style="width: 800px;min-height: 300px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">图片裁剪</h4>
      </div>
      <div class="modal-body">
        
        <div class="img-body">
        	<div class="row">
        		<div class="col-md-8 crop-img" id="crop-img" >
	        	
	        	</div>
	        	<div class="col-md-4" >
	        		<div class="row">
	        		<div id="preView-img"></div>
	        		</div>
	        		<div class="row">
	        		<p class="crop-tips">
	        		<span class="glyphicon glyphicon-question-sign crop-tips-sign"></span>
	        		<br/>
	        		1.双击图片可以在 <span class="text-danger">拖放</span>/<span  class="text-primary">裁剪</span> 间切换。
	        		<br/>
	        		2.滚动鼠标滚轮可以 <span class="text-danger">放大</span>/<span  class="text-primary">缩小</span> 图片
	        		</p>
	        		
	        		</div>
	        	
	        	</div>
	        </div>
        </div>
      </div>
      <div id="topic-footer" class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button id="save" type="button" class="btn btn-primary">确定</button>
      </div>
    </div>
  </div>
</div>