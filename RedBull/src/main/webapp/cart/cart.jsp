<%@page import="kr.co.redbull.user.service.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />

<%
	User user = (User)session.getAttribute("user");
	/* out.println("user: " + user); */
%>
<html lang="ko">
 

 <style>
 	#cartCnt{
 		width: 3em;
 	}
 
 	.right-box{
 		float : right;
 	}
 
	#updatebtn{
		color: black;
	}
</style> 
	<jsp:include page="/main/header.jsp"></jsp:include>
 
  <body>
 
  
    <!--================Header Menu Area =================-->
 
    <!--================Header Menu Area =================-->

    <!--================Home Banner Area =================-->
    <section class="banner_area">
      <div class="banner_inner d-flex align-items-center">
        <div class="container">
            <div class="mb-1 mb-md-0">
              <h2>장바구니</h2>
            </div>
        </div>
      </div>
    </section>
    <!--================End Home Banner Area =================-->
    <!--================Cart Area =================-->
    <section class="cart_area">
      <div class="container">
        <div class="cart_inner">
          <div class="table-responsive">
         <form name="cartFrm" method="get" action="${context}/cart/do_update.do">
         <input type="hidden" name="cartNum" id="cartNum"/>
		 <input type="hidden" name="oNum" id="oNum"/>
          <input type="hidden" name="searchDiv" id="searchDiv" />
            <table class="table table-striped table-bordered table-hover">
              <thead>
                <tr>
                	 <th class="text-center hidden-xs hidden-sm hidden-md hidden-lg ">카트수량</th>
                	 <th class="text-center hidden-xs hidden-sm hidden-md hidden-lg ">옵션번호</th>
			         <th class="text-center col-md-1 col-xs-1">
					 전체선택<input type="checkbox" id="checkAll" name="checkAll"></th>
			         <th class="text-center col-md-4 col-xs-4 ">상품</th>
			         <th class="text-center col-md-1 col-xs-1">상품가격</th>
			         <th class="text-center col-md-1 col-xs-1">옵션가격</th>
			         <th class="text-center col-md-1 col-xs-1">수량</th>
			         <th class="text-center col-md-1 col-xs-1">배송비</th>
			         <th class="text-center col-md-1 col-xs-1">최종 가격</th>
                </tr>
              </thead>

              <tbody>
               <c:choose>
	        	<c:when test="${list.size()>0 }">
	        		<c:set var="sum" value="0"></c:set>
	        		<c:set var="count" value="0"></c:set>
	                <c:forEach var="cart" items="${list}">
	                <tr>
	                <td class='text-center hidden-xs hidden-sm hidden-md hidden-lg'><c:out value="${cart.cartCnt }"/></td>
	                <td class='text-center hidden-xs hidden-sm hidden-md hidden-lg'><c:out value="${cart.oNum }"/></td>
	                <td class="text-center">
		                 <input type="checkbox"  name="chBox" id="chBox"  data-cartNum="${cart.cartNum }"/>
	                </td>
	                 <td>
	                    <div class="media">
	                      <div class="media-left"> 
	                        <img src="${context}/${cart.saveFileNm}" class="media-object" style="width: 80px"  alt="이미지 없음" />
	                      </div>
	                      
	                      <div class="media-body">
	                     	 	<c:out value="${cart.pName}"/><br/>
	                     	 옵션:<c:out value="${cart.oName}"/>
	                      </div>
	                    </div>
	                  </td>
	                  
	                  <td class="text-center">
		                  <del><fmt:formatNumber pattern="###,###,###" value="${cart.bPrice }"/></del><br/>
		                  <fmt:formatNumber pattern="###,###,###" value="${cart.bPrice * (1-cart.discount)}"/>원
	                  </td>
	                  
	                  <td class="text-center">
	                  <fmt:formatNumber pattern="###,###,###"  value="${cart.oPrice}" />원
	                  </td>
	                  
				       <td class="text-center">
				        	 <fmt:formatNumber pattern="###,###,###"  value="${cart.cartCnt}" />
	       					<a href="#" class="upCnt"  >▲</a><a href="#" class="downCnt" >▼</a>
				       </td>
				       
	                  <td class="text-center">
	                    <fmt:formatNumber pattern="###,###,###" value="${cart.dPrice }"/>원
	                  </td>
	                  <td class="text-center">
	                   <fmt:formatNumber pattern="###,###,###" value="${(cart.bPrice * (1-cart.discount) + cart.oPrice) * cart.cartCnt + cart.dPrice}" />원
	                  </td>
	                </tr>
	                <c:set var="sum" value="${sum+ (cart.bPrice * (1-cart.discount) + cart.oPrice) * cart.cartCnt + cart.dPrice }"></c:set>
	                <c:set var="count" value="${count+ cart.cartCnt }"></c:set>
	            </c:forEach> 
			    </c:when>
			    
			    <c:otherwise>
			         	<tr>
			         		<td class="text-center" colspan="99">장바구니가 비었습니다.</td>
			         	</tr>
			    </c:otherwise>
			</c:choose>

             </tbody>
            </table>
            <button type="button" id="do_delete" data-cartNum="${cart.cartNum }">삭제하기</button>
            
             <hr/>
             	<h5 align="right">총 수량: <input type="text" id="count" size="7" style="text-align: center;"  value="${count }" />개</h5>
            	<h3 align="right">결제금액:<input type="text" id="sum" size="7" style="text-align: center;"  value="<fmt:formatNumber pattern="###,###,###" value="${sum }" />"/>원</h3> 
             <hr/>
             </form>
                <div class="right-box" >
                	<a class="main_btn" href="${context}/product/get_retrieve.do">쇼핑하기</a>
                	<button type="submit" class="main_btn" id="payBtn" value="결제하기">결제하기</button>
                </div>
          </div>
        </div>
      </div>
    </section>
    <!--================End Cart Area =================-->
        <!-- Optional JavaScript -->
      	<script type="text/javascript">
        
       	$("#payBtn").on("click",function(){
      		alert("결제하시겠습니까?");
      		
      		var amount = $("#sum").val();
      		
      		console.log("amount: " + amount);
      		
      		location.href = "${context}/pay/get_retrieve.do";
      	}); 
      	
       	
      	//수량 증가
   	 	   $(".upCnt").on("click", function(){
   		 
   	 		var upCnt = $(this).val();
   	 		var tr = $(this).parent().parent();
   	 		var td = tr.children();
   	 		
   	 		var sst = parseInt(td.eq(0).text())+1;
   	 		var oNum = td.eq(1).text();
   	 		
   	 		//alert("oNum:" +oNum);
   	 		//alert("sst:" +sst);
   	 		$(".upCnt").val('111');
	    	//if(false==confirm("수정 하시겠습니까?"))return;
	    	
	    	console.log("oNum: "+ oNum);
	    	console.log("sst: "+ sst);
	    	
	    	
			$.ajax({
	            type:"POST",
	            url:"${context}/cart/do_update.do",
	            dataType:"html",
	            data:{
	            	
	            	 "oNum" : oNum,
	            	  cartCnt : sst
	            },
	            success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
	            	var parseData = $.parseJSON(data);
	            	if(parseData.msgId=="1"){
	            		//alert(parseData.msgMsg);
	            		location.href = "${context}/cart/get_retrieve.do";
	            	}else{
	            		alert(parseData.msgMsg);
	            	}
	            },
	            complete: function(data){//무조건 수행
	             
	            },
	            error: function(xhr,status,error){
	             
	            }
	        });	
      		
      	}); 
      	
      	
      	//수량 감소
   	 	$(".downCnt").on("click", function(){
      		 
   	 		var upCnt = $(this).val();
   	 		var tr = $(this).parent().parent();
   	 		var td = tr.children();
   	 		
   	 		var sst = parseInt(td.eq(0).text())-1;
   	 		var oNum = td.eq(1).text();
   	 		
   	 		//alert("oNum:" +oNum);
   	 		//alert("sst:" +sst);
	    	//if(false==confirm("수정 하시겠습니까?"))return;
	    	
	    	console.log("oNum: "+ oNum);
	    	console.log("sst: "+ sst);
	    	
	    	
			$.ajax({
	            type:"POST",
	            url:"${context}/cart/do_update.do",
	            dataType:"html",
	            data:{
	            	
	            	 "oNum" : oNum,
	            	  cartCnt : sst
	            },
	            success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
	                //console.log(data);
	            	//{"msgId":"1","msgMsg":"수정 되었습니다.","totalCnt":0,"num":0}
	            	var parseData = $.parseJSON(data);
	            	if(parseData.msgId=="1"){
	            		//alert(parseData.msgMsg);
	            		location.href = "${context}/cart/get_retrieve.do";
	            	}else{
	            		alert(parseData.msgMsg);
	            	}
	            },
	            complete: function(data){//무조건 수행
	             
	            },
	            error: function(xhr,status,error){
	             
	            }
	        });	
      		
      	}); 
      	
      	 //체크박스
      	$("#checkAll").on("click",function(){
     			if($("#checkAll").is(':checked')==true){
       				$("input[name='chBox']").prop("checked",true); //check
       				
       			}else{
       				$("input[name='chBox']").prop("checked",false); //check해제
       			}
      	  });
		
		//삭제
		$("#do_delete").on("click",function(){
			
			var confirm_val = confirm("정말 삭제하시겠습니까?");
			
			if(confirm_val){
				var checkArr = new Array();
				
				$("input[name='chBox']:checked").each(function(){
					checkArr.push($(this).attr("data-cartNum"));
				});
				
				$.ajax({
					 url : "${context}/cart/do_delete.do",
					 type : "POST",
					 data : { 
						 		chbox : checkArr 
						 	},
					 success : function(result){
					  if(result == 1) {          
						  alert("상품이 삭제되었습니다.");
					   	  location.href = "${context}/cart/get_retrieve.do";
					  } else {
					   alert("삭제 실패");
					  }
					 }
				}); //--ajax
			}
		});
	</script>
    <!--================ start footer Area  =================-->
    	<jsp:include page="/main/footer.jsp"></jsp:include>
    <!--================ End footer Area  =================-->
    
  </body>
</html>