package com.store.cake.dao.pl;
import java.util.HashMap;
import java.util.List;

import com.store.cake.dto.pl.PLDTO;
import com.store.cake.dto.pl.PLGraphDTO;
import com.store.cake.dto.pl.SpendDTO;

public interface PLDAO {
	
	public List<PLDTO> getPLList(HashMap map);

	public HashMap getPLTotalCount(HashMap map);

	public void spendInsert(SpendDTO dto);

	public List<PLGraphDTO> getPLGraphDay(HashMap map);
	
	public List<PLGraphDTO> getPLGraphMonth(HashMap map);
	
	public List<PLGraphDTO> getPLGraphYear(HashMap map);

}
