require 'helper'

# Unit tests for Rails mode
class TestRailsMode < Test::Unit::TestCase

  context "Rails2 mode" do
    teardown do
      Object.send(:remove_const, "RAILS_ROOT")
    end

    should "be invalid due to missing RAILS_ROOT" do
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro not configured correctly").nil? }
      # so teardown doesn't fail
      Object.const_set("RAILS_ROOT", "blah")
    end

    should "be invalid due to missing maestro directory" do
      Object.const_set("RAILS_ROOT", File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-missing-maestro'))
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro config directory does not exist").nil? }
    end

    should "be invalid due to maestro not a directory" do
      Object.const_set("RAILS_ROOT", File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-maestro-not-a-directory'))
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro config directory is not a directory").nil? }
    end

    should "be invalid due to missing clouds directory" do
      Object.const_set("RAILS_ROOT", File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-missing-clouds'))
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro clouds config directory does not exist").nil? }
    end

    should "be invalid due to clouds not a directory" do
      Object.const_set("RAILS_ROOT", File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-clouds-not-a-directory'))
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro clouds config directory is not a directory").nil? }
    end

    should "be invalid due to missing cookbooks directory" do
      Object.const_set("RAILS_ROOT", File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-missing-cookbooks'))
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Chef cookbooks directory does not exist").nil? }
    end

    should "be invalid due to cookbooks not a directory" do
      Object.const_set("RAILS_ROOT", File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-cookbooks-not-a-directory'))
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Chef cookbooks directory is not a directory").nil? }
    end

    should "be invalid due to missing roles directory" do
      Object.const_set("RAILS_ROOT", File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-missing-roles'))
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Chef roles directory does not exist").nil? }
    end

    should "be invalid due to roles not a directory" do
      Object.const_set("RAILS_ROOT", File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-roles-not-a-directory'))
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Chef roles directory is not a directory").nil? }
    end
  end


  context "Rails3 mode" do
    setup do
    end
    
    teardown do
      class ::Rails
        class <<self
          undef :root if defined?(Rails.root)
        end
      end
    end

    should "be invalid due to missing Rails.root" do
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro not configured correctly").nil? }
    end

    should "be invalid due to missing maestro directory" do
      class ::Rails
        def self.root
          File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-missing-maestro')
        end
      end
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro config directory does not exist").nil? }
    end

    should "be invalid due to maestro not a directory" do
      class ::Rails
        def self.root
          File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-maestro-not-a-directory')
        end
      end
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro config directory is not a directory").nil? }
    end

    should "be invalid due to missing clouds directory" do
      class ::Rails
        def self.root
          File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-missing-clouds')
        end
      end
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro clouds config directory does not exist").nil? }
    end

    should "be invalid due to clouds not a directory" do
      class ::Rails
        def self.root
          File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-clouds-not-a-directory')
        end
      end
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Maestro clouds config directory is not a directory").nil? }
    end

    should "be invalid due to missing cookbooks directory" do
      class ::Rails
        def self.root
          File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-missing-cookbooks')
        end
      end
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Chef cookbooks directory does not exist").nil? }
    end

    should "be invalid due to cookbooks not a directory" do
       class ::Rails
        def self.root
          File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-cookbooks-not-a-directory')
        end
      end
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Chef cookbooks directory is not a directory").nil? }
    end

    should "be invalid due to missing roles directory" do
      class ::Rails
        def self.root
          File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-missing-roles')
        end
      end
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Chef roles directory does not exist").nil? }
    end

    should "be invalid due to roles not a directory" do
      class ::Rails
        def self.root
          File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'invalid-roles-not-a-directory')
        end
      end
      result = Maestro.validate_configs
      assert !result[0]
      assert result[1].any? {|message| !message.index("Chef roles directory is not a directory").nil? }
    end
  end
end
