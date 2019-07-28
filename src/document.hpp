#ifndef marlin_document_hpp
#define marlin_document_hpp

#include <string>
#include <vector>

#include <marlin/exec.hpp>
#include <marlin/parse.hpp>

namespace marlin {

struct document {
  void set_source(std::string source) noexcept {
    _source = std::move(source);
    std::stringstream ss(_source);
    std::string line;
    while (std::getline(ss, line, '\n')) {
      _lines.emplace_back(line);
    }
  }

  std::size_t line_count() const { return _lines.size(); }
  const std::string& line_at(std::size_t index) const { return _lines[index]; }
  const std::string& output() const { return _output; }

  void execute() {
    marlin::exec::environment env;
    env.register_print_callback(
        [t{this}](const auto& string) { t->_output += string; });
    auto code = marlin::parse::process(_source);
    env.execute(code);
  }

 private:
  std::string _source;
  std::vector<std::string> _lines;
  std::string _output;
};

}  // namespace marlin

#endif  // marlin_document_hpp
