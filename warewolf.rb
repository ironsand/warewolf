class Switch
  def initialize(name:, gpio:)
    @name = name
    @gpio = gpio
    @pushed = false
    export_gpio
  end

  def export_gpio
    return if File.exist?("/sys/class/gpio/gpio#{@gpio}")
    File.write("/sys/class/gpio/export", @gpio)
    File.write("/sys/class/gpio/gpio#{@gpio}/direction", "in")
  end

  def unexport_gpio
    File.write("/sys/class/gpio/unexport", @gpio)
  end

  def push
    unless @pushed
      p "run #{@gpio}:#{@name}"
      run
    end
    @pushed = true
  end

  def unpush
    @pushed = false
  end

  def update_status
    case File.read("/sys/class/gpio/gpio#{@gpio}/value").to_i
      when 0 then
        unpush
      when 1 then
        push
    end
  end

  def run
    Process.detach(spawn("/home/pi/warewolf/#{@name}.sh"))
  end
end

class WareWolf
  def initialize
    @switchs = {night: 4, morning: 22, discussion: 25, clear: 23, execution: 24}.map do |name, gpio|
      Switch.new(name: name, gpio: gpio)
    end
  end

  def watch
    loop do
      @switchs.each(&:update_status)
      sleep(0.1)
    end
  end
end
