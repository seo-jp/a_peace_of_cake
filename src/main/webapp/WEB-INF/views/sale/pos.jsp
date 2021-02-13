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
			<div class="pos_list">
				<table>
					<tbody id="pos_tab">
						<tr>
							<th>商品名</th>
							<th>価格</th>
							<th>割引</th>
							<th>数量</th>
							<th>総額</th>
							<th></th>
						</tr>
					</tbody>
				</table>
				<p>総額 : ￥<span id="all">0</span></p>
			</div>
			
			<div class="pos_menu">
				<ul>
				<c:forEach items="${list}" var="list">
					<li onClick="addList(${list.p_id},'${list.p_name}',${list.p_price})">
						<span>${list.p_name}</span>
					</li>
				</c:forEach>
				</ul>
				<%-- <div class="pagingImg">
					<a class="left" onClick="selectPaging('prev')">
						<img src="${pageContext.request.contextPath}/resources/images/common/arrow.png" alt="paging" />
					</a>
					<a class="right" onClick="selectPaging('next')">
						<img src="${pageContext.request.contextPath}/resources/images/common/arrow.png" alt="paging" />
					</a>
				</div> --%>
			</div>
			
			<div class="pos_confirm">
				<ul>
					<li><a onClick="goRefund()">払い戻し</a></li>
					<li><a onClick="cancelAll()">中止</a></li>
					<li><a onClick="addSale()">会計</a></li>
				</ul>
			</div>
		</div>
		
	</div>
	
	<script>
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


		/* pos */

		let num = 0;
		let tab = document.getElementById('pos_tab'); 
		
		let addList = function(p_id,p_name,p_price) {

			let chk = chkSame(p_id,p_price);
			if(chk != 1){

				num ++;
				
				let newTr = document.createElement('tr');
				newTr.setAttribute("id",num);
	
				tab.appendChild(newTr);
				newTr.innerHTML = '<td><input type="hidden" class="p_id" value="' + p_id + '" />' + p_name + '</td>'
								+ '<td>￥' + p_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</td>'
								+ '<td><input type="number" class="p_discount" min="0" step="10" max="100" value="0" id="'+num+'p_discount"'
								+ 'onChange="calcPrice('+ num +',' + p_price + ',0)"/> %</td>'
								+ '<td><input type="number" class="p_amount" min="1" step="1" max="100" value="1" id="'+num+'p_amount"'
								+ 'onChange="calcPrice('+ num +',' + p_price + ',1)"/> 個</td>'
								+ '<td>￥<input type="hidden" class="allprice" value="' + p_price + '" id="'+num+'p_allprice" /><span id="'+ num + 'td">' +  p_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</span> </td>'
								+ '<td><input type="button" value="-" onClick="cancle(' + num + ')"/></td>'
								+ '<td><input type="hidden" class="number" value="' + num + '" /></td>';
			}

			calcAllPrice();
			
		}

		let chkSame = function(p_id,p_price) {
			let allP_id = document.querySelectorAll(".p_id");
			let allP_am = document.querySelectorAll(".p_amount");
			let number = document.querySelectorAll(".number");
				
			let rs = 0;
			
			var i = 0;
			
			if (allP_id.length > 0) {
				while(i<allP_id.length){
					if(p_id == allP_id[i].value){
						allP_am[i].value = Number(allP_am[i].value) + 1;
						calcPrice(number[i].value,p_price,1);
						rs = 1;
					}
					i = i+1;
				}
			}

			return rs;
		}

		let calcAllPrice = function() {
			let all = document.querySelectorAll(".allprice");
			let res = 0;

			var i = 0;
			while(i<all.length){
				res += Number(all[i].value);
				i = i+1;
			}
			document.querySelector('#all').innerHTML = res.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		let calcPrice = function(num,p_price,state) {
			const p_amount = Number(document.getElementById(num+'p_amount').value);
			const p_discount = Number(document.getElementById(num+'p_discount').value);
			const dcprice = p_price - (p_price * (p_discount / 100));
			const result = Math.ceil(dcprice * p_amount);

			let td = document.getElementById(num+'td');
			td.innerHTML = result.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
			document.getElementById(num+'p_allprice').value = result;

			calcAllPrice();
		}
		
		
		let cancle = function(num) {
			let target = document.getElementById(num);
			tab.removeChild(target);
			calcAllPrice();
		}

		let goRefund = function() {
			location.href="posRefund.do";
		}

		let cancelAll = function() {
			 location.reload();
		}

		let addSale = function() {
			
			let cnt = tab.rows.length - 1;
			let res = 0;

			let p_ids = new Array();
			let p_amounts = new Array();
			let p_discounts = new Array();
			let p_allprices = new Array();
			
			var i = 0;
			while(i<cnt){
				p_ids[i] = document.querySelectorAll(".p_id")[i].value;
				p_amounts[i] = document.querySelectorAll(".p_amount")[i].value;
				p_discounts[i] = document.querySelectorAll(".p_discount")[i].value;
				p_allprices[i] = document.querySelectorAll(".allprice")[i].value;
				i = i+1;
			}

			if(cnt>0){
				if (window.confirm("本当に会計しますか?")) {
			        $.ajax({
			        	url : 'saleInsert.do',
			        	type : 'POST',
			        	traditional : true,
			        	data : {
			        		p_ids : p_ids,
							p_amounts : p_amounts,
							p_discounts : p_discounts,
							p_allprices : p_allprices
			        	},
			        	//Ajax success
			        	success : function(data){
				        	alert("会計しました。");
							location.reload();
			        	},
			        	//Ajax fail
			        		error : function(jqXHR, textStatus, errorThrown){
				        		alert("在庫が足りないです.")
			        	        //console.log("jqXHR : " +jqXHR +"textStatus : " + textStatus + "errorThrown : " + errorThrown);
			        	}
			        });
			      }
			}

		}


	</script>

</body>
</html>