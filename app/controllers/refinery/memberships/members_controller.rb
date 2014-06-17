module Refinery
  module Memberships
    class MembersController < ::ApplicationController

      # Protect these actions behind member login - do we need to check out not signing up when signed in?
      before_filter :redirect?, :except => [:new, :create, :login, :index, :welcome, :activate]

      before_filter :find_page, :except => [:activate, :login]

      # GET /member/:id
      def profile
        @member = current_refinery_user
      end

      def new
        @member = Member.new(suscribed: true)
      end

      # GET /members/:id/edit
      def edit
        @member = current_refinery_user
      end

      # PUT /members/:id
      def update
        @member = current_refinery_user

        if params[:member][:password].blank? and params[:member][:password_confirmation].blank?
          params[:member].delete(:password)
          params[:member].delete(:password_confirmation)
        end

        if @member.update_attributes(params[:member])
          flash[:notice] = t('successful', :scope => 'members.update', :email => @member.email)
          redirect_to profile_members_path
        else
          render :action => 'edit'
        end
      end

      def resend_confirmation
        @member = current_refinery_user

        if @member.resend_confirmation_token
          redirect_to root_path, :notice => "Se ha enviado el email de confirmacion."
        else
          redirect_to root_path, :notice => "Ha ocurrido un error al enviar el email de confirmacion."
        end
      end

      def create
        @member = Member.new(params[:member])

        if @member.save
          redirect_to root_path, :notice => "Se ha registrado exitosamente en el sitio. Por favor, revise su bandeja de entrada para confirmar su cuenta."
        else
          render :action => :new
        end
      end

      def searching?
        params[:search].present?
      end

      def login
        if params[:member_login].present? && params[:redirect].present?
          redirect_to root_url, :notice => "Por favor, confirme su cuenta para continuar. <a href=\"/resend_confirmation\">Enviar email de confirmacion.</a>"
          return
        end
        redirect_to(cas_login_url)
      end

      def welcome
        find_page('/')
      end

      def activate
        resource = Member.confirm_by_token(params[:confirmation_token])
        notice = resource.errors.present? ? "Ocurrio un error al activar su cuenta. Por favor contacte al administrador." : "Ha confirmado su cuenta, puede continuar en el sitio."
        redirect_to root_url, :notice => notice
      end

      def cas_login_url
        ::Devise.cas_client.add_service_to_login_url(::Devise.cas_service_url(request.url, devise_mapping))
      end
      helper_method :cas_login_url

      def devise_mapping
        Devise.mappings[:refinery_user]
      end
      helper_method :devise_mapping

      private

    protected

      def redirect?
        if current_refinery_user.nil?
          redirect_to '/refinery/users/login'
        end
      end

      def find_page(uri = nil)
        uri = uri ? uri : request.fullpath
        uri.gsub!(/\?.*/, '')
        @page = Page.find_by_link_url(uri, :include => [:parts])
      end
    end
  end
end
