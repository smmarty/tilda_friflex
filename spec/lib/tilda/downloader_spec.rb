describe Tilda::Downloader do
  let(:public_key){ENV.fetch("TILDA_PUBLIC_KEY")}
  let(:secret_key){ENV.fetch("TILDA_SECRET_KEY")}
  let(:project_id){ENV.fetch("TILDA_PROJECT_ID")}
  let(:page_id){ENV.fetch("TILDA_PAGE_ID")}

  before do
    Tilda::Config.configure do |c|
      c.public_key = public_key
      c.private_key = secret_key
    end
  end

  let(:tilda_client) { Tilda::Client.new }

  subject{ described_class.new(tilda_client) }

  describe '#download_page' do
    it 'saves page' do
    end
  end

end