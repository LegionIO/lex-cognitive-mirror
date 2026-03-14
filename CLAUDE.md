# lex-cognitive-mirror

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`

## Purpose

Theory of mind and empathic mirroring engine. Observes actions by other agents, simulates their likely intent, and tracks per-agent resonance scores (how aligned the agent is with the observer). Resonance boosts on each simulation and decays on each decay cycle. Accuracy tracking compares simulated outcomes against actual ones. Three separate runner modules split responsibilities: observation, simulation, and resonance management.

## Gem Info

- **Gem name**: `lex-cognitive-mirror`
- **Module**: `Legion::Extensions::CognitiveMirror`
- **Version**: `0.1.0`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/cognitive_mirror/
  version.rb
  client.rb
  helpers/
    constants.rb
    mirror_engine.rb
  runners/
    observe.rb
    simulate.rb
    resonance.rb
```

## Key Constants

| Constant | Value | Purpose |
|---|---|---|
| `MAX_EVENTS` | `500` | Observation event ring buffer capacity |
| `MAX_SIMULATIONS` | `300` | Simulation record capacity |
| `DEFAULT_RESONANCE` | `0.5` | Starting resonance for new agents |
| `RESONANCE_BOOST` | `0.1` | Resonance increase per simulation |
| `RESONANCE_DECAY` | `0.03` | Per-cycle resonance decay |
| `ACTION_TYPES` | symbol array | Valid observable action types |
| `RESONANCE_LABELS` | range hash | From `:estranged` to `:deeply_resonant` |
| `CONFIDENCE_LABELS` | range hash | Simulation confidence labels |
| `EMPATHY_LABELS` | range hash | Empathy level labels |

## Helpers

### `Helpers::MirrorEngine`
Central engine with `INTENT_MAP` mapping action types to likely intents.

- `observe(agent_id:, action_type:, content:, context:)` → event record; appended to ring buffer
- `simulate(event_id:)` → derives outcome and intent via `INTENT_MAP`; boosts agent resonance by `RESONANCE_BOOST`
- `record_accuracy(simulation_id:, actual_outcome:)` → accuracy record for the simulation
- `empathic_resonance(agent_id:)` → current resonance float for agent
- `boost_resonance(agent_id:, amount:)` → directly boost resonance
- `decay_resonance(agent_id:)` → decay single agent's resonance by `RESONANCE_DECAY`
- `decay_all_resonances` → decay all known agents
- `simulation_accuracy_for(agent_id:)` → accuracy stats for agent
- `events_for(agent_id:)` → all observation events for agent
- `simulation_history(limit:)` → recent simulations
- `known_agents` → list of agent IDs with resonance scores

## Runners

### `Runners::Observe`
| Method | Description |
|---|---|
| `observe_action(agent_id:, action_type:, content:, context:)` | Record an observed action |
| `list_events(agent_id:, limit:)` | Events for an agent |

### `Runners::Simulate`
| Method | Description |
|---|---|
| `simulate_action(event_id:)` | Simulate intent for an observed event |
| `record_simulation_accuracy(simulation_id:, actual_outcome:)` | Record actual outcome vs simulated |
| `simulation_history(limit:)` | Recent simulation records |

### `Runners::Resonance`
| Method | Description |
|---|---|
| `empathic_resonance(agent_id:)` | Current resonance for agent |
| `decay_resonances(agent_id:)` | Decay one or all agent resonances |
| `resonance_summary` | All agents and their resonance scores |

All runners return `{success: true/false, ...}` hashes.

## Integration Points

- `lex-mesh`: mirror observations are naturally triggered by mesh message receipt — observe the sending agent's action
- `lex-trust`: resonance scores complement trust scores; high resonance + high trust = most reliable agents
- `lex-tick` `mesh_interface` phase: observe all incoming mesh messages before processing
- `lex-identity`: behavioral fingerprint and empathic resonance are parallel models — fingerprint tracks the human partner, resonance tracks digital agents

## Development Notes

- `Client` includes all three runner modules (`Observe`, `Simulate`, `Resonance`)
- `INTENT_MAP` is a static hash — intent inference is deterministic based on action type; no ML
- Resonance is bounded [0.0, 1.0] via clamping in `boost_resonance` and `decay_resonance`
- `MAX_EVENTS = 500` is a ring buffer; oldest events are dropped when full
- Simulation accuracy requires a follow-up `record_accuracy` call from the caller after the actual outcome is known
