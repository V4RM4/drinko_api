module Api::V1
    class DrinkController < ApplicationController

        def create
            @drink = Drink.new
            @drink.name = params[:name]
            @drink.category = params[:category]
            @drink.quantity = params[:quantity]
            @drink.price = params[:price]
            if @drink.save!
                render plain: "Drink successfully added to the database!"
            else
                render json: { errors: @drink.errors.full_messages }
            end
        end

        def search_by_brand
            @drink = Drink.where("name like ?","%#{params[:name].upcase}%")
            count = 0
            result = {}
            @drink.each do |drink|
                count += 1
                result[count] = {:id => drink["id"], :name => drink["name"], :category => drink["category"], :quantity => drink["quantity"], :price => drink["price"]}
            end
            if count>0
                render json: {"#{count} results found": result}
            else
                render plain: "No results found!"
            end
        end

        def search_by_category
            @drink = Drink.where category: params[:category].upcase
            count = 0
            result = {}
            @drink.each do |drink|
                count += 1
                result[count] = {:name => drink["name"], :category => drink["category"], :quantity => drink["quantity"], :price => drink["price"]}
            end
            if count>0
                render json: {"#{count} results found": result}
            else
                render plain: "No results found!"
            end
        end

        def search_by_category_price_sorted_asc
            @drink = Drink.where category: params[:category].upcase
            count = 0
            result = {}
            @drink.each do |drink|
                if drink["price"] <= params[:price].to_i
                    count += 1
                    result[count] = {:name => drink["name"], :category => drink["category"], :quantity => drink["quantity"], :price => drink["price"]}
                end
            end
            if count>0
                render json: {"#{count} results found": result}
            else
                render plain: "No results found!"
            end
        end

        def update
            @drink = Drink.where id: params[:id]
            if @drink.update(price: params[:price])
                render plain: "Item updated successfully!"
            else
                render json: { errors: @drink.errors.full_messages }, status: :unprocessable_entity
            end
        end

        
        # TO BE WORKED ON!!!!

        # def destroy
        # @drink = Drink.where id: params[:id].to_i
        #     if @drink.destroy_all
        #         render plain: "Item deleted successfully - #{@drink["id"]} - #{@drink["name"]}"
        #     end
        # end

    end
end
