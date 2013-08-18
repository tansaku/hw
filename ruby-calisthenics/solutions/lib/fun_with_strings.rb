module FunWithStrings
  def palindrome?
    sanitized = self.downcase.gsub(/\W/, '')
    sanitized == sanitized.reverse
  end
  def count_words
    counts = {}
    self.split_into_words.each do |word|
      counts[word] ||= 0
      counts[word] += 1
    end
    counts
  end
  def anagram_groups
    groups = {}
    self.split_into_words.each do |word|
      # use the 'sorted' version of this word as the bucket key.
      key = word.sort_letters
      groups[key] ||= []
      groups[key] << word
    end
    groups.values
  end
  def sort_letters
    self.split('').sort.join('')
  end
  def split_into_words
    self.downcase.gsub(/\W/, ' ').split(/\s+/).delete_if { |word| word == '' }
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end
