<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/stock.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<div class="stock">

		<div class="search_box">
			<div class="sort_box">
				<div class="viewType_box">
					<ul>
						<%-- <li><label for="viewA">전체</label> <input type="radio"
							name="view" id="viewA" value="A"
							<c:if test="${viewType eq 'A'}">checked</c:if> /></li> --%>
						<li><label for="viewP">商品</label> <input type="radio"
							name="view" id="viewP" value="P"
							<c:if test="${viewType eq 'P'}">checked</c:if> /></li>
						<li><label for="viewI">材料</label> <input type="radio"
							name="view" id="viewI" value="I"
							<c:if test="${viewType eq 'I'}">checked</c:if> /></li>
					</ul>
				</div>

				<select class="sort">
					<option value="S_ID DESC">新規登録順</option>
					<!-- <option value="S_ID ASC">오래된순</option> -->
					<option value="S_NAME ASC">名順</option>
					<option value="S_EXIPDATE ASC">賞味期限が短い順</option>
				</select>
			</div>
			
			<form method="post" action="stockSearch.do" id="frm">
				<table>
					<tr class="hidden_box">
						<input type="hidden" name="pageIndex" id="pageIndex"
							value="${paging.pageIndex}" />
						<input type="hidden" name="sort" id="sort" value="${sort}" />
						<input type="hidden" name="viewType" id="viewType"
							value="${viewType}" />
					</tr>
					<tr>
						<th><label for="searchS_name">在庫名</label></th>
						<td><input type="text" name="searchS_name" id="searchS_name"
							maxlength="100" value="${search.searchS_name}" /></td>
						<th><label>状態</label></th>
						<td><label for="searchS_state1">保存</label> <input
							type="radio" name="searchS_state" id="searchS_state1" value="0"
							<c:if test="${search.searchS_state eq '0' or search.searchS_state eq null}">checked</c:if> /> 
							<label for="searchS_state2">廃棄</label> <input type="radio"
							name="searchS_state" id="searchS_state2" value="1"
							<c:if test="${search.searchS_state eq '1'}">checked</c:if> /></td>
					</tr>
					<tr>
						<th><label for="searchFromDate1">製造日</label></th>
						<td><input type="date" name="searchFromDate1"
							id="searchFromDate1" value="${search.searchFromDate1}" /> <span>
								~ </span> <input type="date" name="searchToDate1" id="searchToDate1"
							value="${search.searchToDate1}" /></td>
					</tr>
					<tr>
						<th><label for="searchFromDate2">賞味期限</label></th>
						<td><input type="date" name="searchFromDate2"
							id="searchFromDate2" value="${search.searchFromDate2}" /> <span>
								~ </span> <input type="date" name="searchToDate2" id="searchToDate2"
							value="${search.searchToDate2}" /></td>
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
				<li><a onClick="stockAll()">全在庫一覧</a></li>
				<li><a onClick="productStockInsert()">商品の在庫入力</a></li>
			</ul>
		</div>

		<div class="list_wrap">
			<table class="list">
				<tr>
					<th>NO</th>
					<th>写真</th>
					<th>種類</th>
					<th>在庫名</th>
					<th>状態</th>
					<th>製造日</th>
					<th>賞味期限</th>
					<th>数量</th>
					<th>使用量</th>
					<th></th>
				</tr>

				<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.r}</td>
						<td>
							<c:if test="${list.s_category eq 'P'}">
								<img src="${pageContext.request.contextPath}/resources/images/product/${list.p_img}" alt="${list.s_name}" />
							</c:if>
							<c:if test="${list.s_category eq 'I'}">
								<img src="${pageContext.request.contextPath}/resources/images/ingredient/${list.i_img}" alt="${list.s_name}" />
							</c:if>
						</td>
						
						<td>
							<c:if test="${list.s_category eq 'P'}">商品</c:if>
							<c:if test="${list.s_category eq 'I'}">材料</c:if>
						</td>
						
						<td>${list.s_name}</td>

						<td><c:if test="${list.s_state eq '0'.charAt(0) }">保存</c:if>
							<c:if test="${list.s_state eq '1'.charAt(0) }">廃棄</c:if></td>
							
						<td><fmt:formatDate value="${list.s_manufdate }"
								pattern="yyyy.MM.dd" />日</td>	

						<td><fmt:formatDate value="${list.s_exipdate }"
								pattern="yyyy.MM.dd" />日</td>
								
						<td>${list.s_amount}個</td>
						
						<td>
							<c:if test="${list.s_state eq '0'.charAt(0) && list.s_category eq 'I' }">
								<input type="number" value="0" max="${list.s_amount}" min="0" id="a${list.s_id}" />
							</c:if>
						</td>
						
						<td>
							<c:if test="${list.s_state eq '0'.charAt(0) && list.s_category eq 'I' }">
								<input type="button" value="保存" onClick="save(${list.s_id},${list.s_amount})"/>
							</c:if>
						</td>
								

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

		// viewType
		let viewType = document.querySelectorAll(".viewType_box input");
		let selectViewType = function() {
			let viewTypeVal = document.querySelector("input[name=view]:checked").value;
			document.querySelector('#viewType').value = viewTypeVal;
			if(mode == 'list')
				location.href="stock.do?viewType=" + viewTypeVal + "&sort=${sort}";
			else if(mode == 'search'){
				document.querySelector('#frm').submit();
			}
		}
		viewType.forEach(function (viewType) {
			viewType.addEventListener('click', selectViewType);
		});
		
		// Sort
		let sort = document.querySelector('.sort');
		sort.value = "${sort}";
		let selectSort = function() {
			let value = sort.options[sort.selectedIndex].value;
			document.querySelector('#sort').value = value;
			if(mode == 'list')
				location.href="stock.do?sort="+value+"&viewType=${viewType}";
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
				location.href="stock.do?viewType=${viewType}&sort=${sort}&pageIndex="+pageIndex.value;
			else if(mode == 'search')
				document.querySelector('#frm').submit();	
		}

		// Go all orderList
		let stockAll = function() {
			location.href="stock.do?sort=${sort}&viewType=${viewType}";
		}

		// Go add product stock
		let productStockInsert = function() {
			location.href="../product/productStockInsertForm.do";
		}

		//save
		let save = function(s_id,s_max_amount) {
			let queryString = $("form[id=frm]").serialize();
			let amount = $("#a"+ s_id ).val();
			if (amount > s_max_amount){
				 alert("数量を超過しました。");
			}else if (amount <= 0){
				alert("数量は1以上でなければなりません。");
			}
			else{
				if(window.confirm("本当に保存しますか？")) {
				amount = s_max_amount - amount;
		        $.ajax({
		        	url : 'stockUpdate.do',
		        	type : 'POST',
		        	traditional : true,
		        	data : {
			        	s_id : s_id,
			        	s_amount : amount,
			        	queryString
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