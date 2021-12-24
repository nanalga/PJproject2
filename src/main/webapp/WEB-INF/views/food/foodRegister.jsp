<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<title>Insert title here</title>
</head>
<body>

<!-- .container>.row>.col>h1{맛집 작성} -->
<div class="container">
	<div class="row">
		<div class="col">
			<h1>맛집 작성</h1>
			
			<!-- form>.form-group*3>label[for=input$]+input.form-control#input$ -->
			<form method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="input1">제목</label>
					<input type="text" class="form-control" id="input1" name="title">
				</div>
				<div class="form-group">
					<label for="input2">내용</label>
					<textarea type="text" class="form-control" id="input2" name="contents"></textarea>
				</div>
				
				<!-- .form-group>label[for=input4]+input[type=file].form-control-file#input4[name=files] -->
				<div class="form-group">
					<label for="input4">이미지 파일 첨부</label>
					<input type="file" class="form-control-file" id="input4" name="files" accept="image/*" multiple>
				</div>
				
				<div class="form-group">
					<label for="input3">작성자</label>
					<input type="text" class="form-control" id="input3" readonly>
				</div>
				
				<button class="btn btn-outline-primary" type="submit">등록</button>
				
			</form>
			
		</div>
	</div>
</div>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>
</html>