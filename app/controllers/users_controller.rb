class UsersController < ApplicationController

  #
  # Novo usuário: NEW
  #
  def new
    # Verifica se não há um usuário logado ou se este é o Administrador
    if(!current_user || current_user.nome_completo == "Admin")
      # Novo usu'ario
      @user = User.new
      # Necessário deslogar
    else
      # Mensagem de erro
      flash[:error] = 'É necessário deslogar para criar um novo usuário.'
      # redireciona para a p'agina inicial
      redirect_to root_url
    end
  end

  #
  # Criação de usuário: CREATE
  #
  def create
    # Verifica se não há um usuário logado ou se este é o Administrador
    if(!current_user || current_user.nome_completo == "Admin")
      @user = User.new(params[:user])
      #utiliza email como login
      @user.username = @user.email
      if @user.save
        flash[:message] = 'Usuário criado com sucesso!'
        redirect_to new_subscription_url
      else
        flash[:error] = "Usuário não criado."
        render :new
      end
      # Necessário deslogar
    else
      flash[:error] = 'É necessário deslogar para criar um novo usuário.'
      redirect_to root_url
    end

  end

  #
  # Detalhes do usuário: SHOW
  #
  def show
    
    # Verifica se há um usuário logado
    if(!current_user)
      flash[:message] = 'É preciso logar como administrador para verificar dados de usuários.'
      redirect_to root_url
    else
      # Usuário logado
      @user = current_user

      # Dados a serem exibidos
      @user_to_show = User.find(params[:id])

      # O usuário requerente é o administrador ou o esmo usuário dos dados requisitados
      if(@user.nome_completo == "Admin" || @user.id == @user_to_show.id)
        respond_to do |format|
          format.html # show.html.erb
          format.xml  { render :xml => @user }
        end
        # Não exiba os dados
      else
        flash[:message] = 'Apenas o administrador pode verificar dados de outros usuários.'
        redirect_to(@user)
      end
    end
  end

  #
  # Listagem dos usuários: INDEX
  #
  def index
    
    if(!current_user)
      flash[:message] = 'É preciso logar como administrador para verificar a lista de usuários.'
      redirect_to root_url
    else
      @user = current_user
      if(@user.nome_completo == "Admin")
        @users = User.find(:all)
      else
        flash[:message] = 'Apenas os administradores podem verificar a lista de usuários.'
        redirect_to (@user)
      end
    end
  end

  #
  # Edição de usuário: EDIT
  #
  def edit

    # Verifica se há um usuário logado
    if(!current_user)
      flash[:message] = 'É preciso logar como administrador para editar dados de outros usuários.'
      redirect_to root_url
    else
      # Usuário logado
      @user = current_user
    end
  end

  #
  # Atualização de dados: UPDATE
  #
  def update

    if(!current_user)
      flash[:message] = 'É preciso logar como administrador para editar dados de outros usuários.'
      redirect_to root_url
    else
      @user = current_user
      #@user = @user.update_attibutes(params[:user])
      #utiliza email como login
      #@user.username = @user.email
      if @user.update_attributes(params[:user])
        flash[:message] = 'Usuário alterado com sucesso!'
        redirect_to(user_subscriptions_url(@user))
      else
        render :action => "edit"
      end
    end
  end

  #
  # Remoção: DESTROY
  #
  def destroy
    # Verifica se o usuario logado é o Administrador
    if(current_user && current_user.nome_completo == "Admin")
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    else
      flash[:message] = 'É preciso logar como administrador para remover um usario.'
      redirect_to root_url
    end
  end
end
