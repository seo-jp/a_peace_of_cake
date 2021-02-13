<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/order.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<c:if test="${result == 0 }">
		<script>alert("同じ商品名があります!材料名を変更してください。");</script>
	</c:if>
	<c:if test="${result == 1 }">
		<script>alert("保存しました。");</script>
	</c:if>
	
	<div class="view_form">
		<c:choose>
			<c:when test="${mode == 'insert' }">
				<form action="ingredientInsert.do" method="post" enctype="multipart/form-data">
			</c:when>
			<c:when test="${mode == 'update' }">
				<form action="ingredientUpdate.do" method="post" enctype="multipart/form-data">
			</c:when>
		</c:choose>
			<table>
				<tr class="hidden_box">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex}"/>
					<input type="hidden" name="sort" id="sort" value="${sort}"/>
				</tr>
				
				<c:if test="${mode == 'update' }">
					<tr>
					<th><label for="">元の写真</label></th>
					<td colspan="2">
						<img
						src="${pageContext.request.contextPath}/resources/images/ingredient/${dto.i_img}"
						alt="${dto.i_name}" />
						<input type="hidden" name="i_img" id="i_img" value="${dto.i_img}"/>
						<input type="hidden" name="i_id" id="i_id" value="${dto.i_id}"/>
					</td>
					</tr>
				</c:if>
				
				<tr>	
					<th><label for="file">写真</label></th>
					<td>
						<input type="file" name="file" id="file" accept="images/*;capture=camera" onchange="setThumb(event)" />
					</td>
					<td class="uploadView">
						<a onClick="deleteFile()">削除</a>
					</td>
				</tr>
				<tr>
					<th><label for="i_name">材料名</label></th>
					<td colspan="2"><input type="text" name="i_name" id="i_name" maxlength="100" value="${dto.i_name}"/></td>
				</tr>
				<tr>
					<th><label for="i_price">価格</label></th>
					<td colspan="2">￥<input type="number" name="i_price" id="i_price" min="1" max="1000000" value="${dto.i_price}" /></td>
				</tr>
				<tr>
						<th>状態</th>
						<td colspan="2">
							<label for="i_state1">発注可能</label>
							<input type="radio" name="i_state"
								id="i_state1" value="0" <c:if test="${dto.i_state eq '0'.charAt(0) || mode == 'insert'}">checked</c:if> />
							<label for="i_state2">発注不可</label>
							<input type="radio" name="i_state"
								id="i_state2" value="1" <c:if test="${dto.i_state eq '1'.charAt(0) }">checked</c:if>  />
						</td>
					</tr>
				<tr>
					<th><label for="i_exipdate">賞味期限</label></th>
					<td colspan="2"><input type="number" name="i_exipdate" id="i_exipdate" min="1" max="5000" value="${dto.i_exipdate}"/>日</td>
				</tr>
			</table>
			<div class="form_btn_box">
				<a onClick="goList()">一覧</a>
				<input type="submit" value="登録" />
			</div>
		</form>
	</div>
	
	
	<script>
		// Input Check
		
	
		// Basic Setting
		document.querySelector(".uploadView a").style.visibility = 'hidden'; 

		// Thumbnail Setting
		let setThumb = function(event) {
			document.querySelector(".uploadView a").style.visibility = 'visible'; 
			let reader = new FileReader();
			reader.onload = function(event) {
				let img = document.createElement("img");
				img.setAttribute("src",event.target.result);
				document.querySelector(".uploadView").appendChild(img);
			};
			let imgs = document.querySelectorAll(".uploadView img");
			if(imgs.length>0) document.querySelector(".uploadView img").remove();
			reader.readAsDataURL(event.target.files[0]);
		}

		// File Delete
		let deleteFile = function() {
			document.querySelector("input[name=file]").value = "";
			document.querySelector(".uploadView img").remove();
			document.querySelector(".uploadView a").style.visibility = 'hidden'; 
		}

		// Go List
		let goList = function() {
			location.href="order.do?sort=${sort}&pageIndex=${pageIndex}";
		}
	</script>

</body>
</html>