#
# Copyright:: 2019, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe RuboCop::Cop::Chef::RespondToInMetadata, :config do
  subject(:cop) { described_class.new(config) }

  it "registers an offense when metadata includes the 'if respond_to?(:foo)' gate" do
    expect_violation(<<-RUBY)
      chef_version '> 13' if respond_to?(:chef_version)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ It is no longer necessary to use respond_to? in metadata.rb
    RUBY
  end

  it "doesn't register an offense when just calling the same method" do
    expect_no_violations(<<-RUBY)
      chef_version '> 13'
    RUBY
  end
end