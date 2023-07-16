class Hamming
  def self.compute(dna_strand_a, dna_strand_b)
    a = dna_strand_a.split('')
    b = dna_strand_b.split('')

    raise ArgumentError if a.length != b.length

    distance = 0

    a.zip(b).each do |element_a, element_b|
      distance += 1 if element_a != element_b
    end

    distance
  end
end
