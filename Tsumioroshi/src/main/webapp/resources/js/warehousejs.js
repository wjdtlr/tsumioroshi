var rect;
		var container;
		var info;
		var nSW=5;
		var nStartX=0;
		var nStartY=0;
		window.onload=function(){
			rect = document.getElementById("drag");
			info = document.getElementById("info");
			container = document.getElementById("container");

			showInfo();

			rect.addEventListener("mousedown",on_DownRect,false);
			rect.addEventListener("dragend",on_Size,false);
		}

		function showInfo(){
			var strInfo	="";
			strInfo		="x = "+rect.offsetLeft+"<br>";
			strInfo		+="y = "+rect.offsetTop+"<br>";
			
			info.innerHTML=strInfo;
		}


		function on_Size(){
			showInfo();
		}

		
		function on_DownRect(e){
			nStartX	= e.offsetX;
			nStartY	= e.offsetY;

			window.addEventListener("mousemove",on_MoveRect,false);
			window.addEventListener("mouseup",on_UpRect,false);
		}

		function on_UpRect(e){
			window.removeEventListener("mousemove",on_MoveRect,false);
			window.removeEventListener("mouseup",on_UpRect,false);

		}

		function on_MoveRect(e){
			rect.style.left = (e.clientX-nStartX-container.offsetLeft)+"px";
			rect.style.top = (e.clientY-nStartY-container.offsetTop-123)+"px";
			showInfo();	
		}