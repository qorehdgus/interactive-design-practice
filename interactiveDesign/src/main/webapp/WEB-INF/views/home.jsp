<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	//회전 함수
	//pageX(마우스 포인터의 위치)가 0부터 시작하는 게 아니므로 처음 mousedown에서 pageX를 검출해 mousemove이벤트시 나오는 pageX와의 차를 회전에 이용하기위해 변수화 시킴
	var pageX=0;
	var rotate=0;
	var clickChk = false;
	function rotatePlus(rotate){
		for(i=0; i<$('.innerDiv').length; i++){
			$('.innerDiv').eq(i).css('transform','rotate('+(36*i)+'deg) rotate('+rotate+'deg)')
		}
	}
	//addEventListener와 removeEventListener는 매개변수 넣기가 까다로워 한번 거쳐서 보낸 것.
	function a(){
		//회전 정도 조절
		rotate+=(event.pageX-pageX)/50;
		rotatePlus(rotate);
	}
	$(()=>{
		//기본적으로 회전 한번 시킴.
		rotatePlus(rotate)
		//마우스 클릭시 transeform은 하나만 적용되는 걸 이용해 중앙에 옮김.
		$('.innerDiv').click(function(){
			if(clickChk==false){
				clickChk = true;
				$(event.target).addClass('clickDiv');
				$(event.target).css('transform','scale(1.2)');
				setTimeout(function(){
					$('.backgroundDiv').css('width','100%');				
				}, 500)
			}else{
				$('.backgroundDiv').css('width','0%');
				setTimeout(function(){
					$('.innerDiv').removeClass('clickDiv');
					rotatePlus(rotate);
					clickChk = false;
				}, 500)
			}
		})
		//드래그 이벤트 금지 시키기 (드래그 이벤트가 발생되면 마우스 업 이벤트가 생략됨)
		$('#menuDiv').on("dragstart",function(e){
            return false;
        });
		//drag이벤트가 잘 안먹혀서 마우스 다운, 업 이벤트로 대체함.
		$('#menuDiv').on({
			'mousedown':function(){
				//pageX 초기값 검출
				//click이벤트가 발생했을때 rotate되는 것을 막으려고 if문 설정
				if(clickChk!=true){
					pageX=event.pageX;
					window.addEventListener('mousemove',a);
				}
			},
		});
		$(window).on({
			'mouseup':function(){
				window.removeEventListener('mousemove',a);
			}
		});
	})
</script>
<style>
	body{
		margin:0px;
		padding:0px;
	}
	.backgroundDiv{
		position:absolute;
		background-color:pink;
		bottom:0px;
		width:0%;
		height:1000px;
		z-index:1;
		transition-duration:1s;
	}
	#menuDiv{
		position:fixed;
		bottom:-50px;
		left:50%;
		width:1400px;
		height:500px;
		transform:translate(-50%,0);
	}
	.innerDiv{
		position:absolute;
		top:0px;
		left:550px;
		float:left;
		width:250px;
		height:350px;
		transform-origin:50% 600Px;
		background-color:black;
		transition-duration:1s;
		/*큐빅 비지어 https://basemenks.tistory.com/281*/
		transition-timing-function:cubic-bezier(0.05, 0.9, 1, 1);
		opacity:0.5;
	}
	.clickDiv{
		z-index:2;
	}
</style>
</head>
<body>
	<div id='menuDiv'>
		<div class="backgroundDiv"></div>
		<div class="innerDiv"></div>
		<div class="innerDiv"></div>
		<div class="innerDiv"></div>
		<div class="innerDiv"></div>
		<div class="innerDiv"></div>
		<div class="innerDiv"></div>
		<div class="innerDiv"></div>
		<div class="innerDiv"></div>
		<div class="innerDiv"></div>
		<div class="innerDiv"></div>
	</div>
</body>
</html>