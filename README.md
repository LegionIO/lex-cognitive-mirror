# lex-cognitive-mirror

Theory of mind and empathic mirroring for LegionIO cognitive agents. Observe other agents' actions, simulate their intent, track resonance scores, and measure simulation accuracy against actual outcomes.

## What It Does

- Observe actions from other agents (record into event ring buffer)
- Simulate likely intent for observed events using an intent map
- Each simulation boosts resonance with that agent
- Resonance scores decay over time
- Record actual outcomes to measure simulation accuracy
- Track per-agent resonance, confidence, and empathy labels
- Three focused runner modules: `Observe`, `Simulate`, `Resonance`

## Usage

```ruby
# Observe an action
runner.observe_action(agent_id: 'agent-123', action_type: :propose,
                       content: 'suggesting a new approach', context: { domain: :architecture })
# => { success: true, event_id: '...', agent_id: 'agent-123' }

# Simulate intent for the event
runner.simulate_action(event_id: event_id)
# => { success: true, simulation_id: '...', simulated_intent: :collaboration, confidence: 0.7, ... }

# Record actual outcome to track accuracy
runner.record_simulation_accuracy(simulation_id: sim_id, actual_outcome: :collaboration)

# Check resonance
runner.empathic_resonance(agent_id: 'agent-123')
# => { success: true, agent_id: 'agent-123', resonance: 0.6, label: :resonant }

# Decay all resonances (call each tick)
runner.decay_resonances(agent_id: nil)

# Summary of all known agents
runner.resonance_summary
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
