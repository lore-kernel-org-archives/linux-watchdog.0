Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Guenter Roeck <linux@roeck-us.net>, Pratyush Anand <panand@redhat.com>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, wim@iguana.be,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org
References: <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com> <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com> <572A0577.1070000@codeaurora.org>
 <20160504155932.GH13045@dhcppc6.redhat.com> <572A2099.4070901@codeaurora.org>
 <20160505164300.GA16914@roeck-us.net>
 <20160505182031.GB12434@dhcppc6.redhat.com> <572B8F52.2000709@codeaurora.org>
 <572BD8E3.4070707@roeck-us.net> <572BD959.3090507@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <572BDB30.9060602@codeaurora.org>
Date: Thu, 5 May 2016 18:45:52 -0500
MIME-Version: 1.0
In-Reply-To: <572BD959.3090507@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Timur Tabi wrote:
>
>> A 32-bit counter is absolutely fine. Letting it run with a 400MHz clock
>> (or was it 200 MHz ?) is the problem. A resolution of 2.5ns for a
>> watchdog
>> timer does not really make any sense.
>
> The 10 second limit is based on a 20MHz clock.

No, that's not true.  I misread the code.  I knew something was wrong, 
but it didn't click until just now.

The default timeout is 10 seconds.  The max timeout on a 20MHz system 
(which is what we're running) is over 200 seconds.

The problem is that Pratyush's system is running at a clock that's way 
too fast:

  [  131.187562] sbsa-gwdt sbsa-gwdt.0: Initialized with 40s timeout @ 
250000000 Hz, action=1.

250MHz is unreasonable.  Pratyush, why is your system counter so high? 
On our ARM64 system, it's set to 20MHz.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
