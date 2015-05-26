Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51314 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbEZR6Z (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 May 2015 13:58:25 -0400
Message-ID: <5564B43E.6060504@codeaurora.org>
Date: Tue, 26 May 2015 12:58:22 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Al Stone <al.stone@linaro.org>, linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v4] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1432335137-1023-1-git-send-email-timur@codeaurora.org> <5564A92F.4090403@linaro.org>
In-Reply-To: <5564A92F.4090403@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2015 12:11 PM, Al Stone wrote:

> So, this is meant to be SBSA compliant; is it also meant to be SBBR compliant?
> I suspect not, since there is no ACPI initialization and SBBR requires both
> UEFI and ACPI.  Is there any reason for not being SBBR compliant?  I'm not
> saying this is good or bad; I'm only trying to understand the reasoning.

The driver expects some platform code to read the ACPI tables and 
initialize a platform device.

> I'll also admit that I'm not an expert in ARM timers.  Could I ask a really big
> favor, please?  When I read the SBSA (section 5.2, specifically), that implies
> to me that there are two interrupts: a first interrupt for the timer itself set
> to go off after the timeout expires, and a second interrupt that is required
> when the timeout expires to force some "executive action".  I only see one IRQ
> in the patch; what am I missing?

My driver just uses the first interrupt as a software reset.  The second 
reset is treated as a "backup" hardware reset, in case the software 
reset didn't work.

Fu's driver, which I admit is better at handling this, uses the first 
interrupt as an optional pre-timeout that can be used for debugging. 
The second timeout, which is a hardware reset, is the "real" timeout.

Note that the ACPI specification for the watchdog device only allows for 
one interrupt to be specified.  For these drivers, we expect the first 
interrupt (WS0) to be specified in the ACPI tables.  We assume that the 
second timeout (WS1) will just cause an immediate hardware reset, 
without an interrupt.

Also, Fu and I have discussed this, and I think it makes sense to pick 
up his driver instead of mine.  So I'm withdrawing my driver.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
