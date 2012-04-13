Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932424Ab2DMI4J (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Apr 2012 04:56:09 -0400
Message-ID: <4F87EAA4.3090900@redhat.com>
Date: Fri, 13 Apr 2012 10:58:12 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 2/4] watchdog: Add a flag to indicate the watchdog doesn't
 reboot things
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk> <20120321152503.20045.41514.stgit@bob.linux.org.uk>
In-Reply-To: <20120321152503.20045.41514.stgit@bob.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Looks good, ack.

Acked-by: Hans de Goede <hdegoede@redhat.com>

On 03/21/2012 04:25 PM, Alan Cox wrote:
> From: Alan Cox<alan@linux.intel.com>
>
> Some watchdogs merely trigger external alarms and controls. In a managed
> environment this is very useful but we want drivers to be able to figure
> out which is which now multiple dogs can be loaded. Thus add an ALARMONLY
> feature flag.
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   include/linux/watchdog.h |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
>
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 0d5c3af..fdd5dbb 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -45,6 +45,8 @@ struct watchdog_info {
>   #define	WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
>   #define	WDIOF_MAGICCLOSE	0x0100	/* Supports magic close char */
>   #define	WDIOF_PRETIMEOUT	0x0200  /* Pretimeout (in seconds), get/set */
> +#define WDIOF_ALARMONLY		0x0400	/* Watchdog triggers a management or
> +					   other external alarm not a reboot */
>   #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
>
>   #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
>
