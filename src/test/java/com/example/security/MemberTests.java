package com.example.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.config.RootConfig;
import com.example.config.SecurityConfig;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, SecurityConfig.class})
@Slf4j
public class MemberTests {

	@Autowired
	private PasswordEncoder pwEncoder;
	
	@Autowired
	private DataSource ds;
	
	@Test
	public void testInserMember() {
		
		String sql = "insert into tbl_member(userid, userpw, username) values(?, ?, ?)";
		
		for (int i=0; i<100; i++) {
			Connection conn = null;
			PreparedStatement pstat = null;
			
			try {
				
				conn = ds.getConnection();
				pstat = conn.prepareStatement(sql);
				
				pstat.setString(2, pwEncoder.encode("pw" + i));
				
				if (i < 80) {
					pstat.setString(1, "user" + i);
					pstat.setString(3, "일반사용자" + i);
				} else if (i < 90) {
					pstat.setString(1, "manager" + i);
					pstat.setString(3, "운영자" + i);					
				} else {
					pstat.setString(1, "admin" + i);
					pstat.setString(3, "관리자" + i);										
				}
				
				pstat.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstat.close();
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	@Test
	public void testInsertAuth() {
		
		String sql = "insert into tbl_member_auth(userid, auth) values(?, ?)";
		
		for (int i=0; i<100; i++) {
			Connection conn = null;
			PreparedStatement pstat = null;
			
			try {
				
				conn = ds.getConnection();
				pstat = conn.prepareStatement(sql);
				
				if (i < 80) {
					pstat.setString(1, "user"+i);
					pstat.setString(2, "ROLE_USER");
				} else if (i < 90) {
					pstat.setString(1, "manager"+i);
					pstat.setString(2, "ROLE_MEMBER");
				} else {
					pstat.setString(1, "admin"+i);
					pstat.setString(2, "ROLE_ADMIN");
				}
				
				pstat.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstat.close();
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
}
