Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:59582 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaCMAA0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 20:00:26 -0400
Message-ID: <5320F516.5080707@roeck-us.net>
Date: Wed, 12 Mar 2014 17:00:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alex Elder <elder@linaro.org>, wim@iguana.be
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: fix ARCH_BCM_MOBILE dependency
References: <1394662322-12445-1-git-send-email-elder@linaro.org>
In-Reply-To: <1394662322-12445-1-git-send-email-elder@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/12/2014 03:12 PM, Alex Elder wrote:
> Starting with this commit:
>      047ef2fa rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource)
> the meaning of the ARCH_BCM config option is changed to represent
> all Broadcom chips with code in the mach-bcm directory.
>
> Configuration options related to specific Broadcom platforms should
> now use another symbol (currently ARCH_BCM_MOBILE, ARCH_BCM2835, or
> ARCH_BCM_5301X).
>
> The BCM_KONA_WDT config option indicates a dependency on ARCH_BCM,
> but it should be ARCH_BCM_MOBILE instead.  Fix that.
>
> Signed-off-by: Alex Elder <elder@linaro.org>

Hi Alex,

Markus Mayer already submitted a similar patch:
	http://patchwork.roeck-us.net/patch/1263/

Guenter



