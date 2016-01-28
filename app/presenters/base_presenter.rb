class BasePresenter < SimpleDelegator
  def self.present(object)
    new object
  end
end
