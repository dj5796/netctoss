package org.zhao.util;

import java.io.Serializable;
import java.util.Calendar;
/**
 * 用于获取当前日期的年月
 * 
 * 用于获取账单日期的年月
 */
public class CalendarUitl implements Serializable{
	
	private static final long serialVersionUID = -4611539715875762893L;

	private static Calendar currCalendar=Calendar.getInstance();
	
	private static Calendar billCalendar=Calendar.getInstance();
	
	static{
		billCalendar.set(Calendar.MONTH, billCalendar.get(Calendar.MONTH)-1);
	}
	
	public static int getCurrYear(){
		return currCalendar.get(Calendar.YEAR);
	}
	
	public static int getCurrMonth(){
		return currCalendar.get(Calendar.MONTH)+1;
	}
	
	public static String getCurrYearMonth(){
		return getCurrYear()+"-"+getCurrMonth();
	}
	
	public static int getBillYear(){
		return billCalendar.get(Calendar.YEAR);
	}
	
	public static int getBillMonth(){
		return billCalendar.get(Calendar.MONTH)+1;
	}
	
	public static String getBillYearMonth(){
		return getBillYear()+"-"+getBillMonth();
	}
	
}
