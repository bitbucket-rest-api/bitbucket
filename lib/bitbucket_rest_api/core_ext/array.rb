class Array # :nodoc:

  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end

end # Array
