class ContactsController < ApplicationController

  def create
    @user = User.find params[:user_id]
    contact = @user.contacts.create :data => params[:contact]
    
    if contact.data
      body = ''
      contact.data.each {|key, value| body += "#{key} = #{value}\n" }
    
      Pony.mail :to      => user.email, 
                :from    => 'noreply@', 
                :subject => "Contact form filled in", 
                :body    => body,
                :via     => :sendmail
    end
    
    render :update do |page|
      page.replace_html('contact_form', :text => 'thanks')
    end
  end

end

      # 
      # 
      # Pony.mail :to      => 'nahum.wild@gmail.com', 
      #           :from    => 'nahum.wild@gmail.com', 
      #           :subject => "Contact form filled in", 
      #           :body    => 'oentuhnotehunotehunounoenuhnount',
      #           :via     => :sendmail
