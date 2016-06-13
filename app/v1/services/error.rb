class Error < StandardError
  def initialize(msg)
    super(msg)
  end

  def code
    self.class.const_get(:CODE)
  end
end

class Unauthorized < Error; CODE = 401; end
class Forbidden < Error; CODE = 403; end
class NotFound < Error; CODE = 404; end
class UnprocessableEntity < Error; CODE = 422; end
class InternalServerError < Error; CODE = 500; end