package com.spring.javaProjectS.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS.vo.MailVO;

//@Component
@Service
public class SchedulerServiceImpl {
	
	@Autowired
	JavaMailSender mailSender;

	//@Scheduled(cron = "0/5 * * * * *")		// 초 분 시 일 월 요일
	public void scheduleRun() {
		// 정기적으로 실행시키고자하는 내용들을 기술시켜준다.
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("5초에 한번씩 실행 : " + strToday);
		
	}
	
	//@Scheduled(cron = "0 0/1 * * * *")		// 초 분 시 일 월 요일
	public void scheduleRun2() {
		// 정기적으로 실행시키고자하는 내용들을 기술시켜준다.
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("매 1분에 한번씩 실행 : " + strToday);
		
	}
	
	//@Scheduled(cron = "0 5 0 * * *")		// 초 분 시 일 월 요일
	public void scheduleRun3() {
		// 정기적으로 실행시키고자하는 내용들을 기술시켜준다.
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("매 5분에 한번씩 실행 : " + strToday);
		
	}
	
	// 정해진 시간에 자동으로 메일 보내기
	//@Scheduled(cron = "0 50 23 * * *")	// 오후 11시 50분에 메일을 전송처리한다.
	//@Scheduled(cron = "0 55 17 * * *")
	public void scheduleMail() throws MessagingException {
	
		MailVO vo = new MailVO();
		vo.setToMail("apple_1114@naver.com");
		vo.setTitle("스케줄러를 통한 메일 전송");
		vo.setContent("스케줄러가 지정된 시간에 메일을 보냈습니다.");
		
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리하자...
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지 보관함의 내용(content)에, 발신자의 필요한 정보를 추가로 담아서 전송시켜주면 좋다....
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>JavaProjectS 보냅니다.</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='49.142.157.251:9090/cjgreen'>JavaProject</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로와 파일명을 별로도 표시한다. 그런후 다시 보관함에 저장한다.
		FileSystemResource file = new FileSystemResource("D:\\JavaProject\\springframework\\works\\javaProjectS\\src\\main\\webapp\\resources\\images\\main.jpg");
		//request.getSession().getServletContext().getRealPath("");
		//FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.jpg"));
		messageHelper.addInline("main.jpg", file);
		
		// 첨부파일 보내기
		//file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/chicago.jpg"));
		//messageHelper.addAttachment("chicago.jpg", file);
		
		//file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.zip"));
		//messageHelper.addAttachment("main.zip", file);
		
		
		// 메일 전송하기
		mailSender.send(message);
		
	}
}
