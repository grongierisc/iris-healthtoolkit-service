local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.helloworld.access"

local concat = table.concat
local lower = string.lower
local find = string.find
local kong = kong
local ngx = ngx

local HelloWorldHandler = BasePlugin:extend()

function HelloWorldHandler:new()
  HelloWorldHandler.super.new(self, "helloworld")
end

function HelloWorldHandler:header_filter(conf)
  HelloWorldHandler.super.header_filter(self)
  access.execute_header(conf)
end

function HelloWorldHandler:body_filter(conf)
  HelloWorldHandler.super.body_filter(self)

  local ctx = ngx.ctx
  local chunk, eof = ngx.arg[1], ngx.arg[2]

  ctx.rt_body_chunks = ctx.rt_body_chunks or {}
  ctx.rt_body_chunk_number = ctx.rt_body_chunk_number or 1

  if eof then
    local chunks = concat(ctx.rt_body_chunks)
    local body = access.execute_body(conf,chunks)
    ngx.arg[1] = body or chunks
  else
    ctx.rt_body_chunks[ctx.rt_body_chunk_number] = chunk
    ctx.rt_body_chunk_number = ctx.rt_body_chunk_number + 1
    ngx.arg[1] = nil
  end
end

return HelloWorldHandler
