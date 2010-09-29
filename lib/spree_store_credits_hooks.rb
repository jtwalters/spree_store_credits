class SpreeStaticContentHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_configurations_menu do
    "<%= configurations_menu_item(I18n.t('store_credits'), admin_store_credits_url, I18n.t('manage_store_credits')) %>"
  end
  
    
  insert_after :admin_users_index_row_actions do
    %(&nbsp;
      <%= link_to_with_icon('add', t('add_store_credit'), new_admin_user_store_credit_url(user)) %>
     )     
  end
  
  insert_after :checkout_payment_step do
    %(
    <% if (current_user.store_credits_total > 0) %>
    <br style='clear:both;' />
    <p><%= t('you_have_store_credit', 
            :amount => number_to_currency(current_user.store_credits_total))%>
    </p>
    <p>
      <label><%= t('enter_desired_amount_of_store_credit') %></label><br />
      <%= form.text_field :store_credit_amount, :size => 19 %>
    </p>
    <% end %>
    )
  end
  
  insert_after :account_my_orders, :partial => 'users/store_credits'
  
  insert_after :order_details_adjustments do
    %(
    <% if @order.store_credits.present? && !@order.completed? %>
      <tr><td colspan="4">
      <%= check_box :order, :remove_store_credits %> <%= label :order, :remove_store_credits %>
      </td></tr>
    <% end %>
    )
  end
end
