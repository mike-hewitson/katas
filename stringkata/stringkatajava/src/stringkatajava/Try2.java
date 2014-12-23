package stringkatajava;

public class Try2 {

	public static int add(String string) {

		int result = 0;

		String[] numbers;
		String delimiter;

		if (string.startsWith("//[")) {
			delimiter = string.substring(3, 4);
			numbers = string.substring(6).split(delimiter);
		} else {
			delimiter = ",|\n";
			numbers = string.split(",|\n");
		}

		for (String oneNum : numbers) {
			if (string != "") {
				result += Integer.valueOf(oneNum);
			}
		}
		
		
		
		
		return result;
	}

}
