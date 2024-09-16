import 'package:dio/dio.dart';

class ApiException extends Error {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';


  factory ApiException.fromStatusCode(int statusCode) {
    if (statusCode >= 100 && statusCode < 200) {
      return ApiException('Informational response: Processing request.', statusCode);
    } else if (statusCode >= 200 && statusCode < 300) {
      return ApiException('Success: Request completed successfully.', statusCode);
    } else if (statusCode >= 300 && statusCode < 400) {
      return ApiException('Redirection: Further action needs to be taken.', statusCode);
    } else if (statusCode >= 400 && statusCode < 500) {
      return _handleClientErrors(statusCode);
    } else if (statusCode >= 500 && statusCode < 600) {
      return _handleServerErrors(statusCode);
    } else {
      return ApiException('Unknown status code: $statusCode. Please try again.', statusCode);
    }
  }

  factory ApiException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException("Connection Timeout, please try again.");
      case DioExceptionType.sendTimeout:
        return ApiException("Request Timeout, please try again.");
      case DioExceptionType.receiveTimeout:
        return ApiException("Response Timeout, please try again.");
      case DioExceptionType.badResponse:
        return ApiException.fromStatusCode(dioError.response?.statusCode ?? 0);
      case DioExceptionType.cancel:
        return ApiException("Request was cancelled, please try again.");
      case DioExceptionType.badCertificate:
        return ApiException("Invalid SSL Certificate.");
      case DioExceptionType.connectionError:
        return ApiException("No Internet connection.");
      case DioExceptionType.unknown:
      default:
        return ApiException("Something went wrong. Please try again.");
    }
  }

  // Handle 4xx client errors
  static ApiException _handleClientErrors(int statusCode) {
    switch (statusCode) {
      case 400:
        return ApiException('Bad Request: The server could not understand the request.', statusCode);
      case 401:
        return ApiException('Unauthorized: Authentication is required.', statusCode);
      case 402:
        return ApiException('Payment Required: Payment is needed to access the resource.', statusCode);
      case 403:
        return ApiException('Forbidden: You do not have permission to access this resource.', statusCode);
      case 404:
        return ApiException('Not Found: The requested resource could not be found.', statusCode);
      case 405:
        return ApiException('Method Not Allowed: The HTTP method is not allowed for the resource.', statusCode);
      case 406:
        return ApiException('Not Acceptable: The requested resource is not available in a suitable format.', statusCode);
      case 407:
        return ApiException('Proxy Authentication Required: You need to authenticate with the proxy.', statusCode);
      case 408:
        return ApiException('Request Timeout: The server timed out waiting for the request.', statusCode);
      case 409:
        return ApiException('Conflict: The request could not be completed due to a conflict.', statusCode);
      case 410:
        return ApiException('Gone: The requested resource is no longer available.', statusCode);
      case 411:
        return ApiException('Length Required: The server needs the Content-Length header.', statusCode);
      case 412:
        return ApiException('Precondition Failed: The server does not meet one of the preconditions.', statusCode);
      case 413:
        return ApiException('Payload Too Large: The request payload is too large.', statusCode);
      case 414:
        return ApiException('URI Too Long: The request URI is too long.', statusCode);
      case 415:
        return ApiException('Unsupported Media Type: The request format is not supported by the server.', statusCode);
      case 416:
        return ApiException('Range Not Satisfiable: The range specified by the request is invalid.', statusCode);
      case 417:
        return ApiException('Expectation Failed: The server cannot meet the expectations.', statusCode);
      case 418:
        return ApiException('I\'m a Teapot: Just a playful 418 error.', statusCode);
      case 421:
        return ApiException('Misdirected Request: The request was directed to a server that cannot produce a response.', statusCode);
      case 422:
        return ApiException('Unprocessable Entity: The request was well-formed but unable to be followed.', statusCode);
      case 423:
        return ApiException('Locked: The resource is locked.', statusCode);
      case 424:
        return ApiException('Failed Dependency: The request failed due to a previous failure.', statusCode);
      case 425:
        return ApiException('Too Early: The server is unwilling to process the request.', statusCode);
      case 426:
        return ApiException('Upgrade Required: The client must upgrade the protocol to continue.', statusCode);
      case 428:
        return ApiException('Precondition Required: The origin server requires the request to be conditional.', statusCode);
      case 429:
        return ApiException('Too Many Requests: You have sent too many requests in a given amount of time.', statusCode);
      case 431:
        return ApiException('Request Header Fields Too Large: The server rejected the request due to headers too large.', statusCode);
      case 451:
        return ApiException('Unavailable For Legal Reasons: The resource is unavailable due to legal reasons.', statusCode);
      default:
        return ApiException('Client Error: Something went wrong with your request.', statusCode);
    }
  }

  // Handle 5xx server errors
  static ApiException _handleServerErrors(int statusCode) {
    switch (statusCode) {
      case 500:
        return ApiException('Internal Server Error: Something went wrong on the server.', statusCode);
      case 501:
        return ApiException('Not Implemented: The server does not support the functionality required.', statusCode);
      case 502:
        return ApiException('Bad Gateway: The server received an invalid response from the upstream server.', statusCode);
      case 503:
        return ApiException('Service Unavailable: The server is temporarily unable to handle the request.', statusCode);
      case 504:
        return ApiException('Gateway Timeout: The upstream server failed to send a request in time.', statusCode);
      case 505:
        return ApiException('HTTP Version Not Supported: The server does not support the HTTP protocol version used.', statusCode);
      case 506:
        return ApiException('Variant Also Negotiates: Transparent content negotiation resulted in a circular reference.', statusCode);
      case 507:
        return ApiException('Insufficient Storage: The server is unable to store the representation needed.', statusCode);
      case 508:
        return ApiException('Loop Detected: The server detected an infinite loop while processing the request.', statusCode);
      case 510:
        return ApiException('Not Extended: Further extensions are required to fulfill the request.', statusCode);
      case 511:
        return ApiException('Network Authentication Required: Authentication is required to access the network.', statusCode);
      default:
        return ApiException('Server Error: Something went wrong on the server.', statusCode);
    }
  }
}
