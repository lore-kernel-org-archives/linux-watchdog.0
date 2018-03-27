Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40049 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeC0KhH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Mar 2018 06:37:07 -0400
Received: by mail-pf0-f195.google.com with SMTP id v66so6216784pfv.7
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Mar 2018 03:37:07 -0700 (PDT)
Subject: Re: [PATCH] watchdog: core: add option to make timeouts read-only
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org
References: <20180327080941.29235-1-marcus.folkesson@gmail.com>
 <20180327080941.29235-2-marcus.folkesson@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2e013403-7922-3309-3d17-0a9b757faa9c@roeck-us.net>
Date: Tue, 27 Mar 2018 03:37:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180327080941.29235-2-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/27/2018 01:09 AM, Marcus Folkesson wrote:
> Some systems may not allow applications to configure the watchdog
> timer at all. This restriction is not limited to stop the watchdog,
> but also change timeouts as well.
> 
> This adds a kernel parameter to disable the ability to change the
> watchdog timouts from userspace.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

I don't believe that this would be a watchdog-only problem. Those users probably
want lots of other things read-only. If they don't, and if this is really a watchdog
specific request, I don't think they know what they are talking about. Besides,
one can bypass it by unloading/reloading the drivers, so I don't really get the
point.

Are the requesters of this feature aware that, with the permissions necessary
to change a watchdog timeout, it is possible to do lots of things, such as,
say, reboot the system ? Or cause a crash ? Is that less critical ?

I would _really_ want to see a more detailed case made than "some users want it"
before agreeing to a change like this.

Guenter

> ---
>   drivers/watchdog/Kconfig        |  9 +++++++++
>   drivers/watchdog/watchdog_dev.c | 12 ++++++++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index aff773bcebdb..bcba48b5c88b 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -46,6 +46,15 @@ config WATCHDOG_NOWAYOUT
>   	  get killed. If you say Y here, the watchdog cannot be stopped once
>   	  it has been started.
>   
> +config WATCHDOG_TIMEOUT_READONLY
> +	bool "Make timeouts read-only from userspace"
> +	help
> +	  Say Y here if you want the watchdog timeout/pretimeout to be read-only
> +	  from userspace. This requires that the timeout is configured before
> +	  userspace takes over.
> +
> +	  Say N if you are unsure.
> +
>   config WATCHDOG_HANDLE_BOOT_ENABLED
>   	bool "Update boot-enabled watchdog until userspace takes over"
>   	default y
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index ffbdc4642ea5..6064806a2a8d 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -87,6 +87,9 @@ static struct kthread_worker *watchdog_kworker;
>   static bool handle_boot_enabled =
>   	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
>   
> +static bool timeout_is_readonly =
> +	IS_ENABLED(CONFIG_WATCHDOG_TIMEOUT_READONLY);
> +
>   static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>   {
>   	/* All variables in milli-seconds */
> @@ -359,7 +362,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>   {
>   	int err = 0;
>   
> -	if (!(wdd->info->options & WDIOF_SETTIMEOUT))
> +	if (!(wdd->info->options & WDIOF_SETTIMEOUT) || timeout_is_readonly)
>   		return -EOPNOTSUPP;
>   
>   	if (watchdog_timeout_invalid(wdd, timeout))
> @@ -390,7 +393,7 @@ static int watchdog_set_pretimeout(struct watchdog_device *wdd,
>   {
>   	int err = 0;
>   
> -	if (!(wdd->info->options & WDIOF_PRETIMEOUT))
> +	if (!(wdd->info->options & WDIOF_PRETIMEOUT) || timeout_is_readonly)
>   		return -EOPNOTSUPP;
>   
>   	if (watchdog_pretimeout_invalid(wdd, timeout))
> @@ -1181,3 +1184,8 @@ module_param(handle_boot_enabled, bool, 0444);
>   MODULE_PARM_DESC(handle_boot_enabled,
>   	"Watchdog core auto-updates boot enabled watchdogs before userspace takes over (default="
>   	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
> +
> +module_param(timeout_is_readonly, bool, 0444);
> +MODULE_PARM_DESC(timeout_is_readonly,
> +	"Watchdog timeouts is readonly from userspace (default="
> +	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_TIMEOUT_READONLY)) ")");
> 

