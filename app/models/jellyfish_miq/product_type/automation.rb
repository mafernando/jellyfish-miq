module JellyfishMiq
  module ProductType
    class Automation < ::ProductType
      def self.load_product_types
        return unless super

        transaction do
          [
            set('MIQ Automation', '237b2981-9c2e-49d1-be4c-2f5de3a8d6ff', provider_type: 'JellyfishMiq::Provider::Miq', active: 'false')
          ].each do |s|
            create! s.merge!(type: 'JellyfishMiq::ProductType::Automation')
          end
        end
      end

      def description
        'MIQ Automation'
      end

      def tags
        %w(compute automation)
      end

      def product_questions
        [
          { name: :uri_namespace, value_type: :string, field: :text, label: 'URI Namespace', required: true },
          { name: :uri_class, value_type: :string, field: :text, label: 'URI Class', required: true },
          { name: :uri_instance, value_type: :string, field: :text, label: 'URI Instance', required: true },
          { name: :auto_approve, value_type: :boolean, field: :checkbox, label: 'Auto Approve Requests', required: false },
          { name: :environment, value_type: :string, field: :environments, label: 'MIQ Environment', required: false }
        ]
      end

      def product_class
        'JellyfishMiq::Product::Automation'.constantize
      end
    end
  end
end
