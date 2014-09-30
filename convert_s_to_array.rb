string = "4539953794763369"
new_array = string.scan(/[\d]{1}/)
new_array.map! { |i| i.to_i }

