Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sun, 17 Jul 2016 21:51:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: fu.wei@linaro.org
Cc: linux@roeck-us.net, panand@redhat.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	timur@codeaurora.org, dyoung@redhat.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, Suravee.Suthikulpanit@amd.com
Subject: Re: [PATCH 0/3] watchdog, sbsa_gwdt: Update SBSA watchdog with the new infrastructure of watchdog.
Message-ID: <20160717195139.GC32751@spo001.leaseweb.nl>
References: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Fu,

> From: Fu Wei <fu.wei@linaro.org>
> 
> This patchset:
>     (1)Try to fix an issue about min and max timeout validity check:
>     when max_hw_heartbeat_ms is defined, this check should be skipped.
> 
>     (2)Use max_hw_heartbeat_ms instead of max_timeout in SBSA watchdog.
> 
>     (3)Set WDOG_HW_RUNNING, when SBSA watchdog is already running before
>     it's initialized.
> 
> Changelog:
> v1: The first formal upstreaming version
> 
> RFC: https://lkml.org/lkml/2016/5/3/145
> 
> Pratyush Anand (3):
>   watchdog: skip min and max timeout validity check when
>     max_hw_heartbeat_ms is defined
>   sbsa_gwdt: Use max_hw_heartbeat_ms instead of max_timeout
>   sbsa_gwdt: Set WDOG_HW_RUNNING, when watchdog is already running.
> 
>  drivers/watchdog/sbsa_gwdt.c     | 6 ++++--
>  drivers/watchdog/watchdog_core.c | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> -- 
> 2.5.5
> 

These patches have been added to linux-watchdog-next.

Kind regards,
Wim.
