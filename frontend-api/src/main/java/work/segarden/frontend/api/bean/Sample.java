package work.segarden.frontend.api.bean;

import lombok.Builder;
import lombok.Data;
import lombok.NonNull;

@Data
@Builder
public class Sample {

    @NonNull
    private String id;

    @NonNull
    private String message;

}
