import ArgumentParser
import Logging

func fail(_ message: Logger.Message) throws -> Never {
  logger.error(message)
  throw ExitCode(1)
}
