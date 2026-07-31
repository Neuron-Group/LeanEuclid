# LeanEuclid

This repository now contains only the Lean implementation of the Euclidean proof system `SystemE`.

## What remains

- `SystemE/`: the core geometric sorts, relations, constructions, and inference rules
- `SystemE.lean`: the public import for writing Euclidean proofs in Lean
- lightweight helper tactics such as `euclid_intros`, `euclid_apply`, and `euclid_finish`

## What was removed

- SMT-based proving support
- autoformalization pipelines
- benchmark proof corpora and evaluation code

## Build

```bash
lake exe cache get
lake build
```

## Usage

Import `SystemE` in your Lean file:

```lean
import SystemE
```

This exposes the Euclidean language and rules for writing proofs directly in Lean.
