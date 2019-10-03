class UserSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :first_name, :email, :gender, :birth_date
end
