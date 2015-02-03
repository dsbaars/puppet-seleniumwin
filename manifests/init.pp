# == Class: seleniumwin
#
# Configures Selenium on Windows
# Downloads IEDriver + Standalone server
# and creates batch-file to register to hub
#
# === Parameters
##
# [*version*]
#   Driver version, used to determine download URLs (default: 2.44)
#
# [*filename*]
#   Filename of Selenium IE Driver (default: IEDriverServer_Win32_2.44.0.zip)
#
# [*filenameServer*]
#   Filename of Selenium Grid Server (default: selenium-server-standalone-2.44.0.jar)
#
# [*hubUrl*]
#   URL of selenium grid hub (default: http://192.168.1.101:4444)
#
# === Examples
#
#  class { 'seleniumwin':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Djuri Baars <dsbaars@gmail.com>
#
# === Copyright
#
# Copyright 2015 Djuri Baars
#
class seleniumwin (
    $version = '2.44'
    $filename = 'IEDriverServer_Win32_2.44.0.zip',
    $filenameServer = 'selenium-server-standalone-2.44.0.jar',
    $hubUrl = 'http://192.168.1.101:4444'
    )
    {
    file { 'C:\\Selenium':
        ensure => 'directory',
    }

    $downloadTarget = "C:\\Selenium\\${filename}"
    $downloadUrl = "http://selenium-release.storage.googleapis.com/${version}/${filename}"

    $downloadTargetServer = "C:\\Selenium\\${filenameServer}"
    $downloadUrlServer = "http://selenium-release.storage.googleapis.com/${version}/${filenameServer}"

    exec { 'download-selenium-server':
        command  => "\$wc = New-Object Net.WebClient; \$wc.DownloadFile(\"${downloadUrlServer}\", \"${downloadTargetServer}\")",
        creates  => $downloadTargetServer,
        provider => 'powershell',
        require  => File['C:\\Selenium'],
    }


    exec { 'download-selenium-java':
        command  => "\$wc = New-Object Net.WebClient; \$wc.DownloadFile(\"${downloadUrl}\", \"C:\\Selenium\\${filename}\")",
        creates  => $downloadTarget,
        provider => 'powershell',
        require  => File['C:\\Selenium'],
    }
    ~>
    exec { 'unpack-selenium-java':
        command  => "\$shell = new-object -com shell.application;
        \$zip = \$shell.NameSpace(\"${downloadTarget}\");
        foreach (\$item in \$zip.items())
        {
            \$shell.NameSpace(\"C:\\Selenium\").copyhere(\$item)
        }
        ",
        creates  => 'C:\\Selenium\\IeDriverServer.exe',
        provider => 'powershell',
    }

    windows::path { 'C:\\Selenium': }

    file { 'C:\\Selenium\\ie11.bat':
        content => "echo WIN8.1 Machine - IE11\r\n
set HUBURL=\"${hubUrl}/grid/register\"\r\n
set BROWSERCAPS=\"maxInstances=1,browserName=internet explorer,version=11\"\r\n
java -jar ${filenameServer} -role node -hub %HUBURL% -port 4411 -maxSession 1 -browser %BROWSERCAPS%\r\n
@pause"
    }
}
