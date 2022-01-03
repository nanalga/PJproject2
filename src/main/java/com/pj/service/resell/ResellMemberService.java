package com.pj.service.resell;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.resell.ResellMemberVO;
import com.pj.mapper.resell.ResellMemberMapper;

import lombok.Setter;

@Service
public class ResellMemberService {
		
		@Setter(onMethod_ = @Autowired)
		private ResellMemberMapper mapper;
	
		public ResellMemberVO select(String id) {
			return mapper.select(id);
		}
		
		public boolean register(ResellMemberVO resellMember) {
			
			try {
				return mapper.insert(resellMember) == 1;
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return false;
			
		}
			
		public boolean modify(ResellMemberVO resellMember) {
			return mapper.update(resellMember) == 1;
		}
		
		public boolean remove(String id) {
			return mapper.delete(id) == 1;
		}
		
		public List<ResellMemberVO> getList() {
			return mapper.list();
		}
		
}


