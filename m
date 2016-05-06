Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52215 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbcEFASo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 May 2016 20:18:44 -0400
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Timur Tabi <timur@codeaurora.org>,
	Pratyush Anand <panand@redhat.com>
References: <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com> <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com> <572A0577.1070000@codeaurora.org>
 <20160504155932.GH13045@dhcppc6.redhat.com> <572A2099.4070901@codeaurora.org>
 <20160505164300.GA16914@roeck-us.net>
 <20160505182031.GB12434@dhcppc6.redhat.com> <572B8F52.2000709@codeaurora.org>
 <572BD8E3.4070707@roeck-us.net> <572BD959.3090507@codeaurora.org>
 <572BDB30.9060602@codeaurora.org>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <572BE2CC.4020606@roeck-us.net>
Date: Thu, 5 May 2016 17:18:20 -0700
MIME-Version: 1.0
In-Reply-To: <572BDB30.9060602@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/05/2016 04:45 PM, Timur Tabi wrote:
> Timur Tabi wrote:
>>
>>> A 32-bit counter is absolutely fine. Letting it run with a 400MHz clock
>>> (or was it 200 MHz ?) is the problem. A resolution of 2.5ns for a
>>> watchdog
>>> timer does not really make any sense.
>>
>> The 10 second limit is based on a 20MHz clock.
>
> No, that's not true.  I misread the code.  I knew something was wrong, but it didn't click until just now.
>
> The default timeout is 10 seconds.  The max timeout on a 20MHz system (which is what we're running) is over 200 seconds.
>
> The problem is that Pratyush's system is running at a clock that's way too fast:
>
>   [  131.187562] sbsa-gwdt sbsa-gwdt.0: Initialized with 40s timeout @ 250000000 Hz, action=1.
>
> 250MHz is unreasonable.  Pratyush, why is your system counter so high? On our ARM64 system, it's set to 20MHz.
>

Guess that answers my earlier question. Problem is that the specification
_permits_ those unreasonable frequencies, and quite obviously they are
being used, no matter if it makes sense or not.

With a (still unreasonable) maximum frequency of 100 MHz, the problem
would not exist. So, if anything, someone with influence on the standard
might suggest to reduce the maximum permitted frequency.

Guenter

