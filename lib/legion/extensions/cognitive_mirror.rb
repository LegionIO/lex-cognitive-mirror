# frozen_string_literal: true

require 'legion/extensions/cognitive_mirror/version'
require 'legion/extensions/cognitive_mirror/helpers/constants'
require 'legion/extensions/cognitive_mirror/helpers/mirror_event'
require 'legion/extensions/cognitive_mirror/helpers/simulation'
require 'legion/extensions/cognitive_mirror/helpers/mirror_engine'
require 'legion/extensions/cognitive_mirror/runners/observe'
require 'legion/extensions/cognitive_mirror/runners/simulate'
require 'legion/extensions/cognitive_mirror/runners/resonance'
require 'legion/extensions/cognitive_mirror/client'

module Legion
  module Extensions
    module CognitiveMirror
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
