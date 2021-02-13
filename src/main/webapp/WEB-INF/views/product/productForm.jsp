<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/product.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<c:if test="${result == 0 }">
		<script>alert("同じ商品名があります!商品名を変更してください。");</script>
	</c:if>
	<c:if test="${result == 1 }">
		<script>alert("保存しました。");</script>
	</c:if>
	
	<div class="view_form">
		<c:choose>
			<c:when test="${mode == 'insert' }">
				<form action="productInsert.do" method="post" enctype="multipart/form-data">
			</c:when>
			<c:when test="${mode == 'update' }">
				<form action="productUpdate.do" method="post" enctype="multipart/form-data">
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
						src="${pageContext.request.contextPath}/resources/images/product/${dto.p_img}"
						alt="${dto.p_name}" />
						<input type="hidden" name="p_img" id="p_img" value="${dto.p_img}"/>
						<input type="hidden" name="p_id" id="p_id" value="${dto.p_id}"/>
					</td>
					</tr>
				</c:if>
				
				<tr>	
					<th><label for="file">写真</label></th>
					<td>
						<input type="file" name="file" id="file" accept="images/*;capture=camera" onchange="setThumb(event)" />
					</td>
					<td class="uploadView">
						<a class="deleteFile" onClick="deleteFile()">削除</a>
					</td>
				</tr>
				<tr>
					<th><label for="p_name">商品名</label></th>
					<td colspan="2"><input type="text" name="p_name" id="p_name" maxlength="100" value="${dto.p_name}"/></td>
				</tr>
				<tr>
					<th><label for="p_price">価格</label></th>
					<td colspan="2">￥<input type="number" name="p_price" id="p_price" min="1" max="1000000" value="${dto.p_price}" /></td>
				</tr>
				<tr>
						<th>状態</th>
						<td colspan="2">
							<label for="p_state1">販売中</label>
							<input type="radio" name="p_state"
								id="p_state1" value="0" <c:if test="${dto.p_state eq '0'.charAt(0) || mode == 'insert'}">checked</c:if> />
							<label for="p_state2">販売中止</label>
							<input type="radio" name="p_state"
								id="p_state2" value="1" <c:if test="${dto.p_state eq '1'.charAt(0) }">checked</c:if>  />
						</td>
					</tr>
				<tr>
					<th><label for="p_memo">メモ</label></th>
					<td colspan="2"><textarea name="p_memo" id="p_memo" maxlength="200" >${dto.p_memo}</textarea></td>
				</tr>
				<tr>
					<th><label for="p_exipdate">賞味期限</label></th>
					<td colspan="2"><input type="number" name="p_exipdate" id="p_exipdate" min="1" max="5000" value="${dto.p_exipdate}"/>日</td>
				</tr>
			</table>
			<div class="form_btn_box">
				<a onClick="goList()">一覧</a>
				<input type="submit" value="登録" />
			</div>
		</form>
		
	</div>
	
	
	<script>	
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
			location.href="product.do?sort=${sort}&pageIndex=${pageIndex}";
		}
	</script>
	
</body>
</html>