class Array
  def chunk(chunk_size)
    chunks = [self.length / chunk_size, 1].max.times.collect { [] }
    while self.any?
      chunks.each do |a_chunk|
        chunk_size.times do
          a_chunk << self.shift if self.any?
        end
      end
    end
    chunks
  end
end
