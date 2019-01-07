package global.sesoc.tsumioroshi.util;

public class HexConverter {
	
	public HexConverter() {}
	
	public String hexToDec(String hex) {
		long v = Long.parseLong(hex, 16);
		return String.valueOf(v);
	}
	
	public String decToHex(String dec) {
		long intDec	= Long.parseLong(dec);
		String result = Long.toHexString(intDec).toUpperCase();
		if(result.length() != 4) {
			while(result.length() <4) {
				result = "0"+result;
			}
		}
		return result;
	}
	
	public String codeAdder(String dec) {
		String result = Integer.toString( Integer.parseInt(dec) + 1);
		
		return result;
	}
}
