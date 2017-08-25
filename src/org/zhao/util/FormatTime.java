package org.zhao.util;

public class FormatTime {
	public static String formatToDDHHMMSS(long ss) {
		int mi = 60;
		int hh = mi * 60;
		int dd = hh * 24;

		long day = ss / dd;
		long hour = (ss - day * dd) / hh;
		long minute = (ss - day * dd - hour * hh) / mi;
		long second = ss - day * dd - hour * hh - minute * mi;

		String strDay = day < 1 ? "" : day + "天";
		if (!strDay.equals("")) {
			return day + "天" + hour + "小时" + minute + "分" + second + "秒";
		} else {
			if (hour>=1) {
				return hour + "小时" + minute + "分" + second + "秒";
			} else {
				if (minute>=1) {
					return minute + "分" + second + "秒";
				} else {
					return second + "秒";
				}
			}
		}
	}
	
	public static double formatToHour(Integer second) {
		double hour=second*1d / 3600;
		return hour;
	}
	
	public static double calculateCost(Integer second,double baseCost) {
		double cost = second*1d / 3600 * baseCost;
		return (double)Math.round(cost*100)/100  ;
	}
	
}
