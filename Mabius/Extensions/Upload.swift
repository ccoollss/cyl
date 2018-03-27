import ObjectMapper

typealias ProgressBlock = (Float) -> Void

class UploadImage : BaseRequest, Bindable, RequestSendingWithDelegate
{
    typealias ResponseType = Id

    var progressBlock: ProgressBlock?

    init(image: UIImage, token: String? = ApiConfig.token)
    {
        super.init()
        method = .post
        path = "/upload"

        if let data = UIImagePNGRepresentation(image) { files["file"] = data }
        if let v = token { self.headers["Authorization"] = v } 
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        if let progress = progressBlock {
            progress(Float(totalBytesSent) / Float(totalBytesExpectedToSend))
        }
    }
}
