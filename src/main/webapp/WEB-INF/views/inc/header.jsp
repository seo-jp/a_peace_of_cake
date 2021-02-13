<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<script type="text/javascript">
		function goPage(value){
			if(value == 1) location.href="${pageContext.request.contextPath}/home.do";
			if(value == 2) location.href="${pageContext.request.contextPath}/employee/mypage.do";
			if(value == 3) location.href="${pageContext.request.contextPath}/employee/logout.do";

			if(value == 4) location.href="${pageContext.request.contextPath}/product/product.do"; //품목관리
			if(value == 5) location.href="${pageContext.request.contextPath}/order/order.do"; //재료발주
			if(value == 6) location.href="${pageContext.request.contextPath}/order/orderList.do"; //발주관리 = 매입관리
			if(value == 7) location.href="${pageContext.request.contextPath}/sale/sale.do"; //판매현황 > 판매관리에 판매현황을 넣어버리고 판매관리는 .. 따로빼버리자 ..
			if(value == 8) location.href="${pageContext.request.contextPath}/pl/pl.do"; //손익현황
			if(value == 9) location.href="${pageContext.request.contextPath}/stock/stock.do"; //재고관리
		}
	</script>	
	
	<header>
		<h1><a onclick="goPage(1)" class="logo">
			<img src="${pageContext.request.contextPath}/resources/images/common/logo.png" alt="logo" />
		</a></h1>
		<div class="mypage_box">
			<ul>
				<c:if test="${sessionID ne null }">
					<li><a>
						<img src="${pageContext.request.contextPath}/resources/images/common/main_login_icon.png" alt="logo" />
						<span>${sessionID} 様</span>
					</a></li>
					<li><a onclick="goPage(3)">ログアウト</a></li>
				</c:if>
			</ul>
		</div>
		<nav>
			<ul>
				<li><a onclick="goPage(4)">
					<img src="${pageContext.request.contextPath}/resources/images/common/menu1.png" alt="product" />
					<span>商品管理</span>
				</a></li>
				<li><a onclick="goPage(9)">
					<img src="${pageContext.request.contextPath}/resources/images/common/menu2.png" alt="stock" />
					<span>在庫管理</span>
				</a></li>
				<li><a onclick="goPage(5)">
					<img src="${pageContext.request.contextPath}/resources/images/common/menu3.png" alt="product" />
					<span>材料発注</span>
				</a></li>
				<li><a onclick="goPage(6)">
					<img src="${pageContext.request.contextPath}/resources/images/common/menu4.png" alt="product" />
					<span>発注管理</span>
				</a></li>
				<li><a onclick="goPage(7)">
					<img src="${pageContext.request.contextPath}/resources/images/common/menu5.png" alt="product" />
					<span>売上一覧</span>
				</a></li>
				<li><a onclick="goPage(8)">
					<img src="${pageContext.request.contextPath}/resources/images/common/menu6.png" alt="product" />
					<span>損益計算</span>
				</a></li>
			</ul>
		</nav>	
	</header>
</body>
</html>