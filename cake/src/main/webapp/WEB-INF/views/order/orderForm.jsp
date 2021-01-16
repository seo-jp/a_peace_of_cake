<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<script>alert("発注が不可能な商品です。")</script>
	</c:if>
	<c:if test="${result == 1 }">
		<script>alert("登録しました。");</script>
	</c:if>

	<div class="order">
		<div class="search_box">
			
			<div class="sort_box">
				<select class="sort">
					<option value="I_ID DESC">新規登録順</option>
					<!-- <option value="I_ID ASC">오래된순</option> -->
					<option value="I_NAME ASC">材料名順</option>
					<option value="TO_NUMBER(I_PRICE) DESC">価格が高い順</option>
					<option value="TO_NUMBER(I_PRICE) ASC">価格が安い順</option>
					<option value="TO_NUMBER(I_EXIPDATE) ASC">賞味期限が短い順</option>
					<option value="TO_NUMBER(I_EXIPDATE) DESC">賞味期限が長い順</option>
				</select>
			</div>
			
			<form method="post" action="ingredientSearch.do" id="frm">
				<table>
					<tr class="hidden_box">
						<input type="hidden" name="pageIndex" id="pageIndex"
							value="${paging.pageIndex}" />
						<input type="hidden" name="sort" id="sort" value="${sort}" />
					</tr>
					<tr>
						<th><label for="searchI_name">材料名</label></th>
						<td><input type="text" name="searchI_name" id="searchI_name"
							maxlength="100" value="${search.searchI_name}" /></td>
						<th><label for="searchI_exipdate">賞味期限</label></th>
							<td><input type="number" name="searchI_exipdate"
							id="searchI_exipdate" min="1" max="5000"
							value="${search.searchI_exipdate}" />
							<span>日</span></td>	
					</tr>
					<tr>
						<th><label>状態</label></th>
						<td><label for="searchI_state1">発注可能</label> <input
							type="radio" name="searchI_state" id="searchI_state1" value="0"
							<c:if test="${search.searchI_state eq '0'}">checked</c:if> /> <label
							for="searchI_state2">発注不可</label> <input type="radio"
							name="searchI_state" id="searchI_state2" value="1"
							<c:if test="${search.searchI_state eq '1'}">checked</c:if> /></td>
					</tr>
					<tr>
						<th><label for="searchI_price">価格</label></th>
						<td><span>￥</span> <input type="number" name="searchI_price"
							id="searchI_price" min="1" max="1000000"
							value="${search.searchI_price}" />
							</td>
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
				<li><a onClick="ingredientAll()">全材料一覧</a></li>
				<li><a onClick="ingredientInsert()">材料登録</a></li>
			</ul>
		</div>

		<div class="list_wrap">
			<table class="list">
				<tr>
					<th>NO</th>
					<th>写真</th>
					<th>材料名</th>
					<th>価格</th>
					<th>状態</th>
					<th>賞味期限</th>
					<th>数量</th>
					<th></th>
				</tr>

				<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.r}</td>
						<td><img
							src="${pageContext.request.contextPath}/resources/images/ingredient/${list.i_img}"
							alt="${list.i_name}" /></td>

						<td onClick="ingredientEdit(${list.i_id})">${list.i_name}</td>

						<td>￥<fmt:formatNumber value="${list.i_price }" pattern="#,###,###" /></td>

						<td><c:if test="${list.i_state eq '0'.charAt(0) }">発注可能</c:if>
							<c:if test="${list.i_state eq '1'.charAt(0) }">発注不可</c:if></td>

						<td>${list.i_exipdate}日</td>

						<td><input type="number" name="o_amount" id="a${list.i_id}"
							min="1" max="30" value="1" /></td>

						<td><input type="submit" value="発注"
							onClick="order(${list.i_id},${list.i_state})" /></td>
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
		let mode = "${mode}";
		
		// Sort
		let sort = document.querySelector('.sort');
		sort.value = "${sort}";
		let selectSort = function() {
			let value = sort.options[sort.selectedIndex].value;
			document.querySelector('#sort').value = value;
			if(mode == 'list')
				location.href="order.do?sort="+value;
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
				location.href="order.do?sort=${sort}&pageIndex="+pageIndex.value;
			else if(mode == 'search')
				document.querySelector('#frm').submit();	
		}

		// Go all ingredient
		let ingredientAll = function() {
			location.href="order.do?sort=${sort}";
		}
		
		// Go Insert
		let ingredientInsert = function() {
			location.href="ingredientInsertForm.do?sort=${sort}&pageIndex="+pageIndex.value;
		}
	
		// Go Update
		let ingredientEdit = function(id) {
			location.href="ingredientUpdateForm.do?sort=${sort}&pageIndex="+pageIndex.value+"&i_id="+id;
		}
	
		// All Check
		let allCheck = function() {
			if($("input:checkbox[id='allChk']").is(":checked") == true){
				$("input:checkbox[name='check']").prop("checked", true);
	        }else{
	        	$("input:checkbox[name='check']").prop("checked", false);
	        }
		}
		
		// order
		let order = function(i_id,i_state) {
			if(i_state == '1') {
				alert("発注が不可能な商品です。");
			}else{
				if (window.confirm("本当に発注しますか?")) {
				let amount = $("#a"+ i_id ).val();
				location.href="orderInsert.do?i_id=" + i_id + "&i_state=" + i_state + "&o_amount=" + amount
							  + "&pageIndex=${paging.pageIndex}&sort=${sort}";
				}
			}
			
		}

	</script>

</body>
</html>