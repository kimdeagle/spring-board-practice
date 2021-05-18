<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%@ include file="../includes/header.jsp" %>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Read</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Read
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                       		<div class="form-group">
                       			<label>Bno</label> <input type="text" class="form-control" name="bno" value="${board.bno}" readonly>
                       		</div>
                       		<div class="form-group">
                       			<label>Title</label> <input type="text" class="form-control" name="title" value="${board.title}" readonly>
                       		</div>
                       		<div class="form-group">
                       			<label>Text area</label> <textarea class="form-control" rows="3" name="content" readonly>${board.content}</textarea>
                       		</div>
                       		<div class="form-group">
                       			<label>Writer</label> <input type="text" class="form-control" name="writer" value="${board.writer}" readonly>
                       		</div>
                       		<button data-oper="modify" class="btn btn-default">Modify</button>
                       		<button data-oper="list" class="btn btn-info">List</button>
                       		
                       		<form id="operForm" action="/board/modify" method="get">
                       			<input type="hidden" id="bno" name="bno" value="${board.bno}">
                       			<input type="hidden" name="pageNum" value="${cri.pageNum}">
                       			<input type="hidden" name="amount" value="${cri.amount}">
                       			<input type="hidden" name="keyword" value="${cri.keyword}">
                       			<input type="hidden" name="type" value="${cri.type}">
                       		</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- /.댓글 -->
            <div class="row">
            	<div class="col-lg-12">
            		<div class="panel panel-default">
            			<div class="panel-heading">
            				<i class="fa fa-comments fa-fw"></i> Reply
            				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
            			</div>
            			
            			<div class="panel-body">
            				<ul class="chat">
            					<li class="left clearfix" data-rno="12">
            						<div>
            							<div class="header">
            								<strong class="primary-font">user00</strong>
            								<small class="pull-right text-muted">2018-01-01 13:13 </small>
            							</div>
            							<p>Good Job!</p>
            						</div>
            					</li>
            				</ul>
            			</div>
            			
            			<div class="panel-footer">
            				
            			</div>
            		</div>
            	</div>
            </div>
            <!-- /.댓글 -->
            
        </div>
        <!-- /#page-wrapper -->
        
        <!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>Reply</label>
							<input type="text" class="form-control" name="reply" value="New Reply!">
						</div>
						<div class="form-group">
							<label>Replyer</label>
							<input type="text" class="form-control" name="replyer" value="replyer">
						</div>
						<div class="form-group">
							<label>Reply Date</label>
							<input type="text" class="form-control" name="replyDate" value="">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="modalModBtn" class="btn btn-warning">Modify</button>
						<button type="button" id="modalRemoveBtn" class="btn btn-danger">Remove</button>
						<button type="button" id="modalRegisterBtn" class="btn btn-primary">Register</button>
						<button type="button" id="modalCloseBtn" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
        
        <script type="text/javascript" src="/resources/js/reply.js"></script>
        
        <script type="text/javascript">
        	$(document).ready(function() {
        		
        		var bnoValue = "${board.bno}";
        		var replyUL = $(".chat");
        		
        		showList(1);
        		
        		function showList(page) {
        			
        			replyService.getList({bno: bnoValue, page: page||1}, function(replyCnt, list) {
        				
        				if (page == -1) {
        					pageNum = Math.ceil(replyCnt/10.0);
        					showList(pageNum);
        					return;
        				}
        				
        				var str = "";
        				
        				if (list == null || list.length == 0) {
        					return;
        				}
        				
        				for (var i = 0, len = list.length || 0; i < len; i++) {
        			           str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
        			           str +="  <div><div class='header'><strong class='primary-font'>["
        			        	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
        			           str +="    <small class='pull-right text-muted'>"
        			               +replyService.displayTime(list[i].replyDate)+"</small></div>";
        			           str +="    <p>"+list[i].reply+"</p></div></li>";
        				}
        				
        				replyUL.html(str);
        				
        				showReplyPage(replyCnt);
        			});
        		}
        		
        		var pageNum = 1;
        		var replyPageFooter = $(".panel-footer");
        		
        		function showReplyPage(replyCnt) {
        			var endNum = Math.ceil(pageNum / 10.0) * 10;
        			var startNum = endNum - 9;
        			
        			var prev = startNum != 1;
        			var next = false;
        			
        			if (endNum * 10 >= replyCnt) {
			        	endNum = Math.ceil(replyCnt/10.0);
		        	}
        			
        			if (endNum * 10 < replyCnt) {
        				next = true;
        			}
        			
        			var str = "<ul class='pagination pull-right'>";
        			
        			if (prev) {
        				str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
        			}
        			
        			for (var i=startNum; i<=endNum; i++) {
        				var active = pageNum == i ? "active" : "";
        				
        				str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
        			}
        			
        			if (next) {
        				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
        			}
        			
        			str += "</ul></div>";
        			
        			console.log(str);
        			
        			replyPageFooter.html(str);
        			
        		}
        		
        		replyPageFooter.on("click", "li a", function(e) {
        			e.preventDefault();
        			
        			var targetPageNum = $(this).attr("href");
        			
        			pageNum = targetPageNum;
        			
        			showList(pageNum);        			
        		});
        		
        		var modal = $(".modal");
        		var modalInputReply = modal.find("input[name='reply']");
        		var modalInputReplyer = modal.find("input[name='replyer']");
        		var modalInputReplyDate = modal.find("input[name='replyDate']");
        		
        		var modalModBtn = $("#modalModBtn");
        		var modalRemoveBtn = $("#modalRemoveBtn");
        		var modalRegisterBtn = $("#modalRegisterBtn");
        		
        		$("#addReplyBtn").click(function(e) {
        			modal.find("input").val("");
        			modalInputReplyDate.closest("div").hide();
        			modal.find("button[id != 'modalCloseBtn']").hide();
        			
        			modalRegisterBtn.show();
        			
        			$(".modal").modal("show");
        		});
        		
        		modalRegisterBtn.click(function(e) {
        			var reply = {
       					reply: modalInputReply.val(),
       					replyer: modalInputReplyer.val(),
       					bno: bnoValue
        			};
        			replyService.add(reply, function(result) {
        				alert(result);
        				
        				modal.find("input").val("");
        				modal.modal("hide");
        				
        				//showList(1); //댓글 목록 갱신
        				showList(-1); //댓글 등록 시 마지막 페이지로 이동
        			});
        		});
        		
        		$(".chat").on("click", "li", function(e) {
        			var rno = $(this).data("rno");
        			
        			replyService.get(rno, function(reply) {
        				modalInputReply.val(reply.reply);
        				modalInputReplyer.val(reply.replyer);
        				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
        				modal.data("rno", reply.rno);
        				
        				modal.find("button[id != 'modalCloseBtn']").hide();
        				modalModBtn.show();
        				modalRemoveBtn.show();
        				
        				$(".modal").modal("show");
        			});
        			
        		});
        		
        		modalModBtn.click(function(e) {
        			var reply = {
        				rno: modal.data("rno"),
        				reply: modalInputReply.val()
        			};
        			
        			replyService.update(reply, function(result) {
        				alert(result);
        				modal.modal("hide");
        				showList(pageNum);
        			});
        		});
        		
        		modalRemoveBtn.click(function(e) {
        			var rno = modal.data("rno");
        			
        			replyService.remove(rno, function(result) {
        				alert(result);
        				modal.modal("hide");
        				showList(pageNum);
        			});
        		});

        		/*
        		console.log("====================");
        		console.log("JS TEST");
        		*/
        		        		
        		/* 댓글 추가 테스트 */
        		/*
        		replyService.add(
        			{
	        			reply: "JS TEST",
	        			replyer: "tester",
	        			bno: bnoValue
        			},
        			function(result) {
        				alert("RESULT: " + result);
        			}
        		);
        		*/
        		
        		/* 댓글 목록 테스트 */
        		/*
        		replyService.getList(
        			{
	        			bno: bnoValue,
	        			page: 1
        			},
        			function(list) {
        				for(var i=0, len=list.length||0; i<len; i++) {
        					console.log(list[i]);
        				}
        			}
        		);
        		*/
        		
        		/* 댓글 삭제 테스트 */
        		/*
        		replyService.remove(5, function(count) {
        			console.log(count);
        			
        			if (count === "success") {
        				alert("REMOVED");
        			}
        		}, function(err) {
        			alert("ERROR...");
        		});
        		*/
        		
        		/* 댓글 수정 테스트 */
        		/*
        		replyService.update({
        			rno: 20,
        			bno: bnoValue,
        			reply: "Modified Reply..."
        		}, function(result) {
        			alert("수정 완료");
        		});
        		*/
        		
        		/* 댓글 읽기 테스트 */
        		/*
        		replyService.get(10, function(data) {
        			console.log(data);
        		});
        		*/
        		
        		var operForm = $("#operForm");
        		
        		$("button[data-oper='modify']").click(function(e) {
        			operForm.attr("action", "/board/modify").submit();
        		});
        		
        		$("button[data-oper='list']").click(function(e) {
        			operForm.find("#bno").remove();
        			operForm.attr("action", "/board/list").submit();
        		});
        	});
        </script>

<%@ include file="../includes/footer.jsp" %>
