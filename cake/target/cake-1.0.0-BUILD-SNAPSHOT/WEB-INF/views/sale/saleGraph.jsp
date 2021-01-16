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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
</head>
<body>

	<div class="saleList">
		
		<h2 class="saleGraph_p result_p">${searchDate} 販売グラフ</h2>
		
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
		
	</div>
	
	

		<script>
		
			// viewType
			let viewType = document.querySelectorAll(".viewType_box input");
			let selectViewType = function() {
				let viewTypeVal = document.querySelector("input[name=view]:checked").value;
				location.href = "saleGraph.do?viewType=" + viewTypeVal;
			}
			viewType.forEach(function(viewType) {
				viewType.addEventListener('click', selectViewType);
			});
	
			// dateSearch
			let searchDate = document.querySelector(".dateSearch input");
			let searchDateView = function() {
				let val = searchDate.value;
				location.href = "saleGraph.do?viewType=${viewType}&searchDate="+ val;
			}
			searchDate.addEventListener('change', searchDateView);
	
	
			// chart
	
			var labelArr = new Array();
			var dataArr = new Array();
			var bgArr = new Array();	

		</script>
		
		<c:forEach items="${list}" var="list">
			<script>
				labelArr.push("${list.label}");
				dataArr.push("${list.data}");
			</script>
		</c:forEach>
		
		<script>
			for(var i=0;i<dataArr.length;i++){
				bgArr[i] = 'rgba(255, 99, 132, 0.2)';
			}
			
			var ctx = document.getElementById("myChart").getContext('2d');
			var myChart = new Chart(ctx, {
			    type: 'bar',
			    data: {
			        labels: labelArr,
			        datasets: [{
			        	label: '# 売上',
			            data: dataArr,
			            backgroundColor: bgArr
			        }]
			    },
			    options: {
			        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
			        scales: {
			            yAxes: [{
			                ticks: {
			                    beginAtZero:true
			                }
			            }]
			        }
			    }
			});
	
			// Go List
			let goList = function() {
				location.href="sale.do";
			}
		</script>

</body>
</html>