static const uint64_t g_mask = 0xfffffffffffff;
static const uint64_t g_vmask_[] = { g_mask, g_mask, g_mask, g_mask, g_mask, g_mask, g_mask, g_mask, };

struct G {
	static const Vec& vmask() { return *(const Vec*)g_vmask_; }
};

