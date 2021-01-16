<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/product.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	
	<div class="add_list_wrap">
			<table class="add_list">
				<tr>
					<th>NO</th>
					<th>写真</th>
					<th>商品名</th>
					<th>価格</th>
					<th>メモ</th>
					<th>賞味期限</th>
					<th>数量</th>
					<th></th>
				</tr>

				<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.r}</td>
						<td><img
							src="${pageContext.request.contextPath}/resources/images/product/${list.p_img}"
							alt="${list.p_name}" /></td>

						<td>${list.p_name}</td>

						<td>￥<fmt:formatNumber value="${list.p_price }" pattern="#,###,###" /></td>

						<td>${list.p_memo }</td>

						<td>${list.p_exipdate}日</td>
						
						<td><input type="number" value="0" max="99" min="1" id="a${list.p_id}" /></td>
						
						<td><input type="button" value="保存" onClick="save(${list.p_id})"/></td>
					</tr>
				</c:forEach>
			</table>
			<div class="form_btn_box">
				<a onClick="goList()">一覧</a>
			</div>
		</div>

		<div class="paging">
			<ul>
				<li class="Rm5"><a onClick="selectPaging('first')"> << </a></li>
				<li><a onClick="selectPaging('prev')"> < </a></li>

				<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
					var="i">
					<c:if test="${i==paging.pageIndex}">
						<li class="pageIndex">[${i}]</li>
					</c:if>
					<c:if test="${i!=paging.pageIndex}">
						<li>[<a onClick="selectPaging(${i})">${i}</a>]
						</li>
					</c:if>
				</c:forEach>

				<li class="Rm5"><a onClick="selectPaging('next')"> > </a></li>
				<li><a onClick="selectPaging('last')"> >> </a></li>
			</ul>
		</div>
	</div>
	
	
	
	
	<script>

		// Paging
		let pageIndex = "${paging.pageIndex}";
		let selectPaging = function(val) {
			switch(val){
				case "first" : 
					pageIndex = 1;
					break;
				case "prev" : 
					pageIndex = "${paging.pageIndex - 1}";
					break;
				case "next" : 
					pageIndex = "${paging.pageIndex + 1}";
					break;
				case "last" : 
					pageIndex = "${paging.pageCount}";
					break;
				default :
					pageIndex = val; 	
					break;
			}
			
			location.href="productStockInsertForm.do?sort=${sort}&pageIndex="+pageIndex;
		}
			
		// Go List
		let goList = function() {
			location.href="../stock/stock.do";
		}

		//save
		let save = function(p_id) {
			let amount = $("#a"+ p_id ).val();
			if (amount > 99){
				 alert("数量を超過しました。");
			}else if (amount <= 0){
				alert("数量は1以上でなければなりません。");
			}
			else{
				if(window.confirm("本当に保存しますか？")) {
		        $.ajax({
		        	url : '../stock/stockInsert.do',
		        	type : 'POST',
		        	traditional : true,
		        	data : {
			        	p_id : p_id,
			        	p_amount : amount,
			        	pageIndex : pageIndex
		        	},
		        	//Ajax success
		        	success : function(data){
		        		alert("保存しました。");
			        	location.reload();
		        	},
		        	//Ajax fail
		        		error : function(jqXHR, textStatus, errorThrown){
		        	        console.log("jqXHR : " +jqXHR +"textStatus : " + textStatus + "errorThrown : " + errorThrown);
		        	}
		        });
		      }
	     	}
		}
	</script>
	
</body>
</html>