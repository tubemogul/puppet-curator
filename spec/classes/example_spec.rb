require 'spec_helper'

describe 'curator' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "curator class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('curator::params') }
        it { should contain_class('curator::install') }

        it { should contain_package('elasticsearch-curator').with_ensure('latest') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'curator class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('curator') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
