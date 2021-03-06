<%@page import="kr.co.redbull.code.service.Code"%>
<%@page import="kr.co.redbull.cmn.StringUtil"%>
<%@page import="kr.co.redbull.cmn.Search"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<%--
  /**
  * @Class Name : board_list.jsp
  * @Description : 게시판 list
  * @Modification Information
  *
  *   수정일                   수정자                      수정내용
  *  -------    --------    ---------------------------
  *  2018.04.26            최초 생성
  *
  * author SIST 개발팀
  * since 2019.09.24
  *
  * Copyright (C) 2009 by KandJang  All right reserved.
  */
--%>
<%
	/**페이지 사이즈*/
	String pageSize = "10";	
	/**페이지 번호*/	
	String pageNum = "1";
	/**검색조건*/
	String searchDiv = "10";
	/**검색어*/
	String searchWord = "";	

	Search vo = (Search)request.getAttribute("vo");
	
	if(null!=vo){
		pageSize   = StringUtil.nvl(vo.getPageSize()+"", "10");
		pageNum    = StringUtil.nvl(vo.getPageNum()+"", "1");
		searchDiv  = StringUtil.nvl(vo.getSearchDiv(), "");
		searchWord = StringUtil.nvl(vo.getSearchWord(), "");
	}else{
		pageSize   = "10";
		pageNum    = "1";
		searchDiv  = "10";
		searchWord = "";
	}
	
	//paging
	//maxNum, currPageNo, rowPerPage, bottomCount, url, scriptName
	
	int maxNum      = 0;  //totalCnt
	int bottomCount = 10;
	int currPageNo  = 1;  //pageNum
	int rowPerPage  = 10; //pageSize
	
	String url 	  	  = request.getContextPath()+"/board/get_retrieve.do";
	String scriptName = "search_page"; 
	
	//totalCnt
	String totalCnt = (request.getAttribute("totalCnt")==null)? "0":request.getAttribute("totalCnt").toString();
	
	maxNum     = Integer.parseInt(totalCnt);
	currPageNo = Integer.parseInt(pageNum);
	rowPerPage = Integer.parseInt(pageSize);
	
%> 
<html lang="ko">
  <head>
  <style type="text/css">
	.title:hover{
		cursor: pointer;
		text-decoration: underline;
	}
	#listTable{
		font-size: 12;
	}
  </style>
  
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>게시판</title>

    <!-- 부트스트랩 -->
    <link href="${context}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

  </head>
 
  <body>
  <jsp:include page="/main/header.jsp"></jsp:include>
    <!--================Home Banner Area =================-->
	<section class="banner_area">
		<div class="banner_inner d-flex align-items-center">
			<div class="container">
				<div
					class="banner_content d-md-flex justify-content-between align-items-center">
					<div class="mb-3 mb-md-0">
						<h2>공지사항</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Home Banner Area =================-->

    <!-- div container -->
   <div class="container">
    <br/>   
      <!-- Grid영역 -->
 	<div class="table-responsive">
			<table class="table  table-striped table-bordered table-hover" id="listTable">
				<thead>
				    <th class="text-center col-md-1 col-xs-1">글번호</th>
					<th class="text-center col-md-8 col-xs-8">제목</th>
					<th class="text-center col-md-1 col-xs-1 ">조회수</th>
					<th class="text-center col-md-1 col-xs-1">등록자</th>
					<th class="text-center col-md-1 col-xs-1">등록일</th>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${list.size()>0 }">
							<c:forEach var="vo" items="${list}">
								<tr>
									<td class="text-center bNum"><c:out value="${vo.bNum}"/></td>
									<td class="text-left title"><c:out value="${vo.title}"/>
									(<c:choose>
										<c:when test="${empty vo.commentCnt}"> 
											<c:out value="0"/>
										</c:when>
										<c:otherwise>
											<c:out value="${vo.commentCnt}"></c:out>
										</c:otherwise>
									</c:choose>)
									</td>
									<td class="text-center"><c:out value="${vo.readCnt}"/></td>
									<td class="text-center"><c:out value="${vo.regId}"/></td>
									<td class="text-center"><c:out value="${vo.regDt }"/></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr><td class="text-center" colspan="99">등록된 글이 없습니다.</td></tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
      <!--// Grid영역 -->
      
      <!-- pagenation -->
      <div class="text-center">
      	<%=StringUtil.renderPaging(maxNum, currPageNo, rowPerPage, bottomCount, url, scriptName) %>
      </div>
      <!--// pagenation -->
      
      <!-- 검색영역 -->
   <!--    <div class="row"> -->
       <div class="col-md-12 text-center">
       <form class="form-inline" name="boardFrm" id="boardFrm" method="get">
       	<input type="hidden" name="pageNum" id="pageNum" value="${vo.pageNum}" />
       	<input type="hidden" name="searchDiv" id="searchDiv" />
       	<input type="hidden" name="bNum" id="bNum" />
        <div class="form-group ">
      <div class="col-sm-12">
      <input type="text"  class="form-control input-sm " id="searchWord" name="searchWord" 
       placeholder="검색어" />
      <button type="button" class="btn btn-success btn-sm" id="do_retrieve">검색</button>  
      <button type="button" class="btn btn-success btn-sm" id="do_write">글쓰기</button>  
      </div>
     
      </div>
      </form>
    <!--     </div>  -->
      </div>
      <!--// 검색영역 -->  
      <form class="form-inline" name="writeForm" id="writeForm" method="get">
       	<input type="hidden" name="searchDiv" id="searchDiv" />
      </form>
   </div>
   <jsp:include page="/main/footer.jsp"></jsp:include>
    <!--// div container -->
    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="${context}/resources/js/jquery-1.12.4.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="${context}/resources/js/bootstrap.min.js"></script>    
    <script type="text/javascript">
    	
    	$("#do_write").on("click", function(){
    		var frm = document.writeForm;
    		frm.searchDiv.value="10";
    		frm.action = "${context}/board/do_write.do";
    		frm.submit();
    	});
    
    	function search_page(url, pageNum){
    		var frm = document.boardFrm;
    		frm.pageNum.value = pageNum;
    		frm.searchDiv.value = "10";
			frm.action = url;
			frm.submit();
    	}
    	
    	$("#listTable>tbody").on("click", "tr", function(){
    		//alert('listTable');
    		var trs = $(this);
			var td  = trs.children();
			if(null==td || td.length==1)return;
			//console.log(td.text());
			
    		var bNum = td.eq(0).text();
    		//console.log(bNum);
    		
    	 	var frm = document.boardFrm;
    		frm.bNum.value = bNum;
    		frm.action = "${context}/board/get_selectOne.do";
    		frm.submit(); 
    		
    	});	
    
    	function do_retrieve(){
    		
    		var searchWord = $("#searchWord").text();
    		
    		var frm = document.boardFrm;
    		frm.searchDiv.value = 10;
    		frm.pageNum.value = 1;
    		frm.submit();
    	}
    
    	$("#do_retrieve").on("click", function(){
    		//alert('doRetrieve');
    		do_retrieve();
    	});
    
    	$(document).ready(function(){
    		//alert('ready');
    	});
    	
    	
    </script>
  </body>
</html>