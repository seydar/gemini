Eye.config do
  logger '/home/ari/servers/eye.log'
end

HOST = "0.0.0.0"
PORT = 4002

Eye.app 'gemini' do
  working_dir File.expand_path(File.dirname(__FILE__))

  process 'home' do
    pid_file "tmp/thin.pid"
    daemonize true

    start_command "thin -R config.ru -a #{HOST} -p #{PORT} -d -P tmp/thin.pid -l logs/thin.log start"
    stdall 'logs/default.log'

    stop_signals [:TERM, 10.seconds]

    restart_command 'kill -USR2 {PID}'

    check :cpu,    :every => 30, :below => 80, :times => 3
    check :memory, :every => 30, :below => 60.megabytes, :times => [3, 5]

    trigger :flapping, :times => 10, :within => 1.minute

    start_timeout 80.seconds
    restart_grace 30.seconds

    monitor_children do
      stop_command 'kill -QUIT {PID}'
      check :cpu,    :every => 30, :below => 80, :times => 3
      check :memory, :every => 30, :below => 60.megabytes, :times => [3, 5]
    end
  end
end
