# -*- encoding: utf-8 -*-
require 'logger'
module TtlAuto::Log
  LOG = Logger.new(STDOUT)
  LOG.level = Logger::INFO
  def log_info(str)
    LOG.info(str)
  end
  def log_error(str)
    LOG.error(str)
  end
  def log_debug(str)
    LOG.debug(str)
  end
end

