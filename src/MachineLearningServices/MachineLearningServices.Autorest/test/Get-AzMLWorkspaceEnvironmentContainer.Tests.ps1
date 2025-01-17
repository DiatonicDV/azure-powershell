if(($null -eq $TestName) -or ($TestName -contains 'Get-AzMLWorkspaceEnvironmentContainer'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Get-AzMLWorkspaceEnvironmentContainer.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Get-AzMLWorkspaceEnvironmentContainer' {
    It 'List' {
        { Get-AzMLWorkspaceEnvironmentContainer  -ResourceGroupName $env.DataGroupName -WorkspaceName $env.computeWorkspace } | Should -Not -Throw
    }

    It 'Get' {
        { Get-AzMLWorkspaceEnvironmentContainer  -ResourceGroupName $env.DataGroupName -WorkspaceName $env.computeWorkspace -Name batchenv1 } | Should -Not -Throw
    }
}
