module SimplePaginate
  module ActiveRecordModelExtension
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
            loaded? ? @actual_records.length < limit_value : count(:all) < limit_value
          end

          def per(num)
            if (n = num.to_i) < 0 || !(/^\d/ =~ num.to_s)
              self
            elsif n.zero?
              limit(n + 1)
            else
              limit(n + 1).offset(offset_value / (limit_value - 1) + 1)
            end
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

      def self.page(num = nil)
        paginate(page: num)
      end
    end
  end
end
