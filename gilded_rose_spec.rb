require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'rspec'

describe GildedRose do

  let(:initial_sell_in) { 5 }
  let(:initial_quality) { 10 }

  let(:item) { Item.new(name, initial_sell_in, initial_quality) }

  context 'with a single' do

    before(:each) do
      GildedRose.new([item]).update_quality
    end

    context 'normal items' do
      let(:name) { 'normal item' }


      context 'before sell date' do
        it 'its quality should decrease by one' do
          expect(item.quality).to be(9)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(4)
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }

        it 'its quality should decrease by two' do
          expect(item.quality).to be(8)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(-1)
        end

      end

      context 'after sell date' do
        let(:initial_sell_in) { -5 }

        it 'its quality should decrease by two' do
          expect(item.quality).to be(8)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(-6)
        end
      end

      context 'of nul quality' do
        let(:initial_quality) { 0 }

        it 'its quality should stay nul' do
          expect(item.quality).to be(0)
        end
      end

    end

    context 'Aged Brie' do
      let(:name) { 'Aged Brie' }
      
      context 'before sell date' do
        it 'its quality should increase by one' do
          expect(item.quality).to be(11)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(4)
        end
      end

      context 'max quality ' do
        let(:initial_quality) { 50 }

        it 'its quality should stay equal to 50' do
          expect(item.quality).to be(50)
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }

        it 'its quality should increase by two' do
          expect(item.quality).to be(12)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(-1)
        end

        context 'max quality ' do
          let(:initial_quality) { 50 }

          it 'its quality should stay equal to 50' do
            expect(item.quality).to be(50)
          end
        end

        context 'near max quality ' do
          let(:initial_quality) { 49 }

          it 'its quality should be 50' do
            expect(item.quality).to be(50)
          end
        end
      end

    end

    context 'Sulfuras' do
      let(:name) { 'Sulfuras, Hand of Ragnaros' }

      context 'before sell date' do
        it 'its quality should not change' do
          expect(item.quality).to be(10)
        end

        it 'its sell_in should not change' do
          expect(item.sell_in).to be(5)
        end
      end

      context 'of 50 of quality ' do
        let(:initial_quality) { 50 }

        it 'its quality should stay equal to 50' do
          expect(item.quality).to be(50)
        end
      end

    end

    context 'Backstage passes' do
      # "Backstage passes", comme le "Aged Brie", augmente sa qualité (`quality`) plus le temps passe (`sellIn`) ;
      # La qualité augmente de 2 quand il reste 10 jours ou moins et de 3 quand il reste 5 jours ou moins, mais la qualité tombe à 0 après le concert.

      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      context 'long before sell date' do
        let(:initial_sell_in) { 15 }

        it 'its quality should increase by one' do
          expect(item.quality).to be(11)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(14)
        end
      end

      context 'medium close to sell date (upper bound)' do
        let(:initial_sell_in) { 10 }

        it 'its quality should increase by two' do
          expect(item.quality).to be(12)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(9)
        end
      end

      context 'medium close to sell date (lower bound)' do
        let(:initial_sell_in) { 5 }

        it 'its quality should increase by three' do
          expect(item.quality).to be(13)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(4)
        end
      end

      context 'very close to sell date (upper bound)' do
        let(:initial_sell_in) { 5 }

        it 'its quality should increase by three' do
          expect(item.quality).to be(13)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(4)
        end
      end

      context 'very close to sell date (lower bound)' do
        let(:initial_sell_in) { 1 }

        it 'its quality should increase by three' do
          expect(item.quality).to be(13)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(0)
        end
      end

      context 'on sell date' do
        let(:initial_sell_in) { 0 }

        it 'its quality should be nul' do
          expect(item.quality).to be(0)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(-1)
        end
      end

      context 'after sell date' do
        let(:initial_sell_in) { -5 }

        it 'its quality should be nul' do
          expect(item.quality).to be(0)
        end

        it 'its sell_in should decrease by one' do
          expect(item.sell_in).to be(-6)
        end
      end

    end

  end

  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq 'foo'
    end
  end

end