# x86 Assembly Knowledge Base for AIOS AI Agents

**Purpose**: Actionable x86 instruction reference for AI agents performing assembly code analysis, optimization, and refactoring.

**Last Updated**: 2016-07 (Intel Documentation)

---

## Knowledge Structure

This knowledge base provides:
1. **Instruction Signatures** - Operand types and combinations
2. **Semantic Descriptions** - What each instruction does
3. **CPU Extensions** - Required features (SSE, AVX, etc.)
4. **Use Cases** - When to use/optimize specific instructions

---

## Instruction Format

```
<MNEMONIC> <OPERANDS> <CPU_FLAGS> <FULL_SIGNATURE> <DESCRIPTION>
```

---

## Core Categories for AI Agents

### 1. Data Movement Instructions
**Purpose**: Transfer data between registers, memory, and immediate values

- `MOV` - Basic data movement (most common)
- `MOVQ`, `MOVD` - Move quadword/doubleword
- `LEA` - Load Effective Address (pointer arithmetic without memory access)
- `PUSH`/`POP` - Stack operations
- `XCHG` - Atomic exchange

**Refactoring Hints**:
- Replace `MOV reg, 0` with `XOR reg, reg` (smaller, faster)
- Use `LEA` for address calculations instead of `ADD`/`IMUL` chains
- Consider register pressure when optimizing `MOV` sequences

---

### 2. Arithmetic Instructions
**Purpose**: Integer and floating-point calculations

#### Integer
- `ADD`, `SUB` - Basic arithmetic
- `INC`, `DEC` - Increment/decrement (may have flag dependencies)
- `IMUL`, `MUL` - Multiply (signed/unsigned)
- `IDIV`, `DIV` - Division (expensive, consider alternatives)
- `ADC`, `SBB` - Add/subtract with carry (for multi-precision)

#### SIMD/Vector
- `ADDPS/ADDPD` - Packed single/double precision add (SSE)
- `VADDPS/VADDPD` - Vector add (AVX, 256-bit)
- `MULPS/MULPD` - Packed multiply

**Refactoring Hints**:
- Avoid `DIV` when possible (use bit shifts for powers of 2)
- Vectorize loops using SIMD instructions
- Replace `INC`/`DEC` with `ADD`/`SUB` on modern CPUs (no partial flag stalls)

---

### 3. Logical & Bitwise Instructions
**Purpose**: Boolean operations, bit manipulation

- `AND`, `OR`, `XOR` - Basic bitwise ops
- `NOT` - Bitwise complement
- `TEST` - Non-destructive AND (sets flags)
- `BT`, `BTS`, `BTR`, `BTC` - Bit test/set/reset/complement
- `SHL`, `SHR`, `SAL`, `SAR` - Shift operations
- `ROL`, `ROR`, `RCL`, `RCR` - Rotate operations

**Refactoring Hints**:
- `XOR reg, reg` is the canonical way to zero a register
- Use `TEST` instead of `AND` when you only need flags
- Bit manipulation can replace expensive branches

---

### 4. Control Flow Instructions
**Purpose**: Branching, loops, function calls

- `JMP` - Unconditional jump
- `Jcc` - Conditional jumps (JE, JNE, JG, JL, etc.)
- `CALL` - Function call
- `RET` - Return from function
- `LOOP`, `LOOPE`, `LOOPNE` - Loop with counter

**Refactoring Hints**:
- Minimize branch mispredictions (keep hot paths predictable)
- Consider `CMOV` (conditional move) to eliminate branches
- Use `TEST` + `Jcc` patterns for efficient conditionals

---

### 5. SIMD/Vector Instructions (SSE, AVX)
**Purpose**: Parallel data processing

#### SSE (128-bit)
- `MOVAPS/MOVAPD` - Move aligned packed single/double
- `MOVUPS/MOVUPD` - Move unaligned
- `ADDPS/ADDPD`, `MULPS/MULPD`, etc.

#### AVX (256-bit)
- `VADDPS`, `VMULPS` - Wider vectors
- `VBROADCASTSS` - Broadcast scalar to vector
- `VPERM*` - Permutation/shuffle operations

#### AVX-512 (512-bit)
- Masking support (`{k1}`, `{z}`)
- More registers (zmm0-zmm31)

**Refactoring Hints**:
- Ensure data alignment (16/32/64-byte boundaries)
- Use AVX when available for 2x throughput over SSE
- Consider instruction latency vs. throughput trade-offs

---

### 6. String & Comparison Instructions
**Purpose**: Bulk data operations

- `CMPS` - Compare strings
- `MOVS` - Move string data
- `STOS` - Store string
- `LODS` - Load string
- `SCAS` - Scan string
- `REP` prefix - Repeat operation

**Refactoring Hints**:
- Modern CPUs optimize `REP MOVS` internally
- Consider SIMD alternatives for small strings

---

## AI Agent Refactoring Strategies

### Pattern Recognition

1. **Loop Vectorization**
   ```asm
   ; BEFORE: Scalar loop
   loop_start:
       movss xmm0, [rsi]
       addss xmm0, xmm1
       movss [rdi], xmm0
       add rsi, 4
       add rdi, 4
       dec rcx
       jnz loop_start
   
   ; AFTER: Vectorized (4x throughput)
   loop_vectorized:
       movaps xmm0, [rsi]
       addps xmm0, xmm1
       movaps [rdi], xmm0
       add rsi, 16
       add rdi, 16
       sub rcx, 4
       jnz loop_vectorized
   ```

2. **Register Pressure Reduction**
   - Identify spilled registers (MOV to stack)
   - Reuse dead registers
   - Consider register renaming opportunities

3. **Instruction Fusion**
   - CMP + Jcc can macro-fuse
   - TEST + Jcc can macro-fuse
   - Some ADD/SUB + Jcc patterns fuse

4. **Latency Hiding**
   - Reorder independent instructions
   - Interleave memory operations
   - Use non-temporal stores for streaming data

---

## CPU Extension Detection

| Extension | Purpose | Key Instructions |
|-----------|---------|------------------|
| SSE | 128-bit SIMD | ADDPS, MULPS, MOVAPS |
| SSE2 | Integer SIMD | PADDQ, PMULUDQ |
| AVX | 256-bit vectors | VADDPS, VMULPS |
| AVX2 | Enhanced AVX | Gather/scatter, FMA |
| AVX-512 | 512-bit + masking | VADDPD zmm, KMOV |
| BMI1/BMI2 | Bit manipulation | ANDN, BLSI, PDEP |
| AES-NI | Crypto | AESENC, AESDEC |
| FMA | Fused multiply-add | VFMADD* |

---

## Common Optimization Patterns

### Memory Access
```
BAD:  Multiple scattered loads
GOOD: Batch loads, prefetch, align data
```

### Branch-Heavy Code
```
BAD:  Many unpredictable branches
GOOD: CMOV, lookup tables, branch-free algorithms
```

### Floating-Point
```
BAD:  x87 FPU instructions (ST0, etc.)
GOOD: SSE/AVX scalar/vector ops
```

---

## Agent Decision Framework

When analyzing assembly code, AI agents should:

1. **Identify Hot Paths** - Focus on frequently executed code
2. **Detect Anti-Patterns** - Flag inefficient instruction sequences
3. **Check Alignment** - Verify data structure alignment for SIMD
4. **Analyze Dependencies** - Find instruction-level parallelism opportunities
5. **Validate Extensions** - Ensure target CPU supports used instructions
6. **Calculate Throughput** - Estimate cycles per iteration
7. **Suggest Alternatives** - Propose optimized instruction sequences

---

## Integration with AIOS

### Recommended Usage

1. **Context Injection**: Provide relevant instruction knowledge before refactoring tasks
2. **Pattern Library**: Build reusable transformation patterns
3. **Validation**: Cross-reference changes against this knowledge base
4. **Learning Loop**: Update patterns based on performance results

### Example Agent Prompt Template

```
You are optimizing x86 assembly code. Available context:
- Target CPU: [Intel/AMD with AVX2]
- Hot path: [loop processing float arrays]
- Current throughput: [X cycles/iteration]

Relevant instructions:
{inject relevant section from knowledge base}

Analyze and propose optimizations focusing on:
1. Vectorization opportunities
2. Memory access patterns
3. Register allocation
4. Instruction fusion
```

---

## Source Data

- **Instruction Database**: `signature-june2016.txt` (4490 entries)
- **HTML Documentation**: `html/` directory (detailed per-instruction pages)
- **Generation Tool**: `Java/SignatureGenerator` (Java 21)

---

## Limitations & Notes

- Data is from 2016 Intel documentation (pre-AVX-512 widespread adoption)
- Does not include AMD-specific extensions
- Missing some newer instructions (AVX-VNNI, AMX, etc.)
- Focus on user-mode instructions (excludes system/privileged ops)

---

## Future Enhancements for AIOS

1. **Dynamic Updates** - Fetch latest instruction sets from Intel/AMD
2. **Performance Database** - Add latency/throughput data per microarchitecture
3. **Code Pattern Corpus** - Machine learning on real-world optimization examples
4. **Interactive Validation** - Test proposed changes in sandboxed environment
5. **Multi-Architecture** - Extend to ARM, RISC-V for cross-platform analysis

---

*This knowledge base is designed to be consumed by AI agents as actionable context for assembly code understanding and refactoring tasks within AIOS.*
