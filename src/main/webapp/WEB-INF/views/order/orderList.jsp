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
	
	<c:if test="${result == 1 }">
		<script>alert("発注しました。")</script>
	</c:if>
	
 	
 	<div class="orderList">
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
					<option value="O_REGDATE DESC">新規登録順</option>
					<!-- <option value="O_REGDATE ASC">오래된순</option> -->
					<option value="O_NAME ASC">材料名順</option>
					<option value="TO_NUMBER(O_PRICE) DESC">価格が高い順</option>
					<option value="TO_NUMBER(O_PRICE) ASC">価格が安い順</option>
				</select>
			</div>
			<form method="post" action="orderSearch.do" id="frm">
				<table>
					<tr class="hidden_box">
						<input type="hidden" name="o_id" id="o_id" />
						<input type="hidden" name="pageIndex" id="pageIndex"
							value="${paging.pageIndex}" />
						<input type="hidden" name="sort" id="sort" value="${sort}" />
						<input type="hidden" name="viewType" id="viewType"
							value="${viewType}" />
					</tr>
					<tr>
						<th><label for="searchO_name">材料名</label></th>
						<td><input type="text" name="searchO_name" id="searchO_name"
							maxlength="100" value="${search.searchO_name}" /></td>
					</tr>
					<tr>
						<th><label>상태</label></th>
						<td><label for="searchO_state1">配送待ち</label> <input
							type="radio" name="searchO_state" id="searchO_state1" value="0"
							<c:if test="${search.searchO_state eq '0'}">checked</c:if> /> <label
							for="searchO_state2">配送中</label> <input type="radio"
							name="searchO_state" id="searchO_state2" value="1"
							<c:if test="${search.searchO_state eq '1'}">checked</c:if> /> <label
							for="searchO_state3">配送完了</label> <input type="radio"
							name="searchO_state" id="searchO_state3" value="2"
							<c:if test="${search.searchO_state eq '2'}">checked</c:if> /> <label
							for="searchO_state4">取り消し</label> <input type="radio"
							name="searchO_state" id="searchO_state4" value="3"
							<c:if test="${search.searchO_state eq '3'}">checked</c:if> /></td>
					</tr>
					<tr>
						<th><label for="searchO_regdate">日付</label></th>
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
		<p class="result_p">${paging.totalCount}件のデータがあります。</p>
		<div class="edit_box">
			<ul>
				<li><a onClick="orderListAll()">全記録一覧</a></li>
			</ul>
		</div>

		<div class="list_wrap">
			<table class="list">
				<tr>
					<th>NO</th>
					<th>写真</th>
					<th>材料名</th>
					<th>価格</th>
					<th>総額</th>
					<th>状態</th>
					<th>数量</th>
					<th>日付</th>
					<th></th>
				</tr>

				<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.r}</td>
						<td><img
							src="${pageContext.request.contextPath}/resources/images/ingredient/${list.i_img}"
							alt="${list.o_name}" /></td>

						<td>${list.o_name}</td>
						<td>￥<fmt:formatNumber value="${list.i_price }" pattern="#,###,###" /></td>
						<td>￥<fmt:formatNumber value="${list.o_price }" pattern="#,###,###" /></td>

						<td><c:if test="${list.o_state eq '0'.charAt(0) }">配送待ち</c:if>
							<c:if test="${list.o_state eq '1'.charAt(0) }">配送中</c:if> <c:if
								test="${list.o_state eq '2'.charAt(0) }">配送完了</c:if> <c:if
								test="${list.o_state eq '3'.charAt(0) }">取り消し</c:if></td>
						
						<td>${list.o_amount}個</td>
						
						<td><fmt:formatDate value="${list.o_regdate }"
								pattern="yyyy.MM.dd HH時mm分" /></td>

						<td><c:if test="${list.o_state eq '0'.charAt(0) }">
								<input type="button" value="取り消し" onClick="cancel(${list.o_id})" />
							</c:if></td>
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
				location.href="orderList.do?viewType=" + viewTypeVal + "&sort=${sort}";
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
				location.href="orderList.do?sort="+value+"&viewType=${viewType}";
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
				location.href="orderList.do?viewType=${viewType}&sort=${sort}&pageIndex="+pageIndex.value;
			else if(mode == 'search')
				document.querySelector('#frm').submit();	
		}

		// Go all orderList
		let orderListAll = function() {
			location.href="orderList.do?sort=${sort}";
		}

		// cancel
		let cancel = function(o_id) {
			var queryString = $("form[id=frm]").serialize() ;
			if (window.confirm("本当に取り消ししますか？")) {
		        $.ajax({
		        	url : 'orderCancel.do',
		        	type : 'POST',
		        	traditional : true,
		        	data : {
			        	o_id : o_id,
			        	queryString
		        	},
		        	//Ajax success
		        	success : function(data){
		        		alert("取り消ししました。");
			        	location.reload();
		        	},
		        	//Ajax fail
		        		error : function(jqXHR, textStatus, errorThrown){
		        	        console.log("jqXHR : " +jqXHR +"textStatus : " + textStatus + "errorThrown : " + errorThrown);
		        	}
		        });
		      }
	     }

	</script>

</body>
</html>