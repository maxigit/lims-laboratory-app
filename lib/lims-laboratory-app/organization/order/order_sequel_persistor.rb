# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'lims-laboratory-app/organization/order/order_persistor'
require 'lims-core/persistence/sequel/persistor'

module Lims::LaboratoryApp
  module Organization
    # Not a order but a order persistor.
    class Order
      class OrderSequelPersistor < OrderPersistor
        include Lims::Core::Persistence::Sequel::Persistor
        def self.table_name
          :orders
        end

        def filter_attributes_on_save(attributes, *params)
          attributes.mash do |k,v|
            case k
              # get id of object
            when  :creator then [:creator_id, @session.id_for!(v)]
            when :study then [:study_id, @session.id_for!(v)]
              # serialize structured object
            when :parameters, :state then [k, Marshal.dump(v) ]
            else [k, v]
            end
          end
        end

        def filter_attributes_on_load(attributes)
          attributes.mash do |k,v|
            case k
            when :creator_id then [:creator, @session.user[v]]
            when :study_id then [:study, @session.study[v]]
            when :parameters, :state then [k, Marshal.load(v) ]
            else [k, v]
            end
          end
        end
      end

      class Item
        class ItemSequelPersistor < ItemPersistor
          include Lims::Core::Persistence::Sequel::Persistor

          def self.table_name
            :items
          end

          def loads(order_id)
            dataset.filter(:order_id => order_id).order(:id).each do |att|
              role = att.delete(:role)
              item = @session.order.item.get_or_create_single_model(att[:id], att)
              yield(role, item)
            end
          end
        end
      end
    end
  end
end
