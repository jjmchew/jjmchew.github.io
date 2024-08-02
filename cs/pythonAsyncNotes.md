# Asynchronous Python

- 3 options:
  - multi-threading:
    - using a single CPU core, but running multiple threads with that core
    - can handle 10s to 100s of threads
    - for i/o bound code
  - multi-processing
    - leveraging each available CPU core to create a new python interpreter process
    - can handle only 10s of processes
    - for CPU bound code
  - asynchronous
    - use asyncio, async/await
    - co-operative multi-tasking
    - for 1000s to 10ks of tasks
    - for i/o bound code
  
- official async python started in 2003
- "modern python" (v3.7+) involves async/await

- `async`:  creates a coroutine (function)
- `await`:  used to seek control to start another coroutine
  - indicates that a coroutine should NOT be blocking (opposite of await in javascript)
- `asyncio`: includes a scheduler (`asyncio.run()`)
  - search "awesome asyncio" to find async libraries for python
  - `asyncio.sleep()` is a non-blocking version of `time.sleep()`

- `tasks = [asyncio.Task(coroutine())]` : will execute a task when encountered
  - can use `gather` later to wait for these tasks to finish
- if `tasks = [coroutine(()]` : tasks will not execute when encountered
  - `await asyncio.gather(*tasks)` : will execute tasks when encountered

- `gather` will also return results from any coroutines (i.e., coroutine objects)
  - but will wait for all coroutines to finish
  - `results = asyncio.gather(a, b, c, d)`

- `asyncio.as_completed` will return coroutines as soon as they are completed
  - `for coroutine in asyncio.as_completed([a, b, c, d])` (where a, b, c, d, are tasks)




