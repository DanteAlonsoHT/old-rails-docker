class AuditableTestModel < ActiveRecord::Base
  include AuditableService
  self.table_name = 'categories'

  attr_accessible :name, :created_by_id, :updated_by_id
end
