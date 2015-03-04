module SimplePaginate
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    included do
      def self.paginate(options = {})
        options = options.dup
        page = options.delete(:page) || 1
        per_page = options.delete(:per_page) || SimplePaginate.config.default_per_page 

        offset(per_page * (page - 1)).limit(per_page + 1).extending do
          def current_page
            (offset_value / (limit_value - 1)) + 1
          end

          def first_page?
            current_page == 1
          end

          def last_page?
            length < limit_value
          end
        end
      end
    end
  end
end
