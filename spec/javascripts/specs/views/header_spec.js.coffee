describe "BookmarkHeaderView", ->
  this.view = null
  this.collection = null

  beforeEach ->
    loadFixtures 'generic_view'

    this.collection = new Booksmartlet.Collections.BookmarksCollection()
    this.view = new Booksmartlet.Views.HeaderView
      collection: this.collection

    spyOn( this.collection, 'fetch')
    $('#content').html(this.view.render().el)

  it "renders the header view", ->
    expect($('#content')).toContain '#search-input'

  describe "searches on keyup", ->
    it "fetches the collection on keyup", ->
      this.view.$('#search-input').val('Fred').keyup()
      expect(this.collection.fetch).wasCalled()

    it "sets the search term to the input val on keyup", ->
      this.view.$('#search-input').val('Fred').keyup()
      expect(this.collection.search_term).toEqual('Fred')

    # it "only searches if term is longer than 3", ->
    #   this.view.$('#search-input').val('F').keyup().val('Fr').keyup().val('Fre').keyup()
    #   expect(this.collection.fetch.callCount).toEqual(1)


  describe "note/mark toggling", ->

    it "toggles active class on click of note or 'mark", ->
      this.view.$('#add-note').click()
      expect( this.view.$('#add-note').hasClass('active')).toEqual true

    it "changes the preview text in search based on context", ->
      this.view.$('#add-note').click()
      expect( this.view.$('#search-input').attr('placeholder')).toContain 'Notes'












