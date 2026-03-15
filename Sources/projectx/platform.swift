enum Architecture {
  case arm
  case arm64
  case i386
  case wasm32
  case x86_64
}

#if arch(arm)
  let architecture = Architecture.arm
#elseif arch(arm64)
  let architecture = Architecture.arm64
#elseif arch(i386)
  let architecture = Architecture.i386
#elseif arch(wasm32)
  let architecture = Architecture.wasm32
#elseif arch(x86_64)
  let architecture = Architecture.x86_64
#endif
