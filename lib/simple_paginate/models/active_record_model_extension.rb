module SimplePaginate
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      def self.paginate(options = {})
        options = options.dup
        page = (options.delete(:page) || 1).to_i
        per_page = (options.delete(:per_page) || SimplePaginate.config.default_per_page).to_i

        offset(per_page * (page - 1)).limit(per_page + 1).extending do
          def current_page
            (offset_value / (limit_value - 1)) + 1
          end

          def first_page?
            current_page == 1
          end

          def last_page?
            actual_records_length < limit_value
          end

          def actual_records_length
            loaded? ? @actual_records.length : count(:all)
          end

          private

          def exec_queries
            @actual_records = super
            @records = if @actual_records.length > 1 && @actual_records.length == limit_value
                         @actual_records.first(limit_value - 1)
                       else
                         @actual_records
                       end
            @records
          end
        end
      end
    end
  end
end
