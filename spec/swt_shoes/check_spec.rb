require 'swt_shoes/spec_helper'

describe Shoes::Swt::Check do
  let(:text) { "TEXT" }
  let(:dsl) { double('dsl') }
  let(:parent) { double('parent') }
  let(:block) { double('block') }
  let(:real) { double('real').as_null_object }

  subject { Shoes::Swt::Check.new dsl, parent, block }

  before :each do
    parent.stub(:real)
    ::Swt::Widgets::Button.stub(:new) { real }
  end

  it_behaves_like "movable object with disposable real element"

  it "calls get_selection when checked? is called" do
    real.should_receive :get_selection
    subject.checked?
  end

  it "calls set_selection when checked= is called" do
    real.should_receive(:set_selection).with(true)
    subject.checked = true
  end

  it "calls set_focus when focus is called" do
    real.should_receive :set_focus
    subject.focus
  end
end
