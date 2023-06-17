import static us.abstracta.jmeter.javadsl.JmeterDsl.*;

import org.junit.jupiter.api.Test;

public class TestRun {
	
	@Test
	public void testRun() throws Exception{
		
		testPlan(threadGroup(1, 10)
				.children(transaction("Launch")
						.children(httpSampler("https://blazedemo.com/index.php")
									.children(responseAssertion("Welcome")))
						.generateParentSample(true)
						),
				jtlWriter("jtl")
				).run();
	}

}
