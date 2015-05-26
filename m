Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33329 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbbEZUit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 16:38:49 -0400
Received: by iebgx4 with SMTP id gx4so101498969ieb.0
        for <linux-watchdog@vger.kernel.org>; Tue, 26 May 2015 13:38:49 -0700 (PDT)
Message-ID: <5564D9D6.9050309@linaro.org>
Date: Tue, 26 May 2015 14:38:46 -0600
From: Al Stone <al.stone@linaro.org>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v4] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1432335137-1023-1-git-send-email-timur@codeaurora.org> <5564A92F.4090403@linaro.org> <5564B43E.6060504@codeaurora.org>
In-Reply-To: <5564B43E.6060504@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2015 11:58 AM, Timur Tabi wrote:
> On 05/26/2015 12:11 PM, Al Stone wrote:
> 
>> So, this is meant to be SBSA compliant; is it also meant to be SBBR compliant?
>> I suspect not, since there is no ACPI initialization and SBBR requires both
>> UEFI and ACPI.  Is there any reason for not being SBBR compliant?  I'm not
>> saying this is good or bad; I'm only trying to understand the reasoning.
> 
> The driver expects some platform code to read the ACPI tables and initialize a
> platform device.

Ah.  I have to think on that a bit; it sounds reasonable.  I guess I was
wondering about how the DT usage would work vs the ACPI usage and trying
to make them very similar in my head.  That may just give me a headache,
however.

>> I'll also admit that I'm not an expert in ARM timers.  Could I ask a really big
>> favor, please?  When I read the SBSA (section 5.2, specifically), that implies
>> to me that there are two interrupts: a first interrupt for the timer itself set
>> to go off after the timeout expires, and a second interrupt that is required
>> when the timeout expires to force some "executive action".  I only see one IRQ
>> in the patch; what am I missing?
> 
> My driver just uses the first interrupt as a software reset.  The second reset
> is treated as a "backup" hardware reset, in case the software reset didn't work.
> 
> Fu's driver, which I admit is better at handling this, uses the first interrupt
> as an optional pre-timeout that can be used for debugging. The second timeout,
> which is a hardware reset, is the "real" timeout.

Oh, I see.  I think I was misunderstanding the SBSA, too; I saw the word
"signal" and was thinking that had to be an interrupt, which is not correct.

> Note that the ACPI specification for the watchdog device only allows for one
> interrupt to be specified.  For these drivers, we expect the first interrupt
> (WS0) to be specified in the ACPI tables.  We assume that the second timeout
> (WS1) will just cause an immediate hardware reset, without an interrupt.

Right.  I think I've got the mapping now.  Thanks, that helped clarify things
for me.  I appreciate the time spent.

> Also, Fu and I have discussed this, and I think it makes sense to pick up his
> driver instead of mine.  So I'm withdrawing my driver.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
