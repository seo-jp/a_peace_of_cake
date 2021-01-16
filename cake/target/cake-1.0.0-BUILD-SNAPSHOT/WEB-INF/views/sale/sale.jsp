<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sale.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
 	
 	<div class="saleList">
		<div class="search_box">
			<div class="sort_box">
				<div class="viewType_box">
					<ul>
						<li>
							<label for="viewDay">日</label>
							<input type="radio" name="view" 
								id="viewDay" value="day" <c:if test="${viewType eq 'day'}">checked</c:if> />
						</li>
						<li>
							<label for="viewWeek">週</label>
							<input type="radio" name="view" 
								id="viewWeek" value="week" <c:if test="${viewType eq 'week'}">checked</c:if> />
						</li>
						<li>
							<label for="viewMonth">月</label>
							<input type="radio" name="view" 
								id="viewMonth" value="month" <c:if test="${viewType eq 'month'}">checked</c:if> />
						</li>
						<li>
							<label for="viewYear">年</label>
							<input type="radio" name="view" 
								id="viewYear" value="year" <c:if test="${viewType eq 'year'}">checked</c:if> />
						</li>
					</ul>
				</div>
				<select class="sort">
					<option value="S_ID DESC">新規登録順</option>
					<!-- <option value="S_ID ASC">오래된순</option> -->
					<option value="S_NAME ASC">商品名順</option>
					<option value="S_ALLPRICE DESC">売上が高い順</option>
					<option value="S_ALLPRICE ASC">売上が安い順</option>
				</select>
			</div>
			<form method="post" action="saleSearch.do" id="frm">
				<table>
					<tr class="hidden_box">
						<input type="hidden" name="pageIndex" id="pageIndex"
							value="${paging.pageIndex}" />
						<input type="hidden" name="sort" id="sort" value="${sort}" />
						<input type="hidden" name="viewType" id="viewType"
							value="${viewType}" />
					</tr>
					<tr>
						<th><label for="searchS_name">商品名</label></th>
						<td><input type="text" name="searchS_name" id="searchS_name"
							maxlength="100" value="${search.searchS_name}" /></td>
					</tr>
					<tr>
						<th><label>상태</label></th>
						<td><label for="searchS_state1">販売完了</label> <input
							type="radio" name="searchS_state" id="searchS_state1" value="0"
							<c:if test="${search.searchS_state eq '0'}">checked</c:if> /> <label
							for="searchS_state2">払い戻し</label> <input type="radio"
							name="searchS_state" id="searchS_state2" value="1"
							<c:if test="${search.searchS_state eq '1'}">checked</c:if> /></td>
					</tr>
					<tr>
						<th><label for="searchS_regdate">販売日</label></th>
						<td><input type="date" name="searchFromDate"
							id="searchFromDate" value="${search.searchFromDate}" /> <span>~</span> <input
							type="date" name="searchToDate" id="searchToDate"
							value="${search.searchToDate}" /></td>
					</tr>
	
					<tr>
						<td><input type="submit" value="検索" /></td>
					</tr>
				</table>
			</form>
		</div>
		<p class="result_p">${paging.totalCount}件のデータがあります。 : 総売上は <span>${sum} ￥</span>です。</p>
		<div class="edit_box">
			<ul>
				<li><a onClick="saleListAll()">全売上一覧</a></li>
				<li><a onClick="goPos()">POS</a></li>
				<li><a onClick="goGraph()">GRAPH</a></li>
			</ul>
		</div>

		<div class="list_wrap">
			<table class="list">
				<tr>
					<th>NO</th>
					<th>商品名</th>
					<th>状態</th>
					<th>数量</th>
					<th>割引率</th>
					<th>価格</th>
					<th>総額</th>
					<th>販売時間</th>
				</tr>

				<c:forEach items="${list}" var="list">
					<tr <c:if test="${list.s_group_id%2 == 0}"> class="oddTr"</c:if>>
						<td>${list.r}</td>
						<td>${list.s_name}</td>
						<td><c:if test="${list.s_state eq '0'.charAt(0) }">販売完了</c:if>
							<c:if test="${list.s_state eq '1'.charAt(0) }">払い戻し</c:if></td>
						<td>${list.s_amount}個</td>
						<td>${list.s_discount}%</td>
						<td>${list.s_price}￥</td>
						<td>${list.s_allprice}￥</td>
						<td><fmt:formatDate value="${list.s_regdate }"
								pattern="yyyy.MM.dd HH時mm分" /></td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<div class="paging">
			<ul>
				<li class="Rm5"><a onClick="selectPaging('first')"> << </a></li>
				<li><a onClick="selectPaging('prev')"> <
				</a></li>
	
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
				location.href="sale.do?viewType=" + viewTypeVal + "&sort=${sort}";
			else if(mode == 'search'){
				document.querySelector('#searchFromDate').value = "";
				document.querySelector('#searchToDate').value = "";
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
				location.href="sale.do?sort="+value+"&viewType=${viewType}";
			else if(mode == 'search')
				document.querySelector('#frm').submit();
		}
		sort.addEventListener("change", selectSort);

		// Go all orderList
		let saleListAll = function() {
			location.href="sale.do?sort=${sort}&viewType=${viewType}";
		}

		// Go Pos
		let goPos = function() {
			window.open("pos.do");
		}

		// Go Graph
		let goGraph = function() {
			location.href="saleGraph.do";
		}
	
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
				location.href="sale.do?viewType=${viewType}&sort=${sort}&pageIndex="+pageIndex.value;
			else if(mode == 'search')
				document.querySelector('#frm').submit();	
		}


	</script>

</body>
</html>