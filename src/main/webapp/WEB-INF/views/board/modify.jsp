<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ include file="../includes/header.jsp" %>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Modify</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Modify
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        
                        <form action="/board/modify" method="post">
                       		<div class="form-group">
                       			<label>Bno</label> <input type="text" class="form-control" name="bno" value="${board.bno}" readonly>
                       		</div>
                       		<div class="form-group">
                       			<label>Title</label> <input type="text" class="form-control" name="title" value="${board.title}">
                       		</div>
                       		<div class="form-group">
                       			<label>Text area</label> <textarea class="form-control" rows="3" name="content">${board.content}</textarea>
                       		</div>
                       		<div class="form-group">
                       			<label>Writer</label> <input type="text" class="form-control" name="writer" value="${board.writer}" readonly>
                       		</div>
                       		<div class="form-group">
                       			<label>RegDate</label>
                       			<input type="text" class="form-control" name="regdate" value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}" />' readonly>
                       		</div>
                       		<div class="form-group">
                       			<label>Update Date</label>
                       			<input type="text" class="form-control" name="updatedate" value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updatedate}" />' readonly>
                       		</div>
                       		<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
                       		<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
                       		<button type="submit" data-oper="list" class="btn btn-info">List</button>
                       		
                       		<input type="hidden" name="pageNum" value="${cri.pageNum}">
                       		<input type="hidden" name="amount" value="${cri.amount}">
                       		<input type="hidden" name="type" value="${cri.type}">
                       		<input type="hidden" name="keyword" value="${cri.keyword}">
                   		</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
        </div>
        <!-- /#page-wrapper -->
        
        <script type="text/javascript">
        	$(document).ready(function() {
        		var formObj = $('form');
        		
        		$('button').click(function(e) {
        			e.preventDefault();
        			
        			var operation = $(this).data("oper");
        			
        			if (operation === "remove") {
        				formObj.attr("action", "/board/remove");
        			} else if (operation === "list") {
        				//self.location = "/board/list";
        				//return;
        				formObj.attr("action", "/board/list").attr("method", "get");
        				var pageNumTag = $("input[name='pageNum']").clone();
        				var amountTag = $("input[name='amount']").clone();
        				var keywordTag = $("input[name='keyword']").clone();
        				var typeTag = $("input[name='type']").clone();
        				
        				formObj.empty();
        				formObj.append(pageNumTag);
        				formObj.append(amountTag);
        				formObj.append(keywordTag);
        				formObj.append(typeTag);
        			}
        			formObj.submit();
        		});
        	});
        </script>

<%@ include file="../includes/footer.jsp" %>
