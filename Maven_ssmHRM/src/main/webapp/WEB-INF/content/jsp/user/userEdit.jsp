<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>userEdit</title>
		<link href="${dzx}/css/bootstrap.css" type="text/css"  rel="stylesheet" />
	<link href="${dzx}/css/main.css" type="text/css" rel="stylesheet" />
	</head>
	<body>
		<div style="border:#DDDDDD solid 1px;width: 100%;height: 600px;margin-top: 10px;padding: 10px;">
			<span class="glyphicon glyphicon-circle-arrow-right"></span>&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;
			当前位置：用户管理&nbsp;&gt;&nbsp;更改用户
		<hr />
		<div id="error" style="color:#FF0000;font-size:14px ;height: 20px;"></div>
		<form:form  id="userAddform" modelAttribute="editUser" method="post">
			用户名：<form:input  path="username" id="user_name" cssClass="inputCss" cssStyle="width:200px ;"   maxlength="20" ></form:input>&nbsp;&nbsp;&nbsp;&nbsp;
			状&nbsp;态：<form:select path="status" id="status" style="height: 35px;" cssClass="inputCss" >
			<form:option value="0">请选择状态</form:option>
			<form:option value="1">超级管理员</form:option>
			<form:option value="2">普通用户</form:option>
			</form:select>
			&nbsp;&nbsp;&nbsp;&nbsp;<br /><br />
			登录名：<form:input path="loginname"  id="login_name" cssClass="inputCss" cssStyle="width:200px ;"  maxlength="20"></form:input>&nbsp;&nbsp;&nbsp;&nbsp;
			密&nbsp;码：<form:input  path="password" id="pass_word" cssStyle="width:200px ;" class="inputCss" ></form:input>&nbsp;<br /><br />
			<input type="button"  value="保存" class="btn btn-success" id="btn"/>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" class="btn btn-danger" value="取消"/>
			<!--保存用户ID-->
			<form:hidden path="id"  ></form:hidden>
		</form:form>
		</div>
		<!-- 判断数据是否符合要求，提交表单的标志 -->
		<input type="hidden"  id="submitInfo" value="true"/>
	</body>
	<script src="${dzx}/js/jquery-1.12.4.js" type="application/javascript" charset="UTF-8"></script>
	<script type="text/javascript">
	/* 登录名不能重复 */
	 $("#login_name").change(function () {
		$.ajax("${dzx}/isReLoginname",// 发送请求的URL字符串。
				{
				dataType : "json", // 预期服务器返回的数据类型。
	   			type : "post", //  请求方式 POST或GET
			   contentType:"application/json", //  发送信息至服务器时的内容编码类型
			   // 发送到服务器的数据。
			   data:JSON.stringify({
				   loginname:$("#login_name").val()}),
			   async:  true , // 默认设置下，所有请求均为异步请求。如果设置为false，则发送同步请求
			   // 请求成功后的回调函数。
			   success :function(data){
				  if (data.isSuccess) {
					 $("#error").text(" ");
					$("#submitInfo").val("true");
				} else {
					$("#submitInfo").val("false");
					$("#error").text("*该登录名已经添加过，请重新输入登录名");
				}
			   },
			   // 请求出错时调用的函数
			   error:function(){
				   alert("数据发送失败");
			   }
		});
	}); 
			/*判断状态，用户名是否为空*/
			$("#btn").click(function(){
				var valu1=$("#user_name").val();
				var valu2=$("#status").val();
				var valu3=$("#login_name").val();
				var valu4=$("#pass_word").val();
				var re =/[`~!@#$%^&*_+<>{}\\/'[\]]/im;
				var regx=/^(\w){6,12}$/g;
				 if (valu1.trim().length==0) {
					$("#error").text("*请输入用户名");
				}else if (re.test(valu1.trim())) {
					$("#error").text("*用户名存在`~!@#$%^&*_+<>{}\'[]/等的非法字符");
				}else if (valu2==0) {
					$("#error").text("*请选择状态");
				}else if(valu3.trim().length==0){
					$("#error").text("*请输入登录名");
				}else if(valu4.trim().length==0){
					$("#error").text("*请输入密码");
				}else if(!regx.test(valu4.trim())){
					$("#error").text("*请输入6-12位的数字和字母密码");
				}else if ($("#submitInfo").val()=='false') {
					$("#error").text("*该登录名已经添加过，请重新输入登录名");
				}else {
					$("#userAddform").attr("action","${dzx}/saveUser");
					$("#userAddform").submit();
				}
 		 		
			});
			
		
		</script>
</html>
