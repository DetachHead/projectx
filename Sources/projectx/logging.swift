import Logging

let logger: Logger = {
    LoggingSystem.bootstrap(StreamLogHandler.standardOutput)
    return Logger(label: "projectx")
}()
