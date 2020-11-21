class Screen

  attr_reader :width, :height, :screen

  def initialize(width = 10, height = 10)
    @width = width
    @height = height
    @screen = []
    @height.times { @screen << " " * @width }
  end

  def clear
    @screen.clear
    @height.times { |i| @screen[i] = " " * @width }
  end

  def add_image(x, y, image)
    h = image.size
    w = image[0].length
    h.times do |k|
      w.times do |l|
        @screen[y + k][x + l] = image[k][l]
      end
    end
  end

  def print_screen(delay = 0)
    sleep delay
    system('clear')
    @screen.each {|str| puts str}
  end

end