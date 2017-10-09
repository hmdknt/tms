package work.segarden.frontend.api.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class Test {

    private static TimeZone GMT = TimeZone.getTimeZone("GMT");

    public static void main(String[] args) {

        SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz",Locale.US);
        sdf.setTimeZone(GMT);

        System.out.println(sdf.format(new Date()));

    }

}
