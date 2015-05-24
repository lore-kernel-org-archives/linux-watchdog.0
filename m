Return-path: <timur@codeaurora.org>
Message-ID: <5561E7EA.5090702@codeaurora.org>
Date: Sun, 24 May 2015 10:02:02 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>, Guenter Roeck <linux@roeck-us.net>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Wei Fu <tekkamanninja@gmail.com>, G Gregory
 <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
 Hanjun Guo <hanjun.guo@linaro.org>,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org, wim@iguana.be,
 Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
 Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555DFCD4.3040701@codeaurora.org>	<CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>	<5560D7AC.50009@codeaurora.org>	<5560DCB6.3090008@roeck-us.net> <CADyBb7t7+aT=pF0we5umAGXJAJ0njU0zULFAZ-OHVpE0m=ueyg@mail.gmail.com>
In-Reply-To: <CADyBb7t7+aT=pF0we5umAGXJAJ0njU0zULFAZ-OHVpE0m=ueyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Fu Wei wrote:
> If pretimeout concept assumes that there are two timers, I
> misunderstand the "pretimeout", then I will delete the pretimeout
> immediately.

In my opinion, calling panic() on a pre-timeout is not useful, because 
that's really just a normal timeout.  If there were a way to "warn" user 
space that a timeout is about to occur, without a panic or reset, then 
that might be useful.  But as far as I can see, all you're doing is 
redefining the word "timeout".

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
