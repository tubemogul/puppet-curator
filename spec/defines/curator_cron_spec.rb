require 'spec_helper'

describe 'curator::cron', type: :define do
  let(:facts) do
    {
      osfamily: 'Debian',
      lsbdistid: 'Ubuntu',
      lsbdistcodename: 'trusty',
      lsbdistrelease: '14.04',
      puppetversion: Puppet.version
    }
  end

  let :pre_condition do
    'class { "curator": }'
  end
  let :title do
    'logstash'
  end

  describe 'deploy a Curator cron' do
    let :params do
      {
        command: 'delete',
        parameters: "--time-unit days --older-than 7 --timestring '\%Y.\%m.\%d' --prefix logstash-"
      }
    end

    it { is_expected.to contain_class('curator') }
    it { is_expected.to contain_curator__cron('logstash') }
    it { is_expected.to contain_cron('cron_curator_logstash') }
  end

  describe 'Curator cron without command' do
    let(:params) { {} }

    it { is_expected.to raise_error(Puppet::Error, %r{Curator command required to deploy a cronjob.}) }
  end

  describe 'Curator cron without parameters' do
    let :params do
      {
        command: 'delete'
      }
    end

    it { is_expected.to raise_error(Puppet::Error, %r{Curator parameters required to deploy a cronjob.}) }
  end
end
