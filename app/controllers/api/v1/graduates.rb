module API
  module V1
    class Graduates < Grape::API
      prefix 'api'
      include API::V1::Defaults

      resource :graduates do
        desc "Return all graduates"
        get "", root: :graduates do
          Graduate.all
        end

        desc "Return a graduate"
        params do
          requires :id, type: String, desc: "ID of the 
            graduate"
        end
        get ":id", root: "graduate" do
          Graduate.where(id: permitted_params[:id]).first!
        end

        desc 'Create a graduate'
        params do
          requires :first_name, type: String, desc: 'first name'
          requires :last_name, type: String, desc: 'last name'
        end
        post do
          Graduate.create!({
            last_name: params[:last_name],
            first_name: params[:first_name]
          })
        end

        desc 'Update a graduate'
        params do
          requires :id, type: String, desc: 'Status ID.'
          requires :first_name, type: String, desc: 'first name'
          requires :last_name, type: String, desc: 'last name'
        end
        put ':id' do
          Graduate.find(params[:id]).update({
            last_name: params[:last_name],
            first_name: params[:first_name]
          })
        end

        desc 'Delete a graduate'
        params do
          requires :id, type: String, desc: 'Status ID.'
        end
        delete ':id' do
          Graduate.find(params[:id]).destroy
        end
      end
    end
  end
end
