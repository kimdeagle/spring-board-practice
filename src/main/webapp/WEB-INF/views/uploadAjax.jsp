<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.uploadResult {
		width: 100%;
		background-color: gray;
	}
	
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	
	.uploadResult ul li img {
		width: 20px;
	}
	
	.uploadResult ul li span {
		color: white;
	}
	
	.bigPictureWrapper {
		position: absolute;
		display: none;
		justify-content: center;
		align-items: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: gray;
		z-index: 100;
		background: rgba(255, 255, 255, 0.5);
	}
	
	.bigPicture {
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img {
		width: 600px;
	}
</style>
<body>
	<h1>Upload with Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class="uploadResult">
		<ul>
			
		</ul>
	</div>
	
	<button id="uploadBtn">Upload</button>
	
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	
	<script>
	
		function showImage(fileCallPath) {
			//alert(fileCallPath);
			$(".bigPictureWrapper").css("display", "flex").show();
			
			$(".bigPicture").html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>").animate({width: '100%', height: '100%'}, 1000);
		}	
	
		$(document).ready(function() {
			
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); //정규표현식
			var maxSize = 5242880; //5MB
			
			function checkExtension(fileName, fileSize) {
				if (fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				
				if (regex.test(fileName)) {
					alert("해당 종류 파일은 업로드 할 수 없습니다.");
					return false;
				}
				return true;
			}			
			
			var cloneObj = $(".uploadDiv").clone();
			
			$("#uploadBtn").click(function(e) {
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;
				
				console.log(files);
				
				for (var i=0; i<files.length; i++) {
					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url: "/uploadAjaxAction",
					processData: false,
					contentType: false,
					data: formData,
					type: "POST",
					dataType: "json",
					success: function(result) {
						//alert("Uploaded");
						
						console.log(result);
						
						showUploadedFile(result);
						
						$(".uploadDiv").html(cloneObj.html());
						
					}
				});
				
			});
			
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr) {
				
				var str = "";
				
				$(uploadResultArr).each(function(i, obj) {
					if (!obj.image) {
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						str += "<li><a href='/download?fileName=" + fileCallPath + "'><img src='/resources/img/sample.png'>" + obj.fileName + "</a></li>";
					} else {
						//str += "<li>" + obj.fileName + "</li>";
						
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						
						var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
						originPath = originPath.replace(new RegExp(/\\/g), "/");
						
						str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName=" + fileCallPath + "'></a></li>";
					}
					
				});
				
				uploadResult.append(str);
				
			}
			
			$(".bigPictureWrapper").click(function(e) {
				$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
				setTimeout(function() {
					$(".bigPictureWrapper").hide();
				}, 1000);
			});
			
		});
	</script>
	
</body>
</html>