<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/product.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<c:if test="${result == 1 }">
		<script>alert("登録しました。");</script>
	</c:if>

	<div class="product">

		<div class="search_box">

			<div class="sort_box">
				<select class="sort">
					<option value="P_ID DESC">新規登録順</option>
					<option value="P_NAME ASC">商品名順</option>
					<option value="TO_NUMBER(P_PRICE) DESC">価格が高い順</option>
					<option value="TO_NUMBER(P_PRICE) ASC">価格が安い順</option>
					<option value="TO_NUMBER(P_EXIPDATE) ASC">賞味期限が短い順</option>
					<option value="TO_NUMBER(P_EXIPDATE) DESC">賞味期限が長い順</option>
				</select>
			</div>

			<form method="post" action="productSearch.do" id="frm">
				<table>
					<tr class="hidden_box">
						<input type="hidden" name="pageIndex" id="pageIndex"
							value="${paging.pageIndex}" />
						<input type="hidden" name="sort" id="sort" value="${sort}" />
					</tr>
					<tr>
						<th><label for="searchP_name">商品名</label></th>
						<td><input type="text" name="searchP_name" id="searchP_name"
							maxlength="100" value="${search.searchP_name}" /></td>
						<th><label for="">状態</label></th>
						<td><label for="searchP_state1">販売中</label> <input
							type="radio" name="searchP_state" id="searchP_state1" value="0"
							<c:if test="${search.searchP_state eq '0'}">checked</c:if> /> <label
							for="searchP_state2">販売中止</label> <input type="radio"
							name="searchP_state" id="searchP_state2" value="1"
							<c:if test="${search.searchP_state eq '1'}">checked</c:if> /></td>
					</tr>
					<tr>
						<th><label for="searchP_memo">メモ</label></th>
							<td><input type="text" name="searchP_memo" id="searchP_memo"
							maxlength="200" value="${search.searchP_memo}" /></td>
						<th><label for="searchFromDate">登録日</label></th>
						<td><input type="date" name="searchFromDate"
							id="searchFromDate" value="${search.searchFromDate}" /> <span>
								~ </span> <input type="date" name="searchToDate" id="searchToDate"
							value="${search.searchToDate}" /></td>
					</tr>
					<tr>
					<th><label for="searchP_price">価格</label></th>
						<td><input type="number" name="searchP_price"
							id="searchP_price" min="1" max="1000000"
							value="${search.searchP_price}" /> <span>￥</span></td>
					<th><label for="searchP_exipdate">賞味期限</label></th>
						<td><input type="number" name="searchP_exipdate"
							id="searchP_exipdate" min="1" max="5000"
							value="${search.searchP_exipdate}" /> <span>日</span></td>
					</tr>
					<tr>
						<td><input type="submit" value="検索" /></td>
					</tr>
				</table>
			</form>
		</div>
		<p class="result_p">${paging.totalCount}件のデータがあります。</p>
		<div class="edit_box">
			<ul>
				<li><a onClick="productAll()">全商品一覧</a></li>
				<li><a onClick="productInsert()">登録</a></li>
				<li><a onClick="productDelete()">削除</a></li>
			</ul>
		</div>

		<div class="list_wrap">
			<table class="list">
				<tr>
					<th><input id="allChk" type="checkbox" onClick="allCheck()" /></th>
					<th>NO</th>
					<th>写真</th>
					<th>商品名</th>
					<th>価格</th>
					<th>状態</th>
					<th>メモ</th>
					<th>賞味期限</th>
					<th>登録日</th>
				</tr>

				<c:forEach items="${list}" var="list">
					<tr>
						<td><input name="check" type="checkbox" value="${list.p_id}" /></td>
						<td>${list.r}</td>
						<td><img
							src="${pageContext.request.contextPath}/resources/images/product/${list.p_img}"
							alt="${list.p_name}" /></td>

						<td onClick="productEdit(${list.p_id})">${list.p_name}</td>

						<td>${list.p_price }￥</td>

						<td><c:if test="${list.p_state eq '0'.charAt(0) }">販売中</c:if>
							<c:if test="${list.p_state eq '1'.charAt(0) }">販売中止</c:if></td>

						<td>${list.p_memo }</td>

						<td>${list.p_exipdate}日</td>

						<td><fmt:formatDate value="${list.p_regdate}"
								pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
			</table>
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
		
		// Basic Setting
		$(document).ready(function(){
			$("input:checkbox[name='check']").change(function(){
		    	if($("input:checkbox[id='allChk']").is(":checked") == true)
		    		$("input:checkbox[id='allChk']").prop("checked", false);
		    });
		});
		
		let mode = "${mode}";
		
		// Sort
		let sort = document.querySelector('.sort');
		sort.value = "${sort}";
		let selectSort = function() {
			let value = sort.options[sort.selectedIndex].value;
			document.querySelector('#sort').value = value;
			if(mode == 'list')
				location.href="product.do?sort="+value;
			else if(mode == 'search')
				document.querySelector('#frm').submit();
		}
		sort.addEventListener("change", selectSort);
	
		// Paging
		let pageIndex = document.querySelector('#pageIndex');
		let selectPaging = function(val) {
			switch(val){
				case "first" : 
					pageIndex.value = 1;
					break;
				case "prev" : 
					pageIndex.value = "${paging.pageIndex - 1}";
					break;
				case "next" : 
					pageIndex.value = "${paging.pageIndex + 1}";
					break;
				case "last" : 
					pageIndex.value = "${paging.pageCount}";
					break;
				default :
					pageIndex.value = val; 	
					break;
			}
			
			if(mode == 'list')
				location.href="product.do?sort=${sort}&pageIndex="+pageIndex.value;
			else if(mode == 'search')
				document.querySelector('#frm').submit();	
		}

		// Go all product
		let productAll = function() {
			location.href="product.do?sort=${sort}";
		}
		
		// Go Insert
		let productInsert = function() {
			location.href="productInsertForm.do?sort=${sort}&pageIndex="+pageIndex.value;
		}
	
		// Go Update
		let productEdit = function(id) {
			location.href="productUpdateForm.do?sort=${sort}&pageIndex="+pageIndex.value+"&p_id="+id;
		}
	
		// All Check
		let allCheck = function() {
			if($("input:checkbox[id='allChk']").is(":checked") == true){
				$("input:checkbox[name='check']").prop("checked", true);
	        }else{
	        	$("input:checkbox[name='check']").prop("checked", false);
	        }
		}
		// Delete
		let productDelete = function() {
			let cnt = document.querySelectorAll("input[name=check]:checked").length;
		    let arr = [];
		    if(cnt == 0){
		    	alert("削除する商品を選んでください!");
		    }
		    else{
		    	if (window.confirm("本当に削除しますか?")) {

		        	for (var i=0; i<cnt; i++) {
		        	 arr[i] = document.querySelectorAll("input[name=check]:checked")[i].value;
		        	}
	
		        	$.ajax({
		        	    url : 'productDelete.do',
		        	    type : 'POST',
		        	    traditional : true,
		        	    data : {
		        	        p_ids : arr ,
		        	        pageIndex : pageIndex.value,
		        	        sort : sort.value
		        	    },
		        	    //Ajax success
		        	    success : function(data){
			        	    alert("削除しました。");
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