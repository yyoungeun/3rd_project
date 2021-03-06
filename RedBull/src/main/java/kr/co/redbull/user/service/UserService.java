package kr.co.redbull.user.service;

import java.sql.SQLException;
import java.util.List;

import kr.co.redbull.cmn.DTO;

public interface UserService {
	
	/**비밀번호 찾기*/
	public DTO find_passwd(DTO dto);
	
	/**아이디/비밀번호 체크*/
	public DTO idPassCheck(DTO dto); 
	
	/**아이디체크*/
	public DTO idCheck(DTO dto); 
	
	/**수정 */
	public int do_update(DTO dto);

	/**삭제 */
	public int do_delete(DTO dto);

	/**저장 */
	public int do_save(DTO dto);

	/**단건조회 */
	public DTO get_selectOne(DTO dto);
	
	/**목록조회 */
	public List<?> get_retrieve(DTO dto);
	
	/**엑셀다운 */
	public String get_excelDown(User vo, String ext);

}//--class
