package com.spring.javaProjectS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value="/message/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, String mid, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="temp", defaultValue = "", required = false) String temp) {
		
		if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", "user가 삭제 되었습니다.");
			model.addAttribute("url", "user/userList"); //member 앞에 '/' 뺐음. 중첩방지(message.jsp 가보기), 경로임
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("msg", "user 삭제 실패~~");
			model.addAttribute("url", "user/userList");
		}
		else if(msgFlag.equals("user2DeleteOk")) {
			model.addAttribute("msg", "user2가 삭제 되었습니다.");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2DeleteNo")) {
			model.addAttribute("msg", "user2 삭제 실패~~");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2InputOk")) {
			model.addAttribute("msg", "회원 가입 성공!!!");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2InputNo")) {
			model.addAttribute("msg", "회원 가입 실패~~");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2UserUpdateOk")) {
			model.addAttribute("msg", "정보수정 완료!!");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2UserUpdateNo")) {
			model.addAttribute("msg", "정보수정 실패~~");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록에 글이 등록되었습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("msg", "방명록 글올리기 실패~~~");
			model.addAttribute("url", "guest/guestInput");
		}
		else if(msgFlag.equals("adminLoginOk")) {
			model.addAttribute("msg", "관리자 인증 성공");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("adminLoginNo")) {
			model.addAttribute("msg", "관리자 인증 실패~~");
			model.addAttribute("url", "guest/adminLogin");
		}
		else if(msgFlag.equals("adminLogout")) {
			model.addAttribute("msg", "관리자 로그아웃 되었습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("guestDeleteOk")) {
			model.addAttribute("msg", "방명록의 글이 삭제 되었습니다.");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("guestDeleteNo")) {
			model.addAttribute("msg", "방명록의 글 삭제 실패~~");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일이 성공적으로 전송되었습니다.");
			model.addAttribute("url", "study/mail/mail");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "회원 로그인 실패~~");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid + "님 로그인 되셨습니다.");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid + "님 로그아웃 되었습니다.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원 가입 되었습니다.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원 가입 실패~~");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("msg", "아이디가 중복되었습니다.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "닉네임이 중복되었습니다.");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정되었습니다.");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원정보 수정실패~~");
			model.addAttribute("url", "member/memberUpdate");
		}
		/* board */
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시판에 글이 등록되었습니다.");
			model.addAttribute("url", "board/boardList");
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "글등록에 실패하였습니다.");
			model.addAttribute("url", "board/boardInput");
		}
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "글이 삭제되었습니다.");
			model.addAttribute("url", "board/boardList?pag="+pag+"&pageSize="+pageSize); 
		}
		else if(msgFlag.equals("boardDeleteNo")) {
			model.addAttribute("msg", "게시글 삭제 실패하였습니다.");
			model.addAttribute("url", "board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize); 
		}
		else if(msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "board/boardContent?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
		}
		else if(msgFlag.equals("boardUpdateNo")) {
			model.addAttribute("msg", "수정 실패하였습니다.");
			model.addAttribute("url", "board/boardUpdate?idx="+idx+"&pag="+pag+"&pageSize="+pageSize); 
		}
		/* interceptor */
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 접속할 수 있습니다.");
			model.addAttribute("url", "/"); //처음으로 돌려보낸다.
		}
		else if(msgFlag.equals("memberLevelNo")) {
			model.addAttribute("msg", "해당 등급은 접근하실 수 없습니다.");
			model.addAttribute("url", "/"); 
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "로그인후 사용가능합니다.");
			model.addAttribute("url", "member/memberLogin"); 
		}
		/* validatorError Backend 체크*/
		else if(msgFlag.equals("validatorError")) {
			model.addAttribute("msg", "유저 등록 실패!" + temp + "를 확안하세요.");
			model.addAttribute("url", "user2/user2List"); 
		}
		/* 파일업로드연습 */
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일이 업로드되었습니다.");
			model.addAttribute("url", "study/fileUpload/fileUpload"); 
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일이 업로드에 실패하였습니다.");
			model.addAttribute("url", "study/fileUpload/fileUpload"); 
		}
		/* Pds자료실 */
		else if(msgFlag.equals("pdsInputOk")) {
			model.addAttribute("msg", "자료실에 등록되었습니다.");
			model.addAttribute("url", "pds/pdsList"); 
		}
		else if(msgFlag.equals("pdsInputNo")) {
			model.addAttribute("msg", "등록실패하였습니다.");
			model.addAttribute("url", "pds/pdsInput"); 
		}
		/* 썸네일 */
		else if(msgFlag.equals("thumbnailCreateOk")) {
			model.addAttribute("msg", "썸네일 이미지 등록 성공~!!");
			model.addAttribute("url", "study/thumbnail/thumbnailForm"); 
		}
		else if(msgFlag.equals("thumbnailCreateNo")) {
			model.addAttribute("msg", "썸네일 이미지 등록 실패.");
			model.addAttribute("url", "study/thumbnail/thumbnailForm"); 
		}
		/* 카카오로그인시 아이디 만들 때 중복체크 */
		else if(msgFlag.equals("midSameSearch")) {
			model.addAttribute("msg", "같은 아이디가 존재합니다.");
			model.addAttribute("url", "member/memberLogin"); 
		}
		else if(msgFlag.equals("kakaoLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인되었습니다.");
			model.addAttribute("url", "member/memberMain"); 
		}
		else if(msgFlag.equals("kakaoLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃었되습니다.");
			model.addAttribute("url", "member/memberLogin"); 
		}
		else if(msgFlag.equals("validateNo")) {
			model.addAttribute("msg", "백엔드체크오류");
			model.addAttribute("url", "/"); 
		}
		/* 상품 등록하기 */
		else if(msgFlag.equals("dbProductInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "dbShop/dbShopList"); 
		}
		else if(msgFlag.equals("dbProductInputNo")) {
			model.addAttribute("msg", "상품 등록 실패");
			model.addAttribute("url", "dbShop/dbProduct"); 
		}
		else if(msgFlag.equals("dbOptionInputOk")) {
			model.addAttribute("msg", "상품 옵션이 등록되었습니다.");
			model.addAttribute("url", "dbShop/dbOption"); 
		}
		else if(msgFlag.equals("dbOptionInputNo")) {
			model.addAttribute("msg", "옵션 등록 실패");
			model.addAttribute("url", "dbShop/dbOption"); 
		}
		else if(msgFlag.equals("cartOrderOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n주문창으로 이동합니다.");
			model.addAttribute("url", "/dbShop/dbCartList");
		}
		else if(msgFlag.equals("cartOrderNo")) {
			model.addAttribute("msg", "장바구니에 상품 등록실패");
			model.addAttribute("url", "/dbShop/dbCartList");
		}
		else if(msgFlag.equals("cartInputOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n즐거운 쇼핑되세요.");
			model.addAttribute("url", "/dbShop/dbProductList");
		}
		else if(msgFlag.equals("cartEmpty")) {
			model.addAttribute("msg", "장바구니가 비어있습니다.");
			model.addAttribute("url", "/dbShop/dbProductList");
		}
		
		return "include/message";
	}
}
