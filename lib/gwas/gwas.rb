module GWAS

  class Error < StandardError
  end

  class BadRequestError < GWAS::Error
  end

  class NotFoundError < GWAS::BadRequestError
  end

  class Client

    BASE_URL = 'https://www.ebi.ac.uk/gwas/beta/rest/api'

    def find_snp(rs_id)
      make_request "singleNucleotidePolymorphisms/#{rs_id}"
    end

    def list_efo_traits(size: 250, page: 0)
      make_request 'efoTraits', params: {page: page, size: size}
    end

    def snps_with_efo_trait(efo_trait)
      make_request 'singleNucleotidePolymorphisms/search/findByEfoTrait', params: {efoTrait: efo_trait}
    end

    def make_request(path, params: {})
      url = BASE_URL + '/' + path
      response = HTTP.get url, params: params

      if response.code.to_i == 404
        return nil
      end

      unless response.code.to_i == 200
        raise BadRequestError.new(url)
      end

      JSON(response.body.to_s)
    end

  end

end