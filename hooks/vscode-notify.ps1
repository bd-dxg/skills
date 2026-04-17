param()

$logPath = "$Home\.claude\hooks\hook-log.txt"

function Write-HookLog {
  param(
    [string]$HookEventName,
    [string]$EventName,
    [string]$Message
  )

  $hookName = if ([string]::IsNullOrWhiteSpace($HookEventName)) { '-' } else { $HookEventName }
  $event = if ([string]::IsNullOrWhiteSpace($EventName)) { '-' } else { $EventName }

  Add-Content -Path $logPath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $hookName - $event - $Message"
}

function Get-NotificationMessage {
  param([string]$EventName)

  $messages = @{
    permission_prompt = '请确认权限请求'
    idle_prompt = 'Claude 正在等待你的输入'
    elicitation_dialog = '有交互需要你确认'
    ask_user_question = '需要你回答一个问题'
    user_prompt_submit = '需要你回答问题'
    ask_user_question_complete = '问题已回答'
    permission_request = '需要你确认权限请求'
    stop = 'Claude 已回答完毕,请指示!'
  }

  $message = $messages[$EventName]
  if ([string]::IsNullOrWhiteSpace($message)) {
    return "有新的 Claude Code 通知 ($EventName)"
  }

  return $message
}

function Show-ToastNotification {
  param(
    [string]$HookEventName,
    [string]$EventName,
    [string]$Message
  )

  try {
    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

    $appId = 'Microsoft.VisualStudioCode'
    $template = [Windows.UI.Notifications.ToastTemplateType]::ToastText02
    $xml = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent($template)
    $textNodes = $xml.GetElementsByTagName('text')
    $textNodes.Item(0).AppendChild($xml.CreateTextNode('Claude Code')) | Out-Null
    $textNodes.Item(1).AppendChild($xml.CreateTextNode($Message)) | Out-Null

    $toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($appId).Show($toast)

    Write-HookLog -HookEventName $HookEventName -EventName $EventName -Message '通知发送成功'
  } catch {
    Write-HookLog -HookEventName $HookEventName -EventName $EventName -Message "通知发送失败: $($_.Exception.Message)"
  }
}

try {
  $stdinReader = [System.IO.StreamReader]::new(
    [Console]::OpenStandardInput(),
    [System.Text.UTF8Encoding]::new($false),
    $true
  )
  $inputText = $stdinReader.ReadToEnd()
  $hookEventName = 'Unknown'
  $eventName = 'notification'

  if (-not [string]::IsNullOrWhiteSpace($inputText)) {
    $payload = $inputText | ConvertFrom-Json -ErrorAction Stop

    if ($payload.PSObject.Properties.Name -contains 'hook_event_name' -and -not [string]::IsNullOrWhiteSpace($payload.hook_event_name)) {
      $hookEventName = [string]$payload.hook_event_name
    }

    foreach ($propertyName in @('message', 'event_name', 'notification_type', 'type')) {
      if ($payload.PSObject.Properties.Name -contains $propertyName -and -not [string]::IsNullOrWhiteSpace($payload.$propertyName)) {
        $eventName = [string]$payload.$propertyName
        break
      }
    }

    if ([string]::IsNullOrWhiteSpace($eventName) -or $eventName -eq 'notification') {
      $eventName = $hookEventName
    }
  }

  $script:HookEventName = $hookEventName
  $script:EventName = $eventName

  Write-HookLog -HookEventName $hookEventName -EventName $eventName -Message '收到通知事件'
  $message = Get-NotificationMessage -EventName $eventName

  Show-ToastNotification -HookEventName $hookEventName -EventName $eventName -Message $message
} catch {
  Write-HookLog -HookEventName $script:HookEventName -EventName $script:EventName -Message "Hook 脚本执行失败: $($_.Exception.Message)"
}
