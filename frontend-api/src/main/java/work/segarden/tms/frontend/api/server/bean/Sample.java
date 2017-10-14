package work.segarden.tms.frontend.api.server.bean;

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
