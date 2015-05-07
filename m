Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38547 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbbEGPEp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 11:04:45 -0400
Received: by wiun10 with SMTP id n10so63468795wiu.1
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 08:04:44 -0700 (PDT)
Date: Thu, 7 May 2015 16:04:40 +0100
From: Peter Griffin <peter.griffin@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH 02/12] clocksource: sti: Provide support
 for the ST LPC Clocksource IP
Message-ID: <20150507150440.GA13336@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lee,

On Thu, 07 May 2015, Lee Jones wrote:

> This IP is shared with Watchdog and RTC functionality.  Only one of
> these IPs can be used at the same time.  We use the device-driver
> model combined with a DT 'mode' property to enforce this.

Which means my previous assertion in V1 that the IP didn't exist on stih415/6
SoC is most likely wrong, as the watchdog driver has bindings already for those
platforms.

I did try this before and couldn't get it working (driver failed on clk_get_rate)
on stih416-b2020.

Did you try and see if you can get this also working for stih415/6 SoCs? It would
mean we can move away from arm_global_timer for all upstreamed STI platforms.

regards,

Peter.
