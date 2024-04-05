# NumberRailway

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/number/railway`. To experiment with that code, run `bin/console` for an interactive prompt.

駅の名前が自然数で、そこに倍数の路線が通っているという自然数鉄道があったとします。
1の倍数線は、1の駅、2の駅、3の駅……と続いていき、
2の倍数線は、2の駅、4の駅、6の駅……と続いていき、
3の倍数線は、3の駅、6の駅、9の駅……と続いていきます。
例えば、4の駅から10の駅に行きたいとすれば、
1の倍数線に乗って、5の駅、6の駅、7の駅、8の駅、9の駅、10の駅と行くことができます。
このとき、4の駅から10の駅には6つの駅を通過します。
しかし、他にも行き方があり、
さらに言うと行き方によっては、もっと少ない駅数で行くことができます。
4から10への路線図を見せます。

これを見ると、2の倍数線に乗って、6の駅、8の駅、10の駅と行けば、3つの駅で行くことができます。
また、6の駅で3の倍数線に乗り換えて、9の駅で降りて、それから1の倍数線に乗って10の駅に行く方法でも、3つの駅で行くことができます。
さらに、4の倍数線で8の駅で降りて、2の倍数線に乗り換えて10の駅に行けば、2つの駅で行くことができます。
もう一つ、1の倍数線で5の駅で降りて、5の倍数線に乗り換えて10の駅に行く方法でも2つの駅で行くことができます。
このとき、任意の二駅間を最も少ない駅数で行く方法を求めるにはどうしたらいいでしょうか？

TODO: Delete this and the text above, and describe your gem

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add number-railway

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install number-railway

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/number-railway. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/number-railway/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Number::Railway project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/number-railway/blob/main/CODE_OF_CONDUCT.md).
