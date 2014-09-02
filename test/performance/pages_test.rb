require 'test_helper'
require 'rails/performance_test_help'

class PagesTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { runs: 5, metrics: [:wall_time, :process_time, :memory],
                            output: 'tmp/performance', formats: [:flat, :graph_html, :call_tree, :call_stack] }

  test "homepage" do
    get '/'
  end
  
  test "category" do
    get '/categories/1'
  end
  
  test "normal_topic" do
    get "http://localhost:3000/categories/1/topics/12?page=1"
  end
  
  test "topic_with_images" do
    get "http://localhost:3000/categories/1/topics/12?page=2"
  end
end