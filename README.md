# ttlauto
make teraterm macro automatically with configuration file(yaml).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ttlauto'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ttlauto

## Usage

you write server definitions into yaml file.

```yaml
- name: server_name
  category: servers_genre/sub_genre
  description: this server is ...
  define:
    - method: new
      server: 192.168.1.12
      user: username
      pass: password
      encoding: UTF-8
      protocol: telnet
      prompt: '>'
      command: 
        - bash
        - alias ls='#39'ls --colors -F'#39'
        - call_templates: for_solaris
        - cd /opt
```

Also, you write command macros into yaml file if you need.
```yaml
- name: for_solaris
  type: command_macro
  commands:
    - export HISTCONTROL=ignoreboth
    - set -o vi
    - alias vi='#39'vi -u NONE -N "+set incsearch" "+set hlsearch" "+syntax on"'#39'
    - alias grep=ggrep
    - alias tail=gtail
```

And then, build teraterm macro files.

```ruby
gem "ttl_auto"

TtlAuto::Exe.new(open("servers.yml"), open("macros.yml")).run

 # output teraterm macro named by 
 # out/servers_genre/sub_genre/server_name.ttl in case of yaml file

servers.out! 

```
## Contributing

1. Fork it ( https://github.com/hilolih/ttl_auto/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
