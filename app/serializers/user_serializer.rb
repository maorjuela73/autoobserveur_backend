class UserSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :first_name, :email, :birth_date
end
