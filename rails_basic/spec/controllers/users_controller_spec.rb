require 'rails_helper'

describe UsersController do

  before(:context) do
    I18n.default_locale = 'en'
  end

  describe 'GET index' do
    it 'assigns @users' do
      user = User.create(name: 'Jose', email: 'jose@test.com',
                         password: '123456', password_confirmation: '123456')

      get :index

      expect(assigns(:users)).to eq([user])
    end
  end

  describe 'POST login' do
    it 'login user' do
      user = User.create(name: 'Jose', email: 'jose@test.com',
                         password: '123456', password_confirmation: '123456')
      params = {user: {email: 'jose@test.com', password: '123456'}}

      process :login, params: params, method: :post

      json_response = JSON.parse(response.body)
      expected = user.as_json(only: [:id, :name, :email, :auth_token])

      expect(expected).to eq(json_response)
    end

    it 'error not registered' do
      params = {user: {email: 'jose@test.com', password: '123456'}}

      process :login, params: params, method: :post

      expected = {'email' => ['not registered']}
      json_response = JSON.parse(response.body)

      expect(expected).to eq(json_response)
    end

    it 'error wrong password' do
      user = User.create(name: 'Jose', email: 'jose@test.com',
                         password: '123456', password_confirmation: '123456')
      params = {user: {email: 'jose@test.com', password: '1234567'}}

      process :login, params: params, method: :post

      expected = {'password' => ["it's wrong"]}
      json_response = JSON.parse(response.body)

      expect(expected).to eq(json_response)
    end
  end

  describe 'POST edit' do
    it 'edit user' do
      user = User.create(name: 'Jose', email: 'jose@test.com',
                         password: '123456', password_confirmation: '123456')

      request.headers["HTTP_AUTHORIZATION"] = "Token token=#{user.auth_token}"
      params = {user: {email: 'jose@outro.com', current_password: '123456'}}

      process :edit, params: params, method: :post

      json_response = JSON.parse(response.body)

      user.email = 'jose@outro.com'
      expected = user.as_json(only: [:id, :name, :email, :auth_token])

      expect(expected).to eq(json_response)
    end

    it 'error without authorization token' do
      user = User.create(name: 'Jose', email: 'jose@test.com',
                         password: '123456', password_confirmation: '123456')

      params = {user: {email: 'jose@outro.com', current_password: '123456'}}

      process :edit, params: params, method: :post

      expect{JSON.parse(response.body)}.to raise_error(JSON::ParserError)
    end

    it 'error wrong password' do
      user = User.create(name: 'Jose', email: 'jose@test.com',
                         password: '123456', password_confirmation: '123456')

      request.headers["HTTP_AUTHORIZATION"] = "Token token=#{user.auth_token}"
      params = {user: {email: 'jose@outro.com', current_password: '1234567'}}

      process :edit, params: params, method: :post

      expected = {'current_password' => ["it's wrong"]}
      json_response = JSON.parse(response.body)

      expect(expected).to eq(json_response)
    end
  end

  describe 'POST get_user' do
    it 'get current user' do
      user = User.create(name: 'Jose', email: 'jose@test.com',
                         password: '123456', password_confirmation: '123456')

      request.headers["HTTP_AUTHORIZATION"] = "Token token=#{user.auth_token}"

      process :get_user, method: :post

      json_response = JSON.parse(response.body)

      expected = user.as_json(only: [:id, :name, :email, :auth_token])

      expect(expected).to eq(json_response)
    end

    it 'error without authorization token' do
      user = User.create(name: 'Jose', email: 'jose@test.com',
                         password: '123456', password_confirmation: '123456')

      process :get_user, method: :post

      expect{JSON.parse(response.body)}.to raise_error(JSON::ParserError)
    end
  end
end
