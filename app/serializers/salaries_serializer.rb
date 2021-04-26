class SalariesSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  attributes :destination, :forecast, :salaries
end
