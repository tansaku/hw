module CurrencyConversion
  # this is the code provided in lecture:
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
  def method_missing(method_id, *args, &block)
    # capture all arguments in case we have to call super
    singular_currency = method_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
      # 'super' with no arglist passes ALL original args to superclass's method
    end
  end
end

class Numeric
  include CurrencyConversion
end
