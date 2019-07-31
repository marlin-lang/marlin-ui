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

#include "source.hpp"

namespace marlin {

struct document {
  document(std::string str) noexcept : _source{std::move(str)} {
    auto [code, errors] = marlin::parse::process(_source.str());
    _code = std::move(code);
    _parse_errors = std::move(errors);

    marlin::lint::linter l{_code};
    l.lint();

    marlin::format::highlight hl{_code};
    _highlights = hl.generate();
  }

  const auto& source_str() const noexcept { return _source.str(); }

  const auto& output() const noexcept { return _output; }

  template <typename Block>
  void for_each_highlight(Block&& block) {
    for (auto token : _highlights) {
      auto begin = _source.index_of_loc(token.range.begin);
      auto len = _source.index_of_loc(token.range.end) - begin;
      block(token.type, begin, len);
    }
  }

  std::pair<size_t, size_t> code_range_contains_index(size_t index) {
    auto loc = _source.loc_of_index(index);
    if (_code->source_code_range().contains(loc)) {
      auto& sub_code = _code.locate(loc);
      auto code_range = sub_code->source_code_range();
      auto begin = _source.index_of_loc(code_range.begin);
      auto end = _source.index_of_loc(code_range.end);
      return {begin, end - begin};
    }
    return std::pair{0, 0};
  }

  void execute() {
    _output.clear();
    marlin::exec::environment env;
    env.register_print_callback(
        [this](const auto& string) { _output += string; });
    env.execute(_code);
  }

 private:
  source _source;
  marlin::code _code;
  std::vector<marlin::parse::error> _parse_errors;
  std::vector<marlin::format::highlight::token> _highlights;

  std::string _output;
};

}  // namespace marlin

#endif  // marlin_document_hpp
