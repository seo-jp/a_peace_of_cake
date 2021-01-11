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
	
	<div class="pos_wrap">
		
		<ul class="top_pos">
			<li>担当者 : ${sessionID}様</li>
			<li><span class="clock"></span></li>
			<li><span class="date"></span></li>
		</ul>
		
		<div class="pos">
			
			<div class="pos_search">
				<h2>レシートの番号を入力してください。</h2>
				<form action="posRefundSearch.do" method="POST">
					<div><span>#</span><input type="number" name="s_group_id" min="0" value="${s_group_id}" /></div>
					<div><input type="submit" value="検索" /></div>
				</form>
			</div>
		
			<div class="pos_refund pos_list">
				<table>
					<tbody id="pos_tab">
						<tr>
							<th><input id="allChk" type="checkbox" onClick="allCheck()" /></th>
							<th>商品名</th>
							<th>価格</th>
							<th>割引</th>
							<th>数量</th>
							<th>総額</th>
						</tr>
						
						<c:forEach items="${list}" var="list">
							<tr>
								<td><input name="check" type="checkbox" value="${list.s_id}" /></td>
								<td>${list.s_name}</td>
								<td>${list.s_price}￥</td>
								<td>${list.s_discount}％</td>
								<td>${list.s_amount}個</td>
								<td><input id="${list.s_id}" type="hidden" value="${list.s_allprice}" />${list.s_allprice}￥</td>
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
				<p>総　払い戻し金額 : <span id="all">0</span> ￥</p>
			</div>
			
			<div class="pos_confirm">
				<ul>
					<li><a onClick="goRefund()">払い戻し</a></li>
					<li><a onClick="goPos()">POS</a></li>
				</ul>
			</div>
			
		</div>
		
	</div>
	
	<script>
	
		// Basic Setting
		$(document).ready(function(){
			$("input:checkbox[name='check']").change(function(){
		    	if($("input:checkbox[id='allChk']").is(":checked") == true)
		    		$("input:checkbox[id='allChk']").prop("checked", false);
		    	calcAllPrice();
		    });
		});
		
		const dateTarget = document.querySelector('.date');
		const clockTarget = document.querySelector('.clock');
	
		function clock() {
		    var date = new Date();
		    var month = date.getMonth();
		    var clockDate = date.getDate();
		    var day = date.getDay();
		    var week = ['日', '月', '火', '水', '木', '金', '土'];
		    var hours = date.getHours() < 10 ? '0'+date.getHours() : date.getHours();
		    var minutes = date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes();
		    
		    dateTarget .innerText = '${month+1}月 ' + clockDate + '日 ' +  week[day] + '曜日';
		    clockTarget .innerText = hours + ':' + minutes;
		}

		function init() {
			clock();
			setInterval(clock, 1000);
		}

		init();

		
		let goPos = function() {
			location.href="pos.do";
		}


		let calcAllPrice = function() {

			let res = 0;
			let arr = [];
			let cnt = document.querySelectorAll("input[name=check]:checked").length;
			
			console.log(cnt);

			for (var i=0; i<cnt; i++) {
	        	 arr[i] = document.querySelectorAll("input[name=check]:checked")[i].value;
	        	 res += Number(document.getElementById(arr[i]).value);
	        }

			console.log(arr);
			console.log(res);
			document.querySelector('#all').innerHTML = res;
		}


		// All Check
		let allCheck = function() {
			if($("input:checkbox[id='allChk']").is(":checked") == true){
				$("input:checkbox[name='check']").prop("checked", true);
				calcAllPrice();
	        }else{
	        	document.querySelector('#all').innerHTML = '0';
	        	$("input:checkbox[name='check']").prop("checked", false);
	        }
		}
		
		// Delete
		let goRefund = function() {
			let cnt = document.querySelectorAll("input[name=check]:checked").length;
		    let arr = [];
		    if(cnt == 0){
		    	alert("払い戻しする商品を選んでください。");
		    }
		    else{
		    	if (window.confirm("本当に払い戻ししますか？")) {

		        	for (var i=0; i<cnt; i++) {
		        	 arr[i] = document.querySelectorAll("input[name=check]:checked")[i].value;
		        	}
	
		        	$.ajax({
		        	    url : 'posRefundExe.do',
		        	    type : 'POST',
		        	    traditional : true,
		        	    data : {
		        	        s_ids : arr
		        	    },
		        	    //Ajax success
		        	    success : function(data){
		        	    	alert("払い戻ししました。");
		        	    	goPos();
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