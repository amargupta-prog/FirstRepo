module CompetitorProductsHelper
    def asin_input_field(form, competitor)
        form.text_field :asin, size: 14, placeholder: 'B0BYZZQSLZ'
    end
end