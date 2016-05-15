require 'test_helper'

module ActiveModel
  class Serializer
    class IncludeTree
      class FromStringTest < ActiveSupport::TestCase
        def test_simple_array
          input = [:comments, :author]
          actual = ActiveModel::Serializer::IncludeTree.from_include_args(input)
          assert(actual.key?(:author))
          assert(actual.key?(:comments))
        end

        def test_simple_array_with_dasherized_keys
          input = [:comments, 'related-posts']
          actual = ActiveModel::Serializer::IncludeTree.from_include_args(input)
          assert(actual.key?(:comments))
          assert(actual.key?(:related_posts))
        end

        def test_nested_array
          input = [:comments, posts: [:author, 'related-posts', comments: [:author]]]
          actual = ActiveModel::Serializer::IncludeTree.from_include_args(input)
          assert(actual.key?(:posts))
          assert(actual[:posts].key?(:author))
          assert(actual[:posts].key?(:comments))
          assert(actual[:posts].key?(:related_posts))
          assert(actual[:posts][:comments].key?(:author))
          assert(actual.key?(:comments))
        end
      end
    end
  end
end
