--require 'socket' -- for having a sleep function ( could also use os.execute(sleep 10))
--timer = function (time)
    --local init = os.time()
    --local diff=os.difftime(os.time(),init)
    --while diff<time do
        --coroutine.yield(diff)
        --diff=os.difftime(os.time(),init)
    --end
    --print( 'Timer timed out at '..time..' seconds!')
--end
--co=coroutine.create(timer)
--coroutine.resume(co,30) -- timer starts here!
--while coroutine.status(co)~="dead" do
    --print("time passed",select(2,coroutine.resume(co)))
    --print('',coroutine.status(co))
    --socket.sleep(5)
--end

local function timer_coroutine(seconds, fn)
    local init = os.time()
    local diff = 0
    while diff < seconds do
        coroutine.yield(diff)
        diff = os.difftime(os.time(),init)
    end
    fn()
end

local function timeout(fn, seconds)
    local co = coroutine.create(timer_coroutine)
    coroutine.resume(co, seconds, fn) -- timer starts here!
    --while coroutine.status(co)~="dead" do
        ----socket.sleep(5)
        --os.execute("sleep 5")
    --end
    return co
end


return {
    timeout = timeout
}
