<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/pl.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<c:if test="${result == 1 }">
		<script>alert("登録しました。")</script>
	</c:if>
 	
 	<div class="pllist">
		
		<div class="search_box">
			<div class="sort_box">
				<div class="viewType_box">
					<ul>
						<li><label for="viewDay">日</label> <input type="radio"
							name="view" id="viewDay" value="day"
							<c:if test="${viewType eq 'day'}">checked</c:if> /></li>
						<li><label for="viewWeek">週</label> <input type="radio"
							name="view" id="viewWeek" value="week"
							<c:if test="${viewType eq 'week'}">checked</c:if> /></li>
						<li><label for="viewMonth">月</label> <input type="radio"
							name="view" id="viewMonth" value="month"
							<c:if test="${viewType eq 'month'}">checked</c:if> /></li>
						<li><label for="viewYear">年</label> <input type="radio"
							name="view" id="viewYear" value="year"
							<c:if test="${viewType eq 'year'}">checked</c:if> /></li>
					</ul>
				</div>
			</div>
			<form method="post" action="pl.do" id="frm">
				<table>
					<tr>
						<th><label for="searchFromDate">日付</label></th>
						<td><input type="date" name="showDateFrom"
							id="showDateFrom" value="${showDateFrom}" /> <span>~</span> <input
							type="date" name="showDateTo" id="showDateTo"
							value="${showDateTo}" /></td>
					</tr>
					<tr>
						<td><input type="submit" value="検索" /></td>
					</tr>
				</table>
			</form>
		</div>
		
		<p class="result_p">${paging.totalCount}件のデータがあります。<!--  : 총 판매액 <span> 원</span> : 총 지출액 <span> 원</span> : 총 손익 <span> 원</span>  --></p>
		<div class="edit_box">
			<ul>
				<li><a onClick="plListAll()">全損益一覧</a></li>
				<li><a onClick="spendInsert()">経費登録</a></li>
				<li><a onClick="goGraph()">GRAPH</a></li>
			</ul>
		</div>

		<div class="list_wrap">
			<table class="list">
				<tr>
					<th>種類</th>
					<th>名</th>
					<th>数量</th>
					<th>総額</th>
					<th>日付</th>
				</tr>
				
				
				<c:forEach items="${list}" var="list">
						<!-- 수익 -->
						<c:if test="${list.category eq '0'.charAt(0) }">
						<tr class="tr1"><td>
							売上
						</c:if>
						<!-- 지출 -->
						<c:if test="${list.category eq '1'.charAt(0) }">
						<tr class="tr2"><td>
							支出
						</c:if>
						<!-- 경비 -->
						<c:if test="${list.category eq '2'.charAt(0) }">
						<tr class="tr3"><td>
							経費
						</c:if>
						</td>
						<td>${list.name}</td>
						<td>${list.amount}個</td>
						<td>￥<fmt:formatNumber value="${list.price }" pattern="#,###,###" /></td>
						<td><fmt:formatDate value="${list.regdate }" pattern="yyyy.MM.dd HH時mm分" /></td>
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
		
		// viewType
		let viewType = document.querySelectorAll(".viewType_box input");
		let selectViewType = function() {
			let viewTypeVal = document.querySelector("input[name=view]:checked").value;
			location.href = "pl.do?viewType=" + viewTypeVal;
		}
		viewType.forEach(function(viewType) {
			viewType.addEventListener('click', selectViewType);
		});
	
		
		// Go all plList
		let plListAll = function() {
			location.href="pl.do?&viewType=${viewType}";
		}

		// Go Spend
		let spendInsert = function() {
			location.href="spendInsertForm.do?pageIndex=${pageIndex}&showDateFrom=${showDateFrom}&showDateTo=${showDateTo}&viewType=${viewType}";
		}

		// Go Graph
		let goGraph = function() {
			location.href="plGraph.do";
		}
	
		// Paging
		let selectPaging = function(val) {
			let pageIndex = "${paging.pageIndex}";
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
			
			location.href="pl.do?viewType=${viewType}&showDateFrom=${showDateFrom}&showDateTo=${showDateTo}&pageIndex="+pageIndex;
		}


	</script>

</body>
</html>