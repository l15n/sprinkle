module Sprinkle
  module Verifiers
    # = Ruby Verifiers
    #
    # The verifiers in this module are ruby specific. 
    module Ruby
      Sprinkle::Verify.register(Sprinkle::Verifiers::Ruby)
      
      # Checks if ruby can require the <tt>files</tt> given. <tt>rubygems</tt>
      # is always included first.
      def ruby_can_load(*files)
        # Always include rubygems first
        files = files.unshift('rubygems').collect { |x| "require '#{x}'" }
        
        @commands << "ruby -e \"#{files.join(';')}exit\""
      end
      
      # Checks if a gem exists by calling "sudo gem list" and grepping against it.
      def has_gem(name, version=nil)
        version = version.nil? ? '' : version.gsub('.', '\.')
        @commands << "sudo gem list | grep -e '^#{name} (.*#{version}.*)$'"
      end
    end
  end
end