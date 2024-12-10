class Current
  def self.admin_id
    Thread.current[:current_admin_id]
  end

  def self.admin_id=(value)
    Thread.current[:current_admin_id] = value
  end

  def self.reset
    Thread.current[:current_admin_id] = nil
  end
end
