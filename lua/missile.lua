//目标速度
var speed:Number = 12;
//目的地位置
var pos:Point = new Point(300,250);
//导弹速度
var misslespeed:Number = 10;
//角速度
var omega:Number = 8;
//添加处理事件
stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
mcTarget.addEventListener(Event.ENTER_FRAME, targetMove);
mcMissile.addEventListener(Event.ENTER_FRAME, missileTrack);
//
function moveHandler(e:MouseEvent):void{	
	pos = new Point(e.localX,e.localY);
}
//目标向光标位置移动
function targetMove(e:Event):void{
	//计算目标与鼠标当前位置的距离
	var dx:Number = pos.x-mcTarget.x;
    var dy:Number = pos.y-mcTarget.y;
	//计算目标与鼠标位置的夹角
	var angle = (270 + Math.atan2(dy, dx)*180/Math.PI)%360;
	//移动目标
	if(Math.abs(dx)>speed || Math.abs(dy)>speed){
		mcTarget.x -= speed*Math.sin(angle*Math.PI/180);	
		mcTarget.y += speed*Math.cos(angle*Math.PI/180);
	}	
}
//导弹跟踪
function missileTrack(e:Event):void{
	var dx:Number = mcMissile.x-mcTarget.x;
    var dy:Number = mcMissile.y-mcTarget.y;
	//目标与y轴的夹角
    var angle = (270 + Math.atan2(dy, dx)*180/Math.PI)%360;
	//目标与导弹的夹角
	var crtangle = (angle - mcMissile.rotation + 360)%360;
	//判断导弹旋转方向
	var dir:Number = crtangle<=180?1:-1;
	mcMissile.rotation = (crtangle<180 && crtangle>omega || 
						  crtangle>180 && 360-crtangle>omega)? 
						 (mcMissile.rotation+omega*dir) : angle;
	//移动导弹
	mcMissile.x += misslespeed*Math.sin(mcMissile.rotation*Math.PI/180);	
	mcMissile.y -= misslespeed*Math.cos(mcMissile.rotation*Math.PI/180);
}