Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lb3-smtp-cloud6.xs4all.net ([194.109.24.31]:44745 "EHLO
	lb3-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752474AbbEKJXD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 May 2015 05:23:03 -0400
Message-ID: <1431336170.2398.73.camel@x220>
Subject: Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as sched
 clock' capability
From: Paul Bolle <pebolle@tiscali.nl>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, devicetree@vger.kernel.org, tglx@linutronix.de,
	wim@iguana.be, a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	linux@roeck-us.net
Date: Mon, 11 May 2015 11:22:50 +0200
In-Reply-To: <55506CB0.2030909@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
		 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
		 <1431074699.13593.4.camel@x220> <20150508093603.GB29044@x1>
		 <1431078730.13593.14.camel@x220> <20150508102938.GD29044@x1>
	 <1431085625.13593.39.camel@x220> <55506CB0.2030909@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2015-05-11 at 10:47 +0200, Daniel Lezcano wrote:
> The general policy is to have non-prompted options in the clocksource's 
> Kconfig and let the platform's config to select the right components.

If you want to stick to that policy here there's no reason to add
CLKSRC_ST_LPC_TIMER_SCHED_CLOCK in this patch. It currently adds
nothing, as it will always be equal to whatever value CLKSRC_ST_LPC will
have, right?


Paul Bolle

