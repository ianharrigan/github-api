package github.api3;

import haxe.Http;
import haxe.Json;
import haxe.io.BytesOutput;
import promhx.Deferred;
import promhx.Promise;

class HttpClient {
    public function new() {
    }
    
    public function get(url:String, credentials:Credentials):Promise<APIResult<String>> {
        return rest(url, GET, credentials);
    }
    
    public function post(url:String, credentials:Credentials, data:String = null):Promise<APIResult<String>> {
        return rest(url, POST, credentials, data);
    }
    
    public function delete(url:String, credentials:Credentials):Promise<APIResult<String>> {
        return rest(url, DELETE, credentials);
    }

    public function put(url:String, credentials:Credentials, data:String = null):Promise<APIResult<String>> {
        return rest(url, PUT, credentials, data);
    }

    public function patch(url:String, credentials:Credentials, data:String = null):Promise<APIResult<String>> {
        return rest(url, PATCH, credentials, data);
    }
    
    public function rest(url:String, method:HttpMethod, credentials:Credentials, data:String = null):Promise<APIResult<String>> {
        var d = new Deferred<APIResult<String>>();
        
        var result:APIResult<String> = new APIResult<String>();
        var http = new Http(url);
        setHeaders(http, credentials);
        http.onError = function(msg) {
            if (http.responseData != null && http.responseData != null && StringTools.startsWith(http.responseData, "{")) {
                var jsonError = Json.parse(http.responseData);
                if (jsonError.message != null) {
                    msg = jsonError.message;
                }
            }
            result.errorMessage = msg;
            d.resolve(result);
        }
        http.onStatus = function(status) {
            result.headers = http.responseHeaders;
            result.httpStatus = status;
        }
        http.onData = function(data) {
            result.data = data;
            d.resolve(result);
        }
        if (data != null) {
            http.setPostData(data);
        }
        
        switch (method) {
            case GET:
                http.request(false);
            case POST:
                http.request(true);
            case DELETE | PATCH | PUT:
                var responseBytes = new BytesOutput();
                http.customRequest(true, responseBytes, method);
                #if sys
                result.data = responseBytes.getBytes().toString();
                d.resolve(result);
                #end
        }
        
        return d.promise();
    }
    
    private function setHeaders(http:Http, credentials:Credentials) {
        if (credentials.hasOAuthToken) {
            http.setHeader("Authorization", "Bearer " + credentials.oauthToken);
        } else if (credentials.hasBasicAuth) {
            http.setHeader("Authorization", "Basic " + credentials.basicAuth);
        }
        http.setHeader("Accept", "*/*");
        #if (sys || nodejs)
        http.setHeader("cache-control", "no-cache");
        http.setHeader("User-Agent", "hxGithubClient");
        http.setHeader("Host", "api.github.com");
        #if sys
        http.setHeader("Origin", sys.net.Host.localhost());
        #elseif nodejs
        http.setHeader("Origin", "localhost");
        #end
        
        #end
        //http.setHeader("accept-encoding", "gzip, deflate");
        http.setHeader("Content-Type", "text/plain; charset=UTF-8");
    }
}