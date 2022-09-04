require 'rails_helper'

RSpec.describe 'Projects show page' do
  describe 'As a visitor, When I visit a projects show page ("/projects/:id"),' do
    before :each do
      @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
      @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
      @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
      @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
      @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
      ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
      ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
      ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
      ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
    end

    it 'I see that projects name and material as well as the theme of the challenge' do
      visit "/projects/#{@news_chic.id}"

      expect(current_path).to eq("/projects/#{@news_chic.id}")
      expect(page).to have_content("News Chic")
      expect(page).to have_content("Material: #{@news_chic.material}")
      expect(page).to have_content("Challenge Theme: Recycled Material")
      expect(page).to_not have_content("Boardfit")
    end

    it 'will show a count of the total contestants on each project' do
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("Number of Contestants: #{@news_chic.contestants.count}")
      expect(page).to_not have_content("Number of Contestants: #{@lit_fit.contestants.count}")
    end

    it 'will show the average years of experience of the contestants in each project' do
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("Average Contestant Experience: 12.5")

      visit "/projects/#{@boardfit.id}"
      expect(page).to have_content("Average Contestant Experience: 11.5")
    end

    it 'has a form to add a contestant to the project' do
      visit "/projects/#{@upholstery_tux.id}"

      expect(page).to have_field("Add a Contestant to #{@upholstery_tux.name}")
    end

    it 'when hit add contestant to project, will take you back ot the show page' do
      visit "/projects/#{@upholstery_tux.id}"
      fill_in "Add a Contestant to Upholstery Tuxedo", with: "#{@jay.id}"

      expect(current_path).to eq("/projects/#{@upholstery_tux.id}")
      expect(page).to have_content("Number of Contestants: 3")
    end

    xit 'will show the number increased for number of contestants and average experience will change' do

    end

  end
end

