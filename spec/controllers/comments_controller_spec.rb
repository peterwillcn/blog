require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let(:post_id) { create(:post, :published).id }

  describe '#index' do
    before { create_list(:comment, 10) }
    it 'responds 200' do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template('comments/index')
    end
  end

  context 'without identity' do
    describe '#create' do
      it 'responds 401' do
        post :create, post_id: post_id
        expect(response.status).to eq(401)
      end
    end
  end
end
