#ifndef marlin_document_hpp
#define marlin_document_hpp

#include <string>
#include <vector>

#include <marlin/exec.hpp>
#include <marlin/parse.hpp>

namespace marlin {

struct document {
  const std::string& source() const noexcept { return _source; }
  void set_source(std::string source) noexcept { _source = std::move(source); }

  const std::string& output() const noexcept { return _output; }

  void execute() {
    marlin::exec::environment env;
    env.register_print_callback(
        [this](const auto& string) { _output += string; });
    auto code = marlin::parse::process(_source);
    env.execute(code);
  }

 private:
  std::string _source;
  std::string _output;
};

}  // namespace marlin

#endif  // marlin_document_hpp