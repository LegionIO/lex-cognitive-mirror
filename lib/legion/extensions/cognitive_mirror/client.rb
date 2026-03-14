# frozen_string_literal: true

require 'legion/extensions/cognitive_mirror/helpers/constants'
require 'legion/extensions/cognitive_mirror/helpers/mirror_event'
require 'legion/extensions/cognitive_mirror/helpers/simulation'
require 'legion/extensions/cognitive_mirror/helpers/mirror_engine'
require 'legion/extensions/cognitive_mirror/runners/observe'
require 'legion/extensions/cognitive_mirror/runners/simulate'
require 'legion/extensions/cognitive_mirror/runners/resonance'

module Legion
  module Extensions
    module CognitiveMirror
      class Client
        include Runners::Observe
        include Runners::Simulate
        include Runners::Resonance

        def initialize(**)
          @mirror_engine = Helpers::MirrorEngine.new
        end

        private

        attr_reader :mirror_engine
      end
    end
  end
end
