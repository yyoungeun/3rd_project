package kr.co.redbull.product.service;

import java.util.List;

import kr.co.redbull.cmn.DTO;
import kr.co.redbull.cmn.Search;

public interface ProductService {
	/**새로운 Pnum*/
	public DTO get_nextPnum();
	
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
	public String excelDown(Search vo, String ext);
}
