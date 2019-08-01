#ifndef marlin_source_hpp
#define marlin_source_hpp

#include <cassert>
#include <cstddef>
#include <string>
#include <vector>

#include <marlin/ast.hpp>

namespace marlin {

struct source {
  explicit source(std::string str) noexcept : _str{std::move(str)} {
    update_begin_of_lines();
  }

  const std::string& str() const noexcept { return _str; }

  source_loc loc_of_index(std::size_t index) const noexcept {
    auto it = std::upper_bound(std::begin(_begin_of_lines),
                               std::end(_begin_of_lines), index);
    size_t line = std::distance(std::begin(_begin_of_lines), it);
    assert(it != std::begin(_begin_of_lines));
    size_t column = index - *std::prev(it) + 1;
    return {line, column};
  }

  size_t index_of_loc(source_loc loc) const noexcept {
    assert(loc.line > 0 && loc.line <= _begin_of_lines.size());
    return _begin_of_lines[loc.line - 1] + loc.column - 1;
  }

 private:
  void update_begin_of_lines() noexcept {
    _begin_of_lines.push_back(0);
    for (auto it = std::begin(_str); it != std::end(_str);) {
      it = std::find(it, std::end(_str), '\n');
      if (it != std::end(_str)) {
        ++it;
        _begin_of_lines.push_back(std::distance(std::begin(_str), it));
      }
    }
  }

  std::string _str;
  std::vector<size_t> _begin_of_lines;
};

}  // namespace marlin

#endif  // marlin_source_hpp
