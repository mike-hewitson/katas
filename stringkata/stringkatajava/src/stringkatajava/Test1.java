package stringkatajava;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class Test1 {

	Try2 add;
	
	@Before
	public void setUp() throws Exception {
		add = new Try2();
	}

	@Test
	public void testEmpty() {		
		assertEquals(0, Try2.add(""));		
	}
	
	@Test
	public void testSingle() {		
		assertEquals(0, Try2.add("0"));
		assertEquals(1, Try2.add("1"));
		assertEquals(22, Try2.add("22"));		
	}
	
	@Test
	public void testTwo() {		
		assertEquals(3, Try2.add("1,2"));
		assertEquals(23, Try2.add("22,1"));
	}
	
	@Test
	public void testN() {		
		assertEquals(15, Try2.add("1,2,3,4,5"));
	}
	
	@Test
	public void testNewLine() {		
		assertEquals(15, Try2.add("1,2,3\n4,5"));
	}
	
	@Test
	public void testDifferent() {		
		assertEquals(15, Try2.add("//[;]\n1;2;3;4;5"));
	}
	
}
