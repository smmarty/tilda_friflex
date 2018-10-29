describe Tilda::Client do
  let(:public_key){ENV.fetch("TILDA_PUBLIC_KEY")}
  let(:secret_key){ENV.fetch("TILDA_SECRET_KEY")}
  let(:project_id){ENV.fetch("TILDA_PROJECT_ID")}
  let(:page_id){ENV.fetch("TILDA_PAGE_ID")}

  before do
    Tilda::Config.configure do |c|
      c.public_key=public_key
      c.private_key = secret_key
    end
  end

  subject{ described_class.new }

  describe "#get_projects_list" do
    it "return list of projects" do
      VCR.use_cassette("succsesful_projects_list", record: :once) do
        response = subject.get_projects_list
        expect(response["status"]).to eq("FOUND")
      end
    end
  end

  describe "#get_project" do
    it "return project" do
      VCR.use_cassette("succsesful_get_project", record: :once) do
        response = subject.get_project(project_id)
        expect(response["status"]).to eq("FOUND")
      end
    end

    it "not found project" do
      VCR.use_cassette("notfound_get_project", record: :once) do
        response = subject.get_project(-1)
        expect(response["status"]).to eq("ERROR")
      end
    end
  end

  describe "#get_project_export" do
    it "successful request" do
      VCR.use_cassette("successfull_get_project_export", record: :once) do
        response = subject.get_project_export(project_id)
        expect(response["status"]).to eq("FOUND")
      end
    end

    it "not found project for export" do
      VCR.use_cassette("notfound_get_project_export", record: :once) do
        response = subject.get_project_export(-1)
        expect(response["status"]).to eq("ERROR")
      end
    end
  end

  describe "#get_pages_list" do
    it "successfull request" do
      VCR.use_cassette("successfull_get_pages_list", record: :once) do
        response = subject.get_pages_list(project_id)
        expect(response["status"]).to eq("FOUND")
      end
    end

    it "invalid response" do
      VCR.use_cassette("notfound_get_pages_list", record: :once) do
        response = subject.get_pages_list(-1)
        expect(response["status"]).to eq("ERROR")
      end
    end
  end

  describe "#get_page" do
    it "successfull request" do
      VCR.use_cassette("successfull_get_page", record: :once) do
        response = subject.get_page(page_id)
        expect(response["status"]).to eq("FOUND")
      end
    end

    it "invalid response" do
      VCR.use_cassette("invalid_get_page", record: :once) do
        response = subject.get_page(1)
        expect(response["status"]).to eq("ERROR")
      end
    end
  end

  describe "#get_page_full" do
    it "successfull request" do
      VCR.use_cassette("successfull_get_page_full", record: :once) do
        response = subject.get_page_full(page_id)
        expect(response["status"]).to eq("FOUND")
      end
    end

    it "invalid response" do
      VCR.use_cassette("invalid_get_page_full", record: :once) do
        response = subject.get_page_full(-1)
        expect(response["status"]).to eq("ERROR")
      end
    end
  end

  describe "#get_page_export" do
    it "successfull response" do
      VCR.use_cassette("successfull_get_page_export", record: :once) do
        response = subject.get_page_export(page_id)
        expect(response["status"]).to eq("FOUND")
      end
    end

    it "invalid response" do
      VCR.use_cassette("invalid_get_page_export", record: :once) do
        response = subject.get_page_export(-1)
        expect(response["status"]).to eq("ERROR")
      end
    end
  end

  describe "#get_page_full_export" do
    it "successfull response" do
      VCR.use_cassette("successfull_get_page_full_export", record: :once) do
        response = subject.get_page_full_export(page_id)
        expect(response["status"]).to eq("FOUND")
      end
    end

    it "invalid response" do
      VCR.use_cassette("invalid_get_page_full_export", record: :once) do
        response = subject.get_page_full_export(-1)
        expect(response["status"]).to eq("ERROR")
      end
    end
  end

end
