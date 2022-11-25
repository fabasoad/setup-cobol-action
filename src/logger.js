const { createLogger, format, transports } = require('winston');
const { combine, timestamp, label, printf } = format;

class Logger {
  constructor(clazz) {
    const customFormat = printf(({ level, message, label, timestamp }) => {
      timestamp = timestamp.replace(/T/, ' ').replace(/\..+/, '');
      return `${timestamp} [${label}] ${level}: ${message}`;
    });

    return createLogger({
      level: 'debug',
      format: combine(
        label({ label: clazz }),
        timestamp(),
        customFormat
      ),
      transports: [
        new transports.Console()
      ]
    });
  }
}

module.exports = Logger;
