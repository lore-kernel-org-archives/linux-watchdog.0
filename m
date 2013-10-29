Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:59118 "EHLO
	mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752757Ab3J2N1H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 09:27:07 -0400
Received: from mail645.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo6.mail-out.ovh.net (Postfix) with SMTP id D76BFFF96BF
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Oct 2013 14:27:37 +0100 (CET)
Message-ID: <526FB752.7070708@overkiz.com>
Date: Tue, 29 Oct 2013 14:25:38 +0100
From: boris brezillon <b.brezillon@overkiz.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Landley <rob@landley.net>,
	Russell King <linux@arm.linux.org.uk>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Guenter Roeck <groeck7@gmail.com>,
	Yang Wenyou <wenyou.yang@atmel.com>,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 0/4] watchdog: at91sam9_wdt: handle already configured
 wdt
References: <1380871455-7324-1-git-send-email-b.brezillon@overkiz.com> <20131029075028.GF19704@spo001.leaseweb.com> <526F8E89.30005@overkiz.com> <20131029125848.GB5261@spo001.leaseweb.com>
In-Reply-To: <20131029125848.GB5261@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 29/10/2013 13:58, Wim Van Sebroeck wrote:
> Hi Boris,
>
>> I'm sorry for the inconvenience, but I found some bugs in my patch series:
>>
>> 1) the secs_to_ticks returns an erronous value when 0 is passed as an
>> argument
>> 2) the calculated heartbeat is too small for some use cases
>>      (i.e. kexecing a new kernel might trigger a watchdog reset before
>> the new kernel
>>       is able to load the watchdog driver)
>> 3) when initializing the watchdog driver, the timer should be configured
>> with the min_heartbeat value
>>      instead of the standard heartbeat value, because we don't for how
>> long the timer has been running.
>>
>> I'll send a new patch fixing those issues.
>> I hope it won't bother you :-(.
> No problem :-). Just sent me the fixes when they are ready.

Already done : https://lkml.org/lkml/2013/10/29/207.

Thanks.

Best Regards,

Boris

>
> Kind regards,
> Wim.
>

