package top.ijiujiu.util.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import top.ijiujiu.util.Status;
import top.ijiujiu.util.ToWeb;

/**
 * Created by liuruijie on 2016/12/28.
 * 全局异常处理，捕获所有Controller中抛出的异常。
 */
@ControllerAdvice
public class GlobalExceptionHandler {

	//处理自定义的异常
	@ExceptionHandler(BaseException.class)
	@ResponseBody
	public Object customHandler(BaseException e){
//		e.printStackTrace();
		return ToWeb.buildResult().status(e.getCode()).msg(e.getMessage());
	}

	//其他未处理的异常
	@ExceptionHandler(Exception.class)
	@ResponseBody
	public Object exceptionHandler(Exception e){
		e.printStackTrace();
		return ToWeb.buildResult().status(Status.FAIL).msg("系统错误");
	}
}
