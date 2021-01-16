<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/pl.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<div class="view_form spend_form">
		
		<form action="spendInsert.do" method="post">
			<table>
				<tr class="hidden_box">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex}"/>
					<input type="hidden" name="viewType" id="viewType" value="${viewType}"/>
					<input type="hidden" name="searchDate" id="searchDate" value="${searchDate}"/>
				</tr>
				<tr>
					<th><label for="sp_name">カテゴリー</label></th>
					<td>
						<select name="sp_name">
							<option value="인건비">人件費</option>
							<option value="전기세">電気料金</option>
							<option value="가스비">ガス料金</option>
							<option value="수도세">水道料金</option>
							<option value="임대료">賃貸</option>
							<option value="기타">その他</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><label for="sp_price">価格</label></th>
					<td>￥<input type="number" name="sp_price" id="sp_price" min="1" max="1000000" /></td>
				</tr>
			</table>
			
			<div class="form_btn_box">
				<a onClick="goList()">一覧</a>
				<input type="submit" value="登録" onClick="nullChk()" />
			</div>
		</form>
	</div>
	
	
	<script>
		// null Check
		let nullChk = function() {
			let category = document.querySelector('select[name=sp_name]').value;
			let price = document.querySelector('input[name=sp_price]').value;
			if(price == ''){
				alert('価格を入力してください。');
				event.preventDefault();
				event.stopPropagation();
			}else{
				submit();
			}
		}
		
		// Go List
		let goList = function() {
			location.href="pl.do?viewType=${viewType}&pageIndex=${pageIndex}&searchDate=${searchDate}";
		}
	</script>

</body>
</html>