package com.pj.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.FoodVO;
import com.pj.service.FoodService;

import lombok.Setter;

@Controller
@RequestMapping("/food")
public class FoodController {

//	@Setter(onMethod_ = @Autowired)
//	private FoodService service;

	@RequestMapping("/foodList")
	public void List(Model model) {

		FoodVO food = new FoodVO();
		food.setId("testId");
		food.setTitle("testTitle");
		food.setWriter("testWriter");
		food.setInserted(LocalDateTime.now());

		List<FoodVO> list = new ArrayList<>();
		list.add(food);

		model.addAttribute("list", list);
		System.out.println("foodList 접근");
	}

	@GetMapping("/foodRegister")
	public void register() {
		System.out.println("foodRegister 접근");
	}

	@PostMapping("/foodRegister")
	public String register(FoodVO food, Model model) {
		
//		FoodVO food = new FoodVO();
		System.out.println(food);
		
		return "redirect:/food/foodList";
	}

}
