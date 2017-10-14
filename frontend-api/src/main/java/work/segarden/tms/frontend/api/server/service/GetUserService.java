package work.segarden.tms.frontend.api.server.service;

import org.springframework.stereotype.Component;
import work.segarden.tms.frontend.api.server.bean.User;

import java.util.List;

/**
 * ユーザーAPIのユーザー取得サービス.
 * <p>
 *     サービスをトランザクション境界とする.
 * </p>
 */
@Component
public class GetUserService {

    public List<User> getUser(String userId) {
        return null;
    }

}
