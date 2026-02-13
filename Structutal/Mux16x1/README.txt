# 16x1 Multiplexer Implementation - Version Evolution

## Overview
This project demonstrates the design and implementation of a 16-to-1 multiplexer (MUX) using different
modeling approaches in Verilog, progressing from high-level behavioral descriptions to low-level gate-level implementations.

---
## Version 1: Behavioral 16x1 Multiplexer

### Design Approach
Modeling Style: Behavioral (Dataflow)

This is the simplest implementation using Verilog's continuous assignment with dynamic bit selection.

### Circuit Architecture
```
Input [15:0] ──────────┐
                       ├──> Bit Selection ──> Output
Selector [3:0] ────────┘
```

### Implementation Details
- **Inputs:** 
  - `in[15:0]` - 16-bit input data
  - `sel[3:0]` - 4-bit selector (0-15)

- **Output:** 
  - `out` - Selected single bit

- **Logic:** `out = in[sel]` - Direct bit indexing

### Advantages
✓ Simplest and most concise code  
✓ Easy to understand  
✓ Efficient for synthesis  
✓ Good for quick prototyping  

### Limitations
✗ Doesn't show hierarchical design  
✗ Difficult to extend to larger systems  
✗ No component reusability  

### Use Case
Quick functional verification, behavioral simulation, high-level system design.

---

## Version 2: Structural 16x1 with Behavioral 4x1

### Design Approach
**Modeling Style:** Structural (hierarchical) with behavioral leaf nodes

This version demonstrates hierarchical design by combining smaller multiplexer blocks.

### Circuit Architecture
```
Input [15:0]
    ├─ [3:0]   ──> mux4x1 M0 ──┐
    ├─ [7:4]   ──> mux4x1 M1 ──┤
    ├─ [11:8]  ──> mux4x1 M2 ──┼──> mux4x1 M4 ──> Output
    └─ [15:12] ──> mux4x1 M3 ──┘

Selector [3:0]
    ├─ sel[1:0] ──> M0, M1, M2, M3 (select 1 bit from each 4-bit slice)
    └─ sel[3:2] ──> M4            (select final output)
```

### Implementation Details

**mux16x1 (Structural):**
- Divides 16-bit input into four 4-bit slices
- Each slice routed to a 4x1 multiplexer (M0-M3)
- Lower 2 bits of selector (`sel[1:0]`) controls M0-M3
- Upper 2 bits of selector (`sel[3:2]`) controls final multiplexer M4
- Intermediate results stored in `t[3:0]` wire

**mux4x1 (Behavioral):**
- Takes 4-bit input and 2-bit selector
- Returns single bit: `out = in[sel]`

### Advantages
✓ Demonstrates hierarchical design  
✓ Component reusability (mux4x1)  
✓ Clear separation of concerns  
✓ Scalable architecture  
✓ Easier to test individual stages  

### Limitations
✗ Mixes behavioral and structural (inconsistent style)  
✗ Synthesis tools may not optimize hierarchically  

### Use Case
Intermediate-level designs, demonstrating design hierarchy, component-based architecture.

---

## Version 3: Pure Structural Hierarchy (4-Level Tree)

### Design Approach
**Modeling Style:** Structural (fully hierarchical) - 4-level tree

This version implements a complete bottom-up design using only structural descriptions.

### Circuit Architecture
```
Level 1: Gate-level 2x1 MUX (Behavioral baseline)
    ├─ mux2x1 (in[1:0], sel[0])
    └─ mux2x1 (in[3:2], sel[0])

Level 2: Structural 4x1 MUX (Tree of 2x1)
    ├─ mux2x1 M0 ──┐
    ├─ mux2x1 M1 ──┼── mux2x1 M2 ──> out
    └─ sel[1]

Level 3: Structural 16x1 MUX (Parallel 4x1 trees)
    ├─ mux4x1 M0 ──┐
    ├─ mux4x1 M1 ──┼── mux4x1 M4 ──> out
    ├─ mux4x1 M2 ──┤
    └─ mux4x1 M3 ──┘

Final: 16-input selector
    sel[1:0] ──> M0-M3
    sel[3:2] ──> M4
```

### Implementation Details

**mux2x1 (Behavioral):**
- Simplest building block: `out = in[sel]`
- Used as base for all higher-level multiplexers

**mux4x1 (Structural tree):**
- M0 selects between bits [1:0] using sel[0]
- M1 selects between bits [3:2] using sel[0]
- M2 selects final output using sel[1]
- Forms a 2-level multiplexer tree

**mux16x1 (Structural):**
- M0-M3: Four parallel 4x1 multiplexers
- M4: Final stage 4x1 multiplexer
- Selector bits distributed: `sel[1:0]` to M0-M3, `sel[3:2]` to M4

### Advantages
✓ Pure structural design (no behavioral elements)  
✓ Complete hierarchical tree  
✓ Demonstrates multi-level modularity  
✓ Easy to extend to larger multiplexers (32x1, 64x1, etc.)  
✓ Good for understanding design hierarchy  
✓ Suitable for detailed analysis

### Limitations
✗ More modules to manage and test  
✗ Deeper instantiation hierarchy  

### Use Case
Educational purposes, learning hierarchical design, complex system architecture.

---

## Version 4: Gate-Level Implementation (FINAL)

### Design Approach
**Modeling Style:** Structural gate-level + hierarchical tree

This is the most detailed implementation showing actual logic gates and demonstrating the complete design from gates to system level.

### Circuit Architecture

**mux2x1 (Gate-Level Implementation):**
```
in[0] ──────────> AND (G2) ──┐
      └─> NOT (G1)            ├──> OR (G4) ──> out
in[1] ──────────> AND (G3) ──┘
sel    ────────────────────────
```

**Logic Expression:** `out = (in[0] & ~sel) | (in[1] & sel)`

**mux4x1 (Tree of mux2x1 gates):**
```
in[1:0] ──> mux2x1 M0 ──┐
in[3:2] ──> mux2x1 M1 ──┼──> mux2x1 M2 ──> out
sel[1]   ─────────────────

sel[0] controls M0 and M1
sel[1] controls M2
```

**mux16x1 (Parallel trees of mux4x1):**
```
in[3:0]   ──> mux4x1 M0 ──┐
in[7:4]   ──> mux4x1 M1 ──┤
in[11:8]  ──> mux4x1 M2 ──┼──> mux4x1 M4 ──> out
in[15:12] ──> mux4x1 M3 ──┘

sel[1:0] controls M0, M1, M2, M3
sel[3:2] controls M4
```

### Implementation Details

**Gate-Level mux2x1:**
```verilog
wire t1, t2, t3;
not G1 (t1, sel);
and G2 (t2, in[0], t1);
and G3 (t3, in[1], sel);
or  G4 (out, t2, t3);
```

- G1: Inverter for NOT gate
- G2, G3: AND gates for conditional selection
- G4: OR gate for final output

**Tree Propagation:**
- Each 4x1 mux uses 3 OR gates and 5 NOT/AND gates = 8 gates
- Each 16x1 mux uses 4×(mux4x1) + 1×(mux4x1) = 5 mux4x1 blocks

### Advantages
✓ **Low-level detail:** Shows actual gate implementations  
✓ **Gate-level timing:** Can model propagation delays  
✓ **Hardware realistic:** Reflects actual hardware implementation  
✓ **Educational:** Demonstrates logic gate operation  
✓ **Complete hierarchy:** From gates → 2x1 → 4x1 → 16x1  
✓ **Fully structural:** No behavioral descriptions  

### Limitations
✗ Complex and verbose code  
✗ Difficult to modify or extend  
✗ More challenging to debug  
✗ Slower simulation due to gate-level detail  

### Use Case
Detailed hardware design, gate-level simulation, timing analysis, low-level debugging, hardware implementation reference.

---

## Design Progression Summary

|-----------------------|------------|-------------------------|------------------|-----------------------|
|       Aspect          | V1         | V2                      | V3               | V4                    |
|-----------------------|------------|-------------------------|------------------|-----------------------|
| **Modeling**          | Behavioral | Structural + Behavioral | Fully Structural | Gate-level Structural |
| **Hierarchy Depth**   | 1          | 2                       | 3                | 4                     |
| **Components**        | 1 module   | 2 modules               | 3 modules        | 3 modules             |
| **Reusability**       | Low        | Medium                  | High             | Very High             |
| **Code Length**       | 5 lines    | 12 lines                | 20 lines         | 30 lines              |  
| **Simulation Speed**  | Fastest    | Fast                    | Medium           | Slowest               |
| **Hardware Insight**  | Minimal    | Low                     | Medium           | Very High             |
| **Scalability**       | Poor       | Good                    | Excellent        | Excellent             |
| **Educational Value** | Basic      | Intermediate            | Advanced         | Expert                |
|-----------------------|------------|-------------------------|------------------|-----------------------|

---

## Selector Bit Mapping

For a 16-to-1 multiplexer with 4-bit selector `sel[3:0]`:

```
sel[3:2] = 00: Selects from in[3:0]   (uses sel[1:0] to pick bit 0-3)
sel[3:2] = 01: Selects from in[7:4]   (uses sel[1:0] to pick bit 4-7)
sel[3:2] = 10: Selects from in[11:8]  (uses sel[1:0] to pick bit 8-11)
sel[3:2] = 11: Selects from in[15:12] (uses sel[1:0] to pick bit 12-15)
```

**Example:** To select bit 13:
- Binary: 1101 → sel[3:2]=11, sel[1:0]=01
- This routes to M3 (in[15:12]), then selects bit 1 of that slice = bit 13

---

## Testing Approach

All versions should be tested with:

1. **All 16 combinations** - Verify each selector value (0-15) outputs correct bit
2. **Test patterns:**
   - `0xAAAA` (alternating 1s and 0s)
   - `0x5555` (alternating 0s and 1s)
   - `0x0001` (only LSB set)
   - `0x8000` (only MSB set)
3. **Data integrity** - Ensure no data corruption from wrong lanes
4. **Edge cases** - All 0s, all 1s, mixed patterns

---

## Lessons Learned

1. **Behavioral vs Structural:** Behavioral is simpler but less detailed; structural shows design hierarchy
2. **Hierarchy Benefits:** Dividing 16x1 into 4x1→2x1 makes design manageable and reusable
3. **Gate-level Detail:** Shows actual hardware but increases complexity
4. **Top-down vs Bottom-up:** V1-3 are top-down decomposition; V4 shows bottom-up gate building

---

## File Structure

```
Mux16x1/
├── version1/
│   ├── mux16x1.v (Behavioral)
│   └── testbench.v
│
├── verison2/
│   ├── mux16x1.v (Structural)
│   ├── mux4x1.v (Behavioral)
│   └── README
│
├── verison3/
│   ├── mux16x1.v (Structural)
│   ├── mux4x1.v (Structural)
│   ├── mux2x1.v (Behavioral)
│   └── README
│
└── verison4 - Final/
    ├── mux16x1.v (Structural)
    ├── mux4x1.v (Structural)
    ├── mux2x1.v (Gate-level Structural)
    └── README
```