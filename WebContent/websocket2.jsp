<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
   <title>Error Message</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
  <div class="alert alert-warning" id="msgdiv">
	<a href="#" class="close" data-dismiss="alert">
		&times;
	</a>
	<strong>warning！</strong>Bureau Error
	<a  class="alert-link" data-toggle="modal" data-target="#myModal">details</a>
</div>
</body>

<script type="text/javascript">
$("#msgdiv").hide();
    var websocket = null;
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8080/Demo/websocket");
    }
    else {
        alert('当前浏览器 Not support websocket')
    }

    //连接发生错误的回调方法
    websocket.onerror = function () {
        setMessageInnerHTML("WebSocket连接发生错误");
    };

   

    //接收到消息的回调方法
    websocket.onmessage = function (event) {
        setMessageInnerHTML(event.data);
    }

    //连接关闭的回调方法
    websocket.onclose = function () {
        setMessageInnerHTML("WebSocket连接关闭");
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        closeWebSocket();
    }

    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML) {
    	console.log("msg=="+innerHTML);
    	$("#msgdiv").show();

    }

    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();
    }

    //发送消息
    function send() {
        var message = document.getElementById('text').value;
        websocket.send(message);
    }
</script>




<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Error Message</h4>
            </div>
            <div class="modal-body">
            
            <table class="table table-condensed table-striped">
  <thead>
    <tr>
      <th>Error Code</th>
      <th>Count</th>
      <th>Action</th></tr>
  </thead>
  <tbody>
      <tr>
	      <td>Bureau Error</td>
	      <td>8</td>
	      <td><button type="button" class="btn btn-success">Create INC</button></td>
      </tr>
       <tr>
	      <td>Bureau Error</td>
	      <td>8</td>
	      <td><button type="button" class="btn btn-success">Create INC</button></td>
      </tr>
       <tr>
	      <td>Bureau Error</td>
	      <td>8</td>
	      <td><button type="button" class="btn btn-success">Create INC</button></td>
      </tr>
   
  </tbody>
</table>
            
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</html>