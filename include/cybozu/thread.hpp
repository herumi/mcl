#pragma once
/**
	@file
	@brief tiny thread class

	@author MITSUNARI Shigeo(@herumi)
	@author MITSUNARI Shigeo
*/

#include <cybozu/atomic.hpp>
#include <assert.h>
#ifdef _WIN32
	#ifndef WIN32_LEAN_AND_MEAN
		#define WIN32_LEAN_AND_MEAN
	#endif
	#include <windows.h>
	#include <process.h>
	#ifdef _MSC_VER
		#pragma warning(push)
		#pragma warning(disable : 4127)
	#endif
#else
	#include <unistd.h>
	#include <pthread.h>
	#include <time.h>
	#include <errno.h>
	#include <stdio.h>
#endif

namespace cybozu {

/**
	sleep
	@param [in] msec time out(msec)
*/
inline void Sleep(int msec)
{
#ifdef _WIN32
	::Sleep(msec);
#else
	struct timespec req;
	req.tv_sec = msec / 1000;
	req.tv_nsec = (msec % 1000) * 1000000;
	for (;;) {
		struct timespec rem;
		int ret = nanosleep(&req, &rem);
		if (ret == 0) break;
		if (errno != EINTR) {
			printf("Sleep errno %d\n", errno);
			break;
		}
		req = rem;
	}
#endif
}

/**
	get pid
*/
inline unsigned int GetProcessId()
{
#ifdef _WIN32
	return GetCurrentProcessId();
#else
	assert(sizeof(pid_t) == 4);
	return getpid();
#endif
}
/*
	number of processor
	@note include hyperthread
	@return 0 if error
*/
inline int GetProcessorNum()
{
#ifdef _WIN32
	SYSTEM_INFO systemInfo;
	::GetSystemInfo(&systemInfo);
	return (int)systemInfo.dwNumberOfProcessors;
#else
	long ret = sysconf(_SC_NPROCESSORS_ONLN);
	if (ret < 0) return 0;
	return static_cast<int>(ret);
#endif
}

namespace thread {

#ifdef _WIN32
	typedef HANDLE ThreadHandle;
	const int Infinite = INFINITE;
	typedef unsigned __stdcall ThreadEntryCallback(void*);
#else
	typedef pthread_t ThreadHandle;
	const int Infinite = 0x7fffffff;
	typedef void* ThreadEntryCallback(void*);
#endif

/**
	generate thread handle
	@param hdl [out] thread handle
	@param entryFct [in] thread entry
	@param arg [in] thread parameter
*/
inline bool Begin(ThreadHandle& hdl, ThreadEntryCallback entryFct, void *arg, int stackSize = 0)
{
#ifdef _WIN32
	unsigned int threadId = 0;
	hdl = reinterpret_cast<ThreadHandle>(_beginthreadex(0, stackSize, entryFct, arg, 0, &threadId));
	return hdl != 0;
#else
	pthread_attr_t attr;
	if (pthread_attr_init(&attr)) {
		perror("pthread_attr_init");
		return false;
	}
	int ret = 0;
	if (stackSize) {
		ret = pthread_attr_setstacksize(&attr, stackSize);
		if (ret) {
			perror("pthread_attr_setstacksize");
			goto EXIT;
		}
	}
	ret = pthread_create(&hdl, &attr, entryFct, arg);
EXIT:
	if (pthread_attr_destroy(&attr)) {
		perror("pthread_attr_destroy");
		return false;
	}
	return ret == 0;
#endif
}

inline bool Detach(ThreadHandle hdl)
{
#ifdef _WIN32
	int ret = CloseHandle(hdl);
	return ret != 0;
#else
	int ret = pthread_detach(hdl);
	return ret == 0;
#endif
}

/**
	join thread
	@param hdl [in] thread handle
	@param timeoutMsec [in] time out(msec)
*/
inline bool Join(ThreadHandle hdl, int timeoutMsec)
{
#ifdef _WIN32
	bool waitRet = WaitForSingleObject(hdl, timeoutMsec) == WAIT_OBJECT_0;
	bool closeRet = CloseHandle(hdl) != 0;
	return waitRet && closeRet;
#else
	if (timeoutMsec != Infinite) {
		fprintf(stderr, "not support timeout\n");
	}
	return pthread_join(hdl, NULL) == 0;
#endif
}

} // cybozu::thread

/**
	thread generator class
*/
class ThreadBase {
private:
	ThreadBase(const ThreadBase&);
	void operator=(const ThreadBase&);
	virtual void threadEntry() = 0;
protected:
	thread::ThreadHandle threadHdl_;

	/*
		thread loop interface
	*/
#ifdef _WIN32
	static unsigned __stdcall threadLoopIF(void *arg)
#else
	static void* threadLoopIF(void *arg)
#endif
	{
		ThreadBase* main = static_cast<ThreadBase*>(arg);
		main->threadEntry();
		return 0;
	}
public:
	ThreadBase()
		: threadHdl_(0)
	{
	}
	virtual ~ThreadBase()
	{
		joinThread();
	}

	bool beginThread(int stackSize = 0)
	{
		return thread::Begin(threadHdl_, threadLoopIF, this, stackSize);
	}

	bool detachThread()
	{
		thread::ThreadHandle hdl = cybozu::AtomicExchange<thread::ThreadHandle>(&threadHdl_, 0);
		if (hdl) {
			return thread::Detach(hdl);
		}
		return false;
	}

	bool joinThread(int waitMsec = thread::Infinite)
	{
		thread::ThreadHandle hdl = cybozu::AtomicExchange<thread::ThreadHandle>(&threadHdl_, 0);
		if (hdl) {
			return thread::Join(hdl, waitMsec);
		}
		return true;
	}
};

} // cybozu

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
