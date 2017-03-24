class InstamojoHandler
  @@api = Instamojo::API.new("bea354f9f9808d2bc2e5d5ebbe7ff3d5", "0950fc7e9fa1c27462c075d81f956359")
  def self.client
    @@api.client
  end
end