package work.segarden.tms.frontend.api.server.control;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import work.segarden.tms.frontend.api.server.bean.Sample;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.TimeZone;

@RestController
//@RequestMapping("/samples")
public class SampleController {


    private static TimeZone GMT = TimeZone.getTimeZone("GMT");


    @GetMapping("{id}")
    public ResponseEntity<Sample> get(@PathVariable("id") String id) {
        return new ResponseEntity<Sample>(
                Sample.builder().id(id).message("sample").build()
                , HttpStatus.OK);
    }

    @GetMapping("modchk/{id}")
    public ResponseEntity<Sample> getCheckModified(WebRequest webRequest, @PathVariable("id") String id) throws ParseException {

        SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.US);
        sdf.setTimeZone(GMT);
        long lastModified = sdf.parse("Sun, 01 Oct 2017 08:29:16 GMT").getTime();

        if (webRequest.checkNotModified(lastModified)) {
            return null;
        }

        return new ResponseEntity<Sample>(
                Sample.builder().id(id).message("sample").build()
                , HttpStatus.OK);
    }


    @GetMapping("{id}")
    public ResponseEntity<Sample> getCheckModifiedEtag(WebRequest webRequest, @PathVariable("id") String id) throws ParseException {

        // XXX:本来業務処理で取得
        String etag = "0";

        // XXX:本来業務処理で取得
        SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.US);
        sdf.setTimeZone(GMT);
        long lastModified = sdf.parse("Sun, 01 Oct 2017 11:11:11 GMT").getTime();

        if (webRequest.checkNotModified(etag,lastModified)) {
            return null;
        }

        // 本来行うべき業務処理
        return new ResponseEntity<Sample>(
                Sample.builder().id(id).message("sample").build()
                , HttpStatus.OK);
    }

    @DeleteMapping("modchk/etag/{id}")
    public ResponseEntity<Sample> deleteCheckModifiedEtag(WebRequest webRequest, @PathVariable("id") String id) throws ParseException {

        String etag = "111";


        SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.US);
        sdf.setTimeZone(GMT);
        long lastModified = sdf.parse("Sun, 01 Oct 2017 08:29:16 GMT").getTime();

        if (webRequest.checkNotModified(etag,lastModified)) {
            return null;
        }

        return new ResponseEntity<Sample>(
                Sample.builder().id(id).message("sample").build()
                , HttpStatus.OK);
    }

    @PostMapping("modchk/etag/{id}")
    public ResponseEntity<Sample> postCheckModifiedEtag(WebRequest webRequest, @PathVariable("id") String id) throws ParseException {

        String etag = "111";


        SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.US);
        sdf.setTimeZone(GMT);
        long lastModified = sdf.parse("Sun, 01 Oct 2017 08:29:16 GMT").getTime();


        if (webRequest.checkNotModified(etag, lastModified)) {
            return null;
        }

        return new ResponseEntity<Sample>(
                Sample.builder().id(id).message("sample").build()
                , HttpStatus.OK);
    }

    @PutMapping("modchk/etag/{id}")
    public ResponseEntity<Sample> putCheckModifiedEtag(WebRequest webRequest, @PathVariable("id") String id) throws ParseException {

        String etag = "111";


        SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.US);
        sdf.setTimeZone(GMT);
        long lastModified = sdf.parse("Sun, 01 Oct 2017 08:29:16 GMT").getTime();


        if (webRequest.checkNotModified(etag, lastModified)) {
            return null;
        }

        return new ResponseEntity<Sample>(
                Sample.builder().id(id).message("sample").build()
                , HttpStatus.OK);
    }

}
