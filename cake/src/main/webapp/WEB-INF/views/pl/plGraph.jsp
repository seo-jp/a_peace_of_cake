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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
</head>
<body>

	<div class="pllist">
		
		<h2 class="pllist_p result_p">${searchDate} 損益グラフ</h2>
		
		<div class="Graph_v viewType_box">
			<ul>
				<li><label for="viewDay">日</label> <input type="radio"
					name="view" id="viewDay" value="day"
					<c:if test="${viewType eq 'day'}">checked</c:if> /></li>
				<li><label for="viewMonth">月</label> <input type="radio"
					name="view" id="viewMonth" value="month"
					<c:if test="${viewType eq 'month'}">checked</c:if> /></li>
				<li><label for="viewYear">年</label> <input type="radio"
					name="view" id="viewYear" value="year"
					<c:if test="${viewType eq 'year'}">checked</c:if> /></li>
			</ul>
		</div>
		
		<div class="dateSearch">
			<c:if test="${viewType eq 'day'}"><input type="date" name="searchDate" value="${searchDate}" /></c:if>
			<c:if test="${viewType eq 'month'}"><input type="month" name="searchDate" value="${searchDate}" /></c:if>
			<c:if test="${viewType eq 'year'}"><input type="number" name="searchDate" min="1900" max="2099" step="1" value="${searchDate}" /></c:if>
		</div>
		
		<div class="edit_box">
			<ul>
				<li><a onClick="goList()">一覧</a></li>
			</ul>
		</div>
		
		<canvas id="myChart" style="height:530px;"></canvas>
		
		<%-- <table class="plTb">
			<tr>
				<th> </th>
				<c:forEach items="${list}" var="list">
					<th>${list.label}</th>
				</c:forEach>
			</tr>
			
			<tr class="tr1">
				<td> 売上 </td>
				<c:forEach items="${list}" var="list">
					<td><fmt:formatNumber value="${list.s_data }" pattern="#,###,###" /></td>
				</c:forEach>
			</tr>
			
			<tr class="tr2">
				<td> 支出 </td>
				<c:forEach items="${list}" var="list">
					<td>￥<fmt:formatNumber value="${list.o_data }" pattern="#,###,###" /></td>
				</c:forEach>
			</tr>
			
			<tr class="tr3">
				<td> 経費 </td>
				<c:forEach items="${list}" var="list">
					<td>￥<fmt:formatNumber value="${list.sp_data }" pattern="#,###,###" /></td>
				</c:forEach>
			</tr>
		</table> --%>
		
	</div>
	
	

		<script>
		
			// viewType
			let viewType = document.querySelectorAll(".viewType_box input");
			let selectViewType = function() {
				let viewTypeVal = document.querySelector("input[name=view]:checked").value;
				location.href = "plGraph.do?viewType=" + viewTypeVal;
			}
			viewType.forEach(function(viewType) {
				viewType.addEventListener('click', selectViewType);
			});
	
			// dateSearch
			let searchDate = document.querySelector(".dateSearch input");
			let searchDateView = function() {
				let val = searchDate.value;
				location.href = "plGraph.do?viewType=${viewType}&searchDate="+ val;
			}
			searchDate.addEventListener('change', searchDateView);
	
	
			// chart
			
			var labelArr = new Array();
			
			var s_dataArr = new Array();
			var o_dataArr = new Array();
			var sp_dataArr = new Array();
			
			var bgArr1 = new Array();	
			var bgArr2 = new Array();	
			var bgArr3 = new Array();	

		</script>
		
		<c:forEach items="${list}" var="list">
			<script>
				labelArr.push("${list.label}");
				s_dataArr.push("${list.s_data}");
				o_dataArr.push("${list.o_data}");
				sp_dataArr.push("${list.sp_data}");
			</script>
		</c:forEach>
		
		<script>
			for(var i=0;i<s_dataArr.length;i++){
				bgArr1[i] = 'rgba(79, 198, 255, 0.2)';
			}

			for(var i=0;i<o_dataArr.length;i++){
				bgArr2[i] = 'rgba(255, 27, 27, 0.2)';
			}

			for(var i=0;i<sp_dataArr.length;i++){
				bgArr3[i] = 'rgba(255, 99, 132, 0.2)';
			}
			
			var ctx = document.getElementById("myChart").getContext('2d');
			var myChart = new Chart(ctx, {
			    type: 'bar',
			    data: {
			        labels: labelArr,
			        datasets: [{
			        	label: '# 売上',
			            data:s_dataArr,
			            backgroundColor: bgArr1
			        }, {
			        	label:'# 支出',
			            data: o_dataArr,
			            backgroundColor: bgArr2
				    }, {
				    	label: '# 経費',
			            data: sp_dataArr,
			            backgroundColor: bgArr3
					}]
			    },
			    options: {
			        scales: {
			            yAxes: [{
			                ticks: {
			                	callback: function(value, index, values) {
									value = Math.floor(value);
			                        return '￥' + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				                }
			                }
			            }]
			        }
			    }
			});
			
	
			// Go List
			let goList = function() {
				location.href="pl.do";
			}

		</script>
		
		

</body>
</html>