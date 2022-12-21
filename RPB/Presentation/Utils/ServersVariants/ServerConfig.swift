/********** Developed by Nouman Akram** ********/

import Foundation

class ServerConfig {

    //MARK: Variable
    static let shared: ServerConfig = ServerConfig()
    var baseurls : BaseUrl = .QA
    
    //MARK: Server Config
    func setUpServerConfig(){
        #if LOCAL
        self.baseurls = .LOCAL
        #elseif QA
        self.baseurls = BaseUrl.QA
        #elseif PRODUCTION
        self.baseurls = BaseUrl.PRODUCTION
        #elseif DEV
        self.baseurls = BaseUrl.DEV
        #endif
    }
}
