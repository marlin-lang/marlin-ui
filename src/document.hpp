#ifndef marlin_document_hpp
#define marlin_document_hpp

#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include <marlin/exec.hpp>
#include <marlin/format.hpp>
#include <marlin/lint.hpp>
#include <marlin/parse.hpp>

namespace marlin {

struct document {
  document() noexcept { set_source(""); }

  void set_source(std::string source) noexcept {
    _source = std::move(source);
    update_lines_start();
    auto [code, errors] = marlin::parse::process(_source);
    _code = std::move(code);
    _parse_errors = std::move(errors);

    marlin::lint::linter l{_code};
    l.lint();

    marlin::format::highlight hl{_code};
    _highlights = hl.generate();
  }

  const auto& source() const noexcept { return _source; }

  const auto& output() const noexcept { return _output; }

  template <typename Block>
  void for_each_highlight(Block&& block) {
    for (auto token : _highlights) {
      assert(token.range.begin.line <= _lines_start.size());
      assert(token.range.end.line <= _lines_start.size());
      auto begin = _lines_start[token.range.begin.line - 1] +
                   token.range.begin.column - 1;
      auto end =
          _lines_start[token.range.end.line - 1] + token.range.end.column - 1;
      auto len = end - begin;
      block(token.type, begin, len);
    }
  }

  auto selection_from_index(std::size_t index) {
    auto begin = _source.rfind(' ', index);
    if (begin == std::string::npos) {
      begin = 0;
    } else {
      ++begin;
    }
    auto end = _source.find(' ', index);
    if (end == std::string::npos) {
      end = _source.size();
    }
    if (end < begin) {
      end = begin + 1;
    }
    return std::pair{begin, end - begin};
  }

  void execute() {
    _output.clear();
    marlin::exec::environment env;
    env.register_print_callback(
        [this](const auto& string) { _output += string; });
    env.execute(_code);
  }

 private:
  void update_lines_start() {
    std::istringstream iss{_source};
    std::string line;
    auto index = 0;
    while (std::getline(iss, line)) {
      _lines_start.push_back(index);
      index += line.size() + 1;
    }
  }

  std::string _source;
  marlin::code _code;
  std::vector<marlin::parse::error> _parse_errors;
  std::vector<marlin::format::highlight::token> _highlights;
  std::vector<int> _lines_start;

  std::string _output;
};

}  // namespace marlin

#endif  // marlin_document_hpp
