#include <catch2/catch.hpp>

#include <source.hpp>

TEST_CASE("loc of index", "source") {
  auto s = marlin::source("1\n22\n333");
  auto loc = s.loc_of_index(0);
  CHECK(loc.line == 1);
  CHECK(loc.column == 1);
  loc = s.loc_of_index(1);
  CHECK(loc.line == 1);
  CHECK(loc.column == 2);
  loc = s.loc_of_index(3);
  CHECK(loc.line == 2);
  CHECK(loc.column == 2);
  loc = s.loc_of_index(5);
  CHECK(loc.line == 3);
  CHECK(loc.column == 1);
}

TEST_CASE("index of loc", "source") {
  auto s = marlin::source("1\n22\n333");
  auto index = s.index_of_loc({1, 1});
  CHECK(index == 0);
  index = s.index_of_loc({1, 2});
  CHECK(index == 1);
  index = s.index_of_loc({2, 2});
  CHECK(index == 3);
  index = s.index_of_loc({3, 1});
  CHECK(index == 5);
}