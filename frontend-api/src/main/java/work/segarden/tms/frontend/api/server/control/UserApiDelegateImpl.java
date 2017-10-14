package work.segarden.tms.frontend.api.server.control;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import work.segarden.tms.frontend.api.server.bean.User;
import work.segarden.tms.frontend.api.server.service.GetUserService;

import java.util.List;

/**
 * ユーザーAPIのビジネスロジックを呼び出すためのクラス.
 * コントローラの処理を一部移譲されている.
 */
@Component
@RequiredArgsConstructor
public class UserApiDelegateImpl implements UserApiDelegate {

    private final GetUserService getUserService;

    /**
     * {@inheritDoc}
     */
    @Override
    public ResponseEntity<List<User>> getUser(String userId) {
        return new ResponseEntity<List<User>>(getUserService.getUser(userId), HttpStatus.OK);
    }

}
