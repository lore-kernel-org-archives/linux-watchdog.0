Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33705 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbIKCuM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 10 Sep 2015 22:50:12 -0400
Message-ID: <55F2415C.1050803@roeck-us.net>
Date: Thu, 10 Sep 2015 19:50:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jon Masters <jcm@redhat.com>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
	wim@iguana.be, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
	rjw@rjwysocki.net, dyoung@redhat.com, panand@redhat.com
Subject: Re: [PATCH v7 5/8] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1440435683-7343-1-git-send-email-fu.wei@linaro.org> <1440435683-7343-6-git-send-email-fu.wei@linaro.org> <55F20461.20904@redhat.com>
In-Reply-To: <55F20461.20904@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/10/2015 03:29 PM, Jon Masters wrote:
> On 08/24/2015 01:01 PM, fu.wei@linaro.org wrote:
>
>> +	/*
>> +	 * Get the frequency of system counter from the cp15 interface of ARM
>> +	 * Generic timer. We don't need to check it, because if it returns "0",
>> +	 * system would panic in very early stage.
>> +	 */
>> +	gwdt->clk = arch_timer_get_cntfrq();
>
> Just thinking out loud...
>
> What happens later if we virtualize this device within KVM/QEMU/Xen and
> then live migrate to another system in which the frequency changes?
>

Thinking about it, this scenario would cause severe trouble. I think clocks
(like I would assume pretty much all other hardware parameters / registers)
need to be virtualized and must not change.

Example: clock is set to 100 kHz on original system, and 400 kHz on new
system. Timeout is set to 30s, and registers are programmed accordingly.
User space sends heartbeats every 15 seconds.

In this scenario, the watchdog would time out after 30/4 = 7.5 seconds
on the new system, or in other words almost immediately.

This would be even worse if the original system had a clock of, say,
10 kHz and the new system would use 400 kHz. This just doesn't work.

Guenter

