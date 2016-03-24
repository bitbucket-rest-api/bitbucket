class Array # :nodoc:

  def except(*keys) # :nodoc:
    self.dup.except!(*keys)
  end unless method_defined?(:except)

  def except!(*items) # :nodoc:
    self.reject! { |item| items.include? item }
  end unless method_defined?(:except!)

  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end

end # Array
