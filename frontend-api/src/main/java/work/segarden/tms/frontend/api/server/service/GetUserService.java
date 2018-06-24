package work.segarden.tms.frontend.api.server.service;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import work.segarden.tms.frontend.api.server.bean.ServiceDetail;
import work.segarden.tms.frontend.api.server.bean.ServiceInfo;
//import work.segarden.tms.frontend.api.server.bean.User;
import work.segarden.tms.frontend.api.server.control.ServiceApi;

import java.util.ArrayList;
import java.util.List;

/**
 * ユーザーAPIのユーザー取得サービス.
 * <p>
 *     サービスをトランザクション境界とする.
 * </p>
 */
@Component
public class GetUserService implements ServiceApi{

    @Override
    public ResponseEntity<ServiceInfo> shadowShadowIdServicesPost(String shadowId, String xApiKey, String xSessionId) {

        ServiceInfo serviceInfo = new ServiceInfo();
        ServiceDetail serviceDetail = new ServiceDetail();

        serviceDetail.setName("aaa");
        serviceDetail.setStatus(0);

        serviceInfo.serviceInfo(new ArrayList<ServiceDetail>());

        serviceInfo.addServiceInfoItem(serviceDetail);

        return new ResponseEntity<ServiceInfo>(serviceInfo, HttpStatus.OK);
    }
}
