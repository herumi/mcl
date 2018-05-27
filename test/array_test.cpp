#include <mcl/array.hpp>
#include <cybozu/test.hpp>

CYBOZU_TEST_AUTO(resize)
{
	mcl::Array<int> a, b;
	CYBOZU_TEST_EQUAL(a.size(), 0);
	CYBOZU_TEST_EQUAL(b.size(), 0);

	const size_t n = 3;
	bool ok = a.resize(n);
	CYBOZU_TEST_ASSERT(ok);
	CYBOZU_TEST_EQUAL(n, a.size());
	for (size_t i = 0; i < n; i++) {
		a[i] = i;
	}
	ok = b.copy(a);
	CYBOZU_TEST_ASSERT(ok);
	CYBOZU_TEST_EQUAL(b.size(), n);
	CYBOZU_TEST_EQUAL_ARRAY(a.data(), b.data(), n);

	const size_t small = n - 1;
	ok = b.resize(small);
	CYBOZU_TEST_ASSERT(ok);
	CYBOZU_TEST_EQUAL(b.size(), small);
	CYBOZU_TEST_EQUAL_ARRAY(a.data(), b.data(), small);
	const size_t large = n * 2;
	ok = b.resize(large);
	CYBOZU_TEST_ASSERT(ok);
	CYBOZU_TEST_EQUAL(b.size(), large);
	CYBOZU_TEST_EQUAL_ARRAY(a.data(), b.data(), small);
}
