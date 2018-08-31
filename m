Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34009 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeHaRXE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Aug 2018 13:23:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so5453501pgv.1
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Aug 2018 06:15:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] watchdog: iTCO_wdt: Remove unused hooks
To: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org
Cc: Martin Wilck <mwilck@suse.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20180831150610.0d3c5d9c@endymion>
 <20180831150734.2bc2fc02@endymion>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <12e5c67e-fff7-9456-5028-9e20925b8a3a@roeck-us.net>
Date: Fri, 31 Aug 2018 06:15:37 -0700
MIME-Version: 1.0
In-Reply-To: <20180831150734.2bc2fc02@endymion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/31/2018 06:07 AM, Jean Delvare wrote:
> As the only user of iTCO_vendor_pre_keepalive and
> iTCO_vendor_pre_set_heartbeat has just been removed, we can delete
> these 2 hooks.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/iTCO_vendor.h         |    4 ----
>   drivers/watchdog/iTCO_vendor_support.c |   10 ----------
>   drivers/watchdog/iTCO_wdt.c            |    4 ----
>   3 files changed, 18 deletions(-)
> 
> --- linux-4.18.orig/drivers/watchdog/iTCO_vendor.h	2018-08-31 13:36:44.969460371 +0200
> +++ linux-4.18/drivers/watchdog/iTCO_vendor.h	2018-08-31 14:37:19.197296115 +0200
> @@ -3,14 +3,10 @@
>   #ifdef CONFIG_ITCO_VENDOR_SUPPORT
>   extern void iTCO_vendor_pre_start(struct resource *, unsigned int);
>   extern void iTCO_vendor_pre_stop(struct resource *);
> -extern void iTCO_vendor_pre_keepalive(struct resource *, unsigned int);
> -extern void iTCO_vendor_pre_set_heartbeat(unsigned int);
>   extern int iTCO_vendor_check_noreboot_on(void);
>   #else
>   #define iTCO_vendor_pre_start(acpibase, heartbeat)	{}
>   #define iTCO_vendor_pre_stop(acpibase)			{}
> -#define iTCO_vendor_pre_keepalive(acpibase, heartbeat)	{}
> -#define iTCO_vendor_pre_set_heartbeat(heartbeat)	{}
>   #define iTCO_vendor_check_noreboot_on()			1
>   				/* 1=check noreboot; 0=don't check */
>   #endif
> --- linux-4.18.orig/drivers/watchdog/iTCO_vendor_support.c	2018-08-31 14:27:06.438895718 +0200
> +++ linux-4.18/drivers/watchdog/iTCO_vendor_support.c	2018-08-31 14:37:10.693180108 +0200
> @@ -180,16 +180,6 @@ void iTCO_vendor_pre_stop(struct resourc
>   }
>   EXPORT_SYMBOL(iTCO_vendor_pre_stop);
>   
> -void iTCO_vendor_pre_keepalive(struct resource *smires, unsigned int heartbeat)
> -{
> -}
> -EXPORT_SYMBOL(iTCO_vendor_pre_keepalive);
> -
> -void iTCO_vendor_pre_set_heartbeat(unsigned int heartbeat)
> -{
> -}
> -EXPORT_SYMBOL(iTCO_vendor_pre_set_heartbeat);
> -
>   int iTCO_vendor_check_noreboot_on(void)
>   {
>   	switch (vendorsupport) {
> --- linux-4.18.orig/drivers/watchdog/iTCO_wdt.c	2018-08-12 22:41:04.000000000 +0200
> +++ linux-4.18/drivers/watchdog/iTCO_wdt.c	2018-08-31 14:38:19.295115483 +0200
> @@ -304,8 +304,6 @@ static int iTCO_wdt_ping(struct watchdog
>   
>   	spin_lock(&p->io_lock);
>   
> -	iTCO_vendor_pre_keepalive(p->smi_res, wd_dev->timeout);
> -
>   	/* Reload the timer by writing to the TCO Timer Counter register */
>   	if (p->iTCO_version >= 2) {
>   		outw(0x01, TCO_RLD(p));
> @@ -342,8 +340,6 @@ static int iTCO_wdt_set_timeout(struct w
>   	    (p->iTCO_version == 1 && tmrval > 0x03f))
>   		return -EINVAL;
>   
> -	iTCO_vendor_pre_set_heartbeat(tmrval);
> -
>   	/* Write new heartbeat to watchdog */
>   	if (p->iTCO_version >= 2) {
>   		spin_lock(&p->io_lock);
> 
> 
