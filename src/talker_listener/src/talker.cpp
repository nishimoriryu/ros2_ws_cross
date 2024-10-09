#include <chrono>
#include <memory>
#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"

using namespace std::chrono_literals;

class Talker : public rclcpp::Node {
public:
  Talker() : Node("talker"), count_(1) {  // カウント変数を初期化
    // "chatter"というトピック名でパブリッシャーを作成
    publisher_ = this->create_publisher<std_msgs::msg::String>("chatter", 10);
    // 500ミリ秒ごとにタイマーを呼び出す
    timer_ = this->create_wall_timer(500ms, std::bind(&Talker::timer_callback, this));
  }

private:
  void timer_callback() {
    // 送信するメッセージを作成
    auto message = std_msgs::msg::String();
    message.data = "Hello, ROS 2! Count: " + std::to_string(count_);  // カウントをメッセージに追加
    RCLCPP_INFO(this->get_logger(), "Publishing: '%s'", message.data.c_str());
    // メッセージをパブリッシュ
    publisher_->publish(message);
    count_++;  // カウントをインクリメント
  }

  rclcpp::Publisher<std_msgs::msg::String>::SharedPtr publisher_;
  rclcpp::TimerBase::SharedPtr timer_;
  int count_;  // カウント変数
};

int main(int argc, char * argv[]) {
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<Talker>());
  rclcpp::shutdown();
  return 0;
}
