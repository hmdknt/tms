package work.segarden.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import work.segarden.bean.Sample;

@RestController
@RequestMapping("/sample")
public class SampleController {

    @GetMapping("{id}")
    public ResponseEntity<Sample> get(@PathVariable("id") String id) {
        return new ResponseEntity<Sample>(
                Sample.builder().id(id).message("sample").build()
                , HttpStatus.OK);
    }

}
