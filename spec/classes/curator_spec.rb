require 'spec_helper'

describe 'curator' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      let(:facts) do
        {
          osfamily: osfamily,
          lsbdistid: 'Ubuntu',
          lsbdistcodename: 'trusty',
          lsbdistrelease: '14.04',
          puppetversion: Puppet.version
        }
      end

      describe "curator class without any parameters on #{osfamily}" do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('curator') }
        it { is_expected.to contain_class('curator::params') }
        it { is_expected.to contain_class('curator::install') }

        it { is_expected.to contain_package('python-pip')\
          .with_ensure('present')\
          .that_comes_before('Package[elasticsearch-curator]')
        }
        it { is_expected.to contain_package('elasticsearch-curator').with_provider('pip') }
      end

      describe "curator with a delete indices cron on #{osfamily}" do
        let(:params) do
          {
            crons: {
              'puppet-report' => {
                'command'     => 'delete',
                'parameters'  => '--time-unit days --older-than 14 --timestring \\%Y.\\%m.\\%d --prefix puppet-report-'
              }
            }
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_curator__cron('puppet-report')\
          .with_command('delete')\
          .with_parameters('--time-unit days --older-than 14 --timestring \\%Y.\\%m.\\%d --prefix puppet-report-')
        }
        it { is_expected.to contain_cron('cron_curator_puppet-report') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'curator class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          osfamily: 'Solaris',
          operatingsystem: 'Nexenta'
        }
      end

      it { expect { is_expected.to contain_package('curator') }.to raise_error(Puppet::Error, %r{Nexenta not supported}) }
    end
  end
end
