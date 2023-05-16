class TwoFer
  def self.two_fer(name = nil)
    return 'One for you, one for me.' if name.nil?

    "One for #{name}, one for me."
  end
end
