class FileConvertJob < ApplicationJob
  queue_as :default

  def perform(convert)
    unless convert.waiting?
      logger.info "Convert #{@convert.id} is already performed."
      return
    end
    unless pseudo_validate_input_file(convert)
      message = 'Failed to validate the input file.'
      logger.info message
      convert.update(status: :failed, message: message)
      return
    end
    pseudo_convert_file(convert)
  end

  def pseudo_validate_input_file(convert)
    convert.update(status: :validating)
    logger.info convert.status

    sleep 5

    true
  end

  def pseudo_convert_file(convert)
    convert.update(status: :converting)
    logger.info convert.status

    attach_out_file(convert)
    sleep 5

    message = "The process was successful. #{Time.zone.now.iso8601}"
    convert.update(status: :succeeded, message: message)
    logger.info convert.status
  end

  def attach_out_file(convert)
    convert.in_file.open(tmpdir: Dir.tmpdir) do |file|
      convert.out_file.attach(io: File.open(file.path), filename: 'out_file.csv')
    end
  end
end
