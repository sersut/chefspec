require 'chefspec'

describe 'deploy::deploy' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'deploys a deploy with an explicit action' do
    expect(chef_run).to deploy_deploy('/tmp/explicit_action')
    expect(chef_run).to_not deploy_deploy('/tmp/not_explicit_action')
  end

  it 'deploys a deploy with attributes' do
    expect(chef_run).to deploy_deploy('/tmp/with_attributes').with(repo: 'ssh://git.path', migrate: true)
    expect(chef_run).to_not deploy_deploy('/tmp/with_attributes').with(repo: 'ssh://git.other_path', migrate: false)
  end
end
