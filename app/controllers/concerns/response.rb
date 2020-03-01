module Response
  extend ActiveSupport::Concern

  def json_response(object, status = :ok, opts = {})
    response = { json: object, status: status }.merge(opts)
    render response
  end
end
